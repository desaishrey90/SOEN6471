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
using LinqCommerce;

public partial class LINQControls_Admin_LinqProductsAdminAll : System.Web.UI.UserControl
{
    public string ProductImagePath = ""; 

    protected void Page_Load(object sender, EventArgs e)
    {
        SectionConfigurationGroup s =
    (SectionConfigurationGroup)ConfigurationManager.GetSection("LinqCommerce/SiteSettings");
        ProductImagePath = s.ProductSettings.ProductImagePath;
    }
}
