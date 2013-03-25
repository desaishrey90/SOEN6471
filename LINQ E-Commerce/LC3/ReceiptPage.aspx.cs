using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LinqCommerce;

public partial class ReceiptPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //If lc_Order was successful
        if (Request.QueryString["PayPal"] == "Success")
        {
            CompleteMyOrder();
            //Show lc_OrderID on page for confirmation
            lc_OrderIDLabel.Text = "Order Processed Successfully! You will receive an e-mail soon with your lc_OrderID. For your records, your lc_Order ID is: " + Session["lc_OrderID"].ToString();
        }
        if (Request.QueryString["Message"].Length > 0)
        {
            CompleteMyOrder();
            lc_OrderIDLabel.Text = Request.QueryString["Message"].ToString();
        }
    }

    private void CompleteMyOrder()
    {
        //Delete the shopping cart lc_Order
        LinqShoppingCartAccess ls = new LinqShoppingCartAccess();
        ls.DeleteOrderfromShoppingCart();


        //Remove all session variables

        Session.Remove("lc_OrderID");
        Session.Remove("Amount");
        Session.Remove("Shipping");
        Session.Remove("Tax");
        Session.Remove("AmountTaxShipping");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Catalog.aspx");
    }
}
