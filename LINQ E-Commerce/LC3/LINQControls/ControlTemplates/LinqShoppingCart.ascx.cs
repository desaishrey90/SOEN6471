using System;
using System.Configuration;
using System.Linq;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Web.UI;
using LinqCommerce;
using System.Collections.Generic;
using GCheckout.Checkout;
using GCheckout.Util;

public partial class LINQControls_LinqShoppingCart : System.Web.UI.UserControl
{
    #region Public Properties

   
    public LinqShoppingCartAccess ls
    {
        get
        {
            return new LinqShoppingCartAccess();
        }
    }

    public LinqProductAccess lp
    {
        get
        {
          return new LinqProductAccess();
        }
    }

    public LinqOrderAccess lo
    {
        get
        {
          return  new LinqOrderAccess();
        }
    }


    public string CouponName
    {
        get
        {
            return CouponTextBox.Text;
        }
    }

    public decimal Couponamount
    {
        get
        {
            return LinqShoppingCartAccess.CheckCoupon(CouponName);
        }
    }

    public decimal Moneyamount
    {
        get
        {
            return LinqShoppingCartAccess.GetMoneyCoupon(CouponName);
        }
    }

    public decimal Percentamount
    {
        get
        {
            return LinqShoppingCartAccess.GetPercentCoupon(CouponName);
        }
    }


    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        PopulateControls();
    }

    //Show an error if the product is unavailable
    protected void RadGrid1_ItemUpdated(object source, Telerik.Web.UI.GridUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            DisplayMessage(e.Exception.Message);
        }

    }

    //displays grid error message
    private void DisplayMessage(string text)
    {
        RadGrid1.Controls.Add(new LiteralControl(text));
    }

    // create a new lc_Order and redirect to a payment page
    protected void PayPalButton_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            double Amount = CreateSessionVariables();
            //Create lc_Order in system
            if (Profile.UserName != null)
            {
                ls.CreateOrderDetail(Convert.ToInt16(Session["lc_OrderID"]), CouponTextBox.Text, Profile.UserName);
            }
            else
            {
                ls.CreateOrderDetail(Convert.ToInt16(Session["lc_OrderID"]), CouponTextBox.Text, "N/A");

            }
            //Delete Order
            ls.DeleteOrderfromShoppingCart();
            //Send user to Paypal
            PayPalHelper ph = new PayPalHelper();
            Response.Redirect(ph.GetURL(Session["lc_OrderID"].ToString(), Amount.ToString(), PayPalHelper.Payment.PayPal.PayPalEnvironment));
        }
        catch (Exception ex)
        {
            titleLabel.Text = "I am sorry, but there is an issue with the shopping cart using PayPal. Please check back later or use another method of payment.";
        }
        }

    //Creates variables for lc_Order id and amount
    private double CreateSessionVariables()
    {
        //If there is a coupon code in the box, then check to see whether it is valid
        Session["Amount"] = LinqShoppingCartAccess.CheckCoupon(CouponName);
        double Amount = Convert.ToDouble(Session["Amount"]);
        //Create an lc_Order in the lc_Order detail table and save lc_OrderID to session state
        Session["lc_OrderID"] = ls.CreateOrder().ToString();
        return Amount;
    }

    //This method describes the coupon checking process
    protected void CouponButton_Click(object sender, EventArgs e)
    {
        try
        {
            //Check to see if there is a valid coupon
            LinqShoppingCartAccess.CheckCoupon(CouponName);
            //Is it a percent or a dollar discount?
            if (Couponamount.Equals(0))
            {
                statusLabel.Text = "This coupon is not valid. Please ensure its date is valid, the coupon has a value and it was typed in correctly.";
                CouponButton.Enabled = false;

            }
            if (Percentamount > 0)
            {
                statusLabel.Text = String.Format("Coupon for {0:P} applied successfully!", Percentamount);
                CouponButton.Enabled = false;

            }
            if (Moneyamount < 0)
            {
                statusLabel.Text = String.Format("Coupon for {0:c} applied successfully!", Moneyamount);
                CouponButton.Enabled = false;

            }
            //If the coupon is bad, tell the user
            else
            {
                statusLabel.Text = "This coupon is not valid. Please ensure its date is valid, the coupon has a value and it was typed in correctly.";
                CouponButton.Enabled = true;
            }
        }
        //The coupon engine is messed up, better fix it!
        catch
        {
            statusLabel.Text = "Please contact your system admin.";
        }
    }

    // fill shopping cart controls with data
    private void PopulateControls()
    {
        var g = ls.GetAllCartsByID();

        // if the shopping cart is empty...
        if (g.Count() == 0)
        {
            PayPalButton.Enabled = false;
            btnAuthorizeNetCheckout.Enabled = false;
            GCheckoutButton1.Enabled = false;
            ShippingComboBox.Enabled = false;
            titleLabel.Text = "Your shopping cart is empty!";
            RadGrid1.Visible = false;
            CouponButton.Enabled = false;
            CouponTextBox.Enabled = false;
            totalAmountLabel.Text = "Total Amount: " + String.Format("{0:c}", 0);
        }
        else
        // if the shopping cart is not empty...
        {
            // setup controls
            titleLabel.Text = "These are the products in your shopping cart:";
            RadGrid1.Visible = true;
            //LinqShoppingCartAccess.ProfileCheck(statusLabel, PayPalcheckoutButton, btnAuthorizeNetCheckout, Profile);
            LinqShoppingCartAccess.CheckCoupon(CouponName);
            totalAmountLabel.Text = "Total Amount: " + String.Format("{0:c}", Couponamount);
        }
    }

    
    protected void LinqDataSource1_Deleted(object sender, LinqDataSourceStatusEventArgs e)
    {
        PopulateControls();
    }
    
    protected void LinqDataSource1_Updated(object sender, LinqDataSourceStatusEventArgs e)
    {

        PopulateControls();
    }
    
    // handles authorize.net integration
    protected void btnAuthorizeNetCheckout_Click(object sender, EventArgs e)
    {
        try
        {
            #region Create Session Variables Amount, lc_OrderID, Shipping, Tax, AmountTaxShipping
            //If there is a coupon code in the box, then check to see whether it is valid
            Session["Amount"] = LinqShoppingCartAccess.CheckCoupon(CouponName);
            //Create an lc_Order in the lc_Order detail table and save lc_OrderID to session state
            Session["lc_OrderID"] = ls.CreateOrder().ToString();
            Session["Shipping"] = ShippingComboBox.SelectedValue;
            //change MA to Profile.Billing.State for logging in
            Session["Tax"] = ls.AddTax("MA");
            decimal taxPercent = 0;
            decimal shipAmount = 0;
            //In Real Mode, uncomment these lines
            //decimal taxPercent = (LinqShoppingCartAccess.CheckCoupon(CouponName) + Convert.ToDecimal(Session["Shipping"]) * ls.AddTax(Profile.Billing.State));
            //decimal shipAmount = LinqShoppingCartAccess.CheckCoupon(CouponName) + Convert.ToDecimal(Session["Shipping"]);
            Session["AmountTaxShipping"] = shipAmount + taxPercent;


            #endregion
            //switch joseph to Profile.UserName is you're logging in
            ls.CreateOrderDetail(Convert.ToInt16(Session["lc_OrderID"]), CouponTextBox.Text, "joseph");
            Response.Redirect("~/checkout.aspx");
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            titleLabel.Text = "I am sorry, but there is an issue with the shopping cart using checkout through our site. Please use one of the other payment methods or check back later.";
        }
    }
    
    // handles google checkout integration
    protected void GCheckoutButton1_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            double Amount = CreateSessionVariables();
            CheckoutShoppingCartRequest Req = GCheckoutButton1.CreateRequest();
            Req.AddItem("lc_Order ID# : " + Session["lc_OrderID"].ToString(), "Online lc_Order", Session["lc_OrderID"].ToString(), Convert.ToDecimal(Amount), 1);
            Req.ContinueShoppingUrl = PayPalHelper.Payment.PayPal.URLCancel;
            Req.EditCartUrl = PayPalHelper.Payment.PayPal.URLReturn;
            //Delete the cart
            ls.DeleteOrderfromShoppingCart();
            GCheckoutResponse Resp = Req.Send();
            //Report any errors 
            if (Resp.IsGood)
            {
                Response.Redirect(Resp.RedirectUrl, true);
            }
            else
            {
                Response.Write("ResponseXml = " + Resp.ResponseXml + "<br>");
                Response.Write("ErrorMessage = " + Resp.ErrorMessage + "<br>");
            }
            //Delete lc_Order
        }
        catch (Exception ex)
        {
            titleLabel.Text = "I am sorry, but there is an issue with the shopping cart using Google Checkout. Please check back later or use another payment method.";
        }
    }

}

