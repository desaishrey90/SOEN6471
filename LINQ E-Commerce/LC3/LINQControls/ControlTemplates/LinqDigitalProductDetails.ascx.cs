using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GCheckout.Checkout;
using GCheckout.Util;
using LinqCommerce;
using System.Web.Configuration;

public partial class LINQControls_ControlTemplates_LinqDigitalProductDetails : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void GCheckoutButton1_Click(object sender, ImageClickEventArgs e)
    {
        LinqCommerce.LinqProductAccess lp = new LinqCommerce.LinqProductAccess();
        List<lc_DigitalProduct> l = lp.GetDigitalProduct(LinqCommerce.LinqProductAccess.ProductID);
        foreach (lc_DigitalProduct lc in l)
        {
            DoCheckout(lc.URL, lc.lc_Product.Name, "", lc.lc_Product.Price);
        }

    }

    private void DoCheckout(string ProductURL, string Name, string Description, decimal Amount)
    {
        SectionConfigurationGroup s = (SectionConfigurationGroup)WebConfigurationManager.GetSection("LinqCommerce/SiteSettings");
        DigitalItem item = new DigitalItem("", ProductURL, "This product is available for electronic download. Please download it at the link below.");
        CheckoutShoppingCartRequest Req = GCheckoutButton1.CreateRequest();
        Req.AddItem(Name, Description, Convert.ToDecimal(Amount), 1, item);
        Req.ContinueShoppingUrl = s.ProductSettings.DigitalCancelURL;
        Req.EditCartUrl = s.ProductSettings.DigitalReturnURL;
        GCheckoutResponse Resp = Req.Send();
        //Report any errors 
        if (Resp.IsGood)
        {
            Response.Redirect(Resp.RedirectUrl, true);
        }
        else
        {
            Response.Write("ResponseXml = " + Resp.ResponseXml + "<br>");
            Response.Write("ErrorMessage = " + Resp.ErrorMessage + "<br>");
        }

    }

}
