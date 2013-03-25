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

public partial class ViewRecommendations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int? ProductID = Convert.ToInt32(Request.QueryString["ProductID"]);
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var rn = from r in db.lc_Recommendations
                 where r.ProductID == ProductID
                 select r;
    }
    protected void ReviewFormbtn_Click(object sender, EventArgs e)
    {
        string ProductID = Request.QueryString["ProductID"];
        Response.Redirect("~/InsertReview.aspx?ProductID=" + ProductID);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string ProductID = Request.QueryString["ProductID"];
        Response.Redirect("~/Product.aspx?ProductID=" + ProductID);
    }
}
