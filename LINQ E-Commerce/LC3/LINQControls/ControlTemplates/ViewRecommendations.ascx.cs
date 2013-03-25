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
using Telerik.Web.UI;
using System.ComponentModel;
using LinqCommerce;

public partial class LINQControls_ControlTemplates_ViewRecommendations : System.Web.UI.UserControl
{
    [Category("Recommendations Grid Properties")]
    public RadGrid RecommendationsGrid
    {
        get
        {
            return list;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LinqProductAccess lp = new LinqProductAccess();
        list.DataSource = lp.ProductRecommendations();
        list.DataBind();
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
