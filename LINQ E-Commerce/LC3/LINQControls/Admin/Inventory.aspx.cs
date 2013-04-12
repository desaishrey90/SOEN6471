using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LinqCommerce;

public partial class LINQControls_Admin_Inventory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (LinqProductAccess.Inventory == 2)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/AddInventory.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
        else if (LinqProductAccess.Inventory == 3)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/AddSeller.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
        else
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/ShowProductInventory.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
    }
}
