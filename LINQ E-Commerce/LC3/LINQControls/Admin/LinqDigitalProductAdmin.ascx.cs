using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LINQControls_Admin_LinqDigitalProductAdmin : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void LinqDataSource1_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var query = from a in db.lc_DigitalProducts
                    orderby a.lc_Product.Name ascending
                    select a;
        e.Result = query;
    }
    protected void LinqDataSource1_Inserting(object sender, LinqDataSourceInsertEventArgs e)
    {
        lc_DigitalProduct l = (lc_DigitalProduct)e.NewObject;
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var query = from a in db.lc_DigitalProducts
                    where a.ProductID == l.ProductID
                    select a;
        if (query.Count() > 0)
        {
            e.Cancel = true;
            errorLbl.Visible = true;
            errorLbl.Text = "That product already exists in the digital product database.";
        }
    }
}
