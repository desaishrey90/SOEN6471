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

public partial class Admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Convert.ToString(Session["UName"])))
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Convert.ToString(Session["UName"])))
        {
            Session.RemoveAll();

            Session.Abandon();
            
            Response.Redirect("AdminLogin.aspx");
        }
    }
}
