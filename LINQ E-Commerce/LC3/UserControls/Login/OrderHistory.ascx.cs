using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class UserControls_Login_lc_OrderHistory : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void LinqDataSource1_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var query = from o in db.lc_OrderDetails
                    where o.UserName == Profile.UserName
                    join or in db.lc_Orders on o.OrderID equals or.OrderID
                    select new
                    {
                        o.Color,
                        o.CouponCode,
                        o.OrderID,
                        o.ProductID,
                        o.ProductName,
                        o.Quantity,
                        o.Size,
                        o.Subtotal,
                        o.UnitCost,
                        o.UserName,
                        or.DateShipped,
                        or.DateCreated
                    };
        e.Result = query;
    }
}
