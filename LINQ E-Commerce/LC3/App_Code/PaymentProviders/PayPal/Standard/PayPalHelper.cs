using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LinqCommerce;
using System.Configuration;
using System.Web.Configuration;

namespace LinqCommerce
{
    /// <summary>
    /// Handles all code for PayPal Transactions
    /// </summary>
   
    public class PayPalHelper
    {
        /// <summary>
        /// Gets payment info
        /// </summary>
        public static SectionConfigurationGroup Payment
        {
            get
            {
                return (SectionConfigurationGroup)ConfigurationManager.GetSection(
                "LinqCommerce/Payment");
            }
        }

        /// <summary>
        /// Gets site settings
        /// </summary>
        public static SectionConfigurationGroup SiteSettings
        {
            get
            {
                return (SectionConfigurationGroup)WebConfigurationManager.GetSection("LinqCommerce/SiteSettings");
            }
        }



        public PayPalHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        /// <summary>
        /// Gets URL to send to PayPal
        /// </summary>
        /// <param name="OrderID"></param>
        /// <param name="Amount"></param>
        /// <param name="LiveOrSandBox"></param>
        /// <returns></returns>
        public string GetURL(string OrderID, string Amount, string LiveOrSandBox)
        {
            string PayPalBaseUrl = GetBaseURL(LiveOrSandBox);
            // Send the OrderID and other info to PayPal

            // Create the PayPal redirect location
            string redirect = "";
            redirect += PayPalBaseUrl;
            redirect += "cmd=_xclick";
            redirect += "&business=" + Payment.PayPal.PayPalEMailAccount;
            redirect += "&item_name=" + SiteSettings.ShoppingCartSettings.SiteName;
            redirect += "&item_number=" + OrderID;
            redirect += "&amount=" + String.Format("{0:f2}", Amount);
            redirect += "&currency=USD";
            redirect += "&upload=1";
            redirect += "&cpp_header_image=" + Payment.PayPal.PayPayHeaderImage;
            redirect += "&return=" + Payment.PayPal.URLReturn;
            redirect += "&cancel_return=" + Payment.PayPal.URLCancel;
            // Redirect to the payment page
            return redirect;
        }

        public string GetBaseURL(string LiveOrSandBox)
        {
            string PayPalBaseUrl = "";
            if (LiveOrSandBox.ToLower() == "live")
            {
                return PayPalBaseUrl = "https://www.paypal.com/cgi-bin/webscr?";
            }
            if (LiveOrSandBox.ToLower() == "sandbox")
            {
                return PayPalBaseUrl = "https://www.sandbox.paypal.com/us/cgi-bin/webscr?";
            }
            else
            {
                return "";
            }
        }
    }
}
