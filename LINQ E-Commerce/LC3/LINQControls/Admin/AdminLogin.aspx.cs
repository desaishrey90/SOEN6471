using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LINQControls_Admin_AdminLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnlogin_Click(object sender, EventArgs e)
    {
        if (txtusername.Text == "Admin" && txtpassword.Text == "Admin")
        {
            Session["UName"] = txtusername.Text;
            Response.Redirect("CatalogAdmin.aspx");
        }
    }
}