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

/// <summary>
/// Copyright 2008 - XDev Software, LLC
/// Use this code at your own risk. XDev Software is not responsible 
/// for any damage that may come from using this code.  This code is provided as is.
/// </summary>
public partial class IPNProcess : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ////used for debugging purposes
        //foreach(string key in Request.Form)
        //{
        //    Response.Write(key + " = " + Request.Form[key] + "<br />");
        //}
    
        PPIPN objPP = new PPIPN("test");

        objPP.FromEmail = "test@mysite.com"; //email address your smtp server will accept
        objPP.FromEmailPassword = "test"; //password for the email address above
        objPP.SmtpHost = "smtp.mysite.com";
        objPP.SmtpPort = "587";
        objPP.ToEmail = "donotreply@mysite.com";//this needs to be your business/email you have registered with PayPal
        objPP.MakeHttpPost();
        objPP.CheckStatus();

        
    }
}
