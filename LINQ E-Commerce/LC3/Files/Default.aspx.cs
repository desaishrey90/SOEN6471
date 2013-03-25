using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LinqCommerce;
using System.Web.Configuration;

public partial class Files_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SectionConfigurationGroup config = (SectionConfigurationGroup)WebConfigurationManager.GetSection("LinqCommerce/Payment");
        Response.Write(config.PayPal.UserID);

    }
}
