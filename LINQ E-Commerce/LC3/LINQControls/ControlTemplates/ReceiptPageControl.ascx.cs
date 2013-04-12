using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LinqCommerce;

public partial class LINQControls_ControlTemplates_ReceiptPageControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = LinqShoppingCartAccess.OrderID.ToString();
    }
}
