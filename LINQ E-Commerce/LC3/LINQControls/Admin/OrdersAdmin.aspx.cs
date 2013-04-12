using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using LinqCommerce;

public partial class OrdersAdmin : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
      if (LinqProductAccess.OrdersAdmin == 2)
      {
          Control c = Page.LoadControl("~/LinqControls/Admin/LinqCouponAdmin.ascx");
          adminPlaceHolder.Controls.Add(c);
      }
      else if (LinqProductAccess.OrdersAdmin == 1)
      {
          Control c = Page.LoadControl("~/LinqControls/Admin/LinqShoppingCartAdmin.ascx");
          adminPlaceHolder.Controls.Add(c);
      }
      else if (LinqProductAccess.OrdersAdmin == 3)
      {
          Control c = Page.LoadControl("~/LinqControls/Admin/LinqTaxAdminAll.ascx");
          adminPlaceHolder.Controls.Add(c);
      }
      else
      {
          Control c = Page.LoadControl("~/LinqControls/Admin/LinqOrdersAdmin.ascx");
          adminPlaceHolder.Controls.Add(c);
      }
  }

}
