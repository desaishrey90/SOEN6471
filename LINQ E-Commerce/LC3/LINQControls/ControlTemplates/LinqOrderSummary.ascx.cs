using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LinqCommerce;

public partial class LINQControls_ControlTemplates_Linqlc_OrderSummary : System.Web.UI.UserControl
{
    public string ShowAmount
    {
        get
        {
            return totalAmountLabel.Text;
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LinqShoppingCartAccess ls = new LinqShoppingCartAccess();
        LinqProductAccess lp = new LinqProductAccess();
        string b = String.Format("{0:C}", Convert.ToDecimal(LinqShoppingCartAccess.Amount));
        ItemsLabel.Text = b;
        string a = String.Format("{0:C}", Convert.ToDecimal(LinqShoppingCartAccess.Shipping));
        ShippingAmountLabel.Text = a;
        string c = String.Format("{0:P}", Convert.ToDecimal(LinqShoppingCartAccess.Tax));
        TaxLabel.Text = Profile.Billing.State + " Sales Tax: " + c;
        string s = String.Format("{0:C}", ls.AddTaxShipAmount());
        totalAmountLabel.Text = s;
    }

    
}
