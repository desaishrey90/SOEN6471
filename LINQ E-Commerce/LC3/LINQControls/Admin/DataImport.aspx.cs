using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LINQControls_Admin_DataImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string Import = Request.QueryString["Import"].ToString();
        if (Import == "XML")
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/XMLImport.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
        if(Import == "Excel")
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/ExcelImport.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
    }
}
