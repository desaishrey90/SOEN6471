using System;
using System.Configuration;
using System.Linq;
using System.Web.UI.WebControls;
using LinqCommerce;

public partial class UserControls_ProductsAdmin : System.Web.UI.UserControl
{

    public string ProductImagePath = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        SectionConfigurationGroup s =
    (SectionConfigurationGroup)ConfigurationManager.GetSection("LinqCommerce/SiteSettings");
        ProductImagePath = s.ProductSettings.ProductImagePath;
    }


    protected void LinqDataSource1_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var query = db.GetAllProductsInCategory(LinqProductAccess.CategoryID);
        e.Result = query.ToList();
    }
}
