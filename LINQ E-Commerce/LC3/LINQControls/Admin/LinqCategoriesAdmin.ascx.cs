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
using LinqCommerce;

public partial class UserControls_CategoriesAdmin : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BacktoDepts.NavigateUrl = "~/LinqControls/Admin/CatalogAdmin.aspx";
        BacktoDepts.Text = "Back to Departments";

    }
    protected void LinqDataSource1_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {        
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var query = from c in db.lc_Categories
                    where c.DepartmentID == LinqProductAccess.DepartmentID
                    select c;
        e.Result = query.ToList();
    }
    protected void InsertButton_Click(object sender, EventArgs e)
    {
        if (NameTextBox.Text != String.Empty)
        {
            try
            {
                int DepartmentID = Convert.ToInt32(Request.QueryString["DepartmentID"].ToString());
                LinqCommerceDataContext db = new LinqCommerceDataContext();
                lc_Category c = new lc_Category();
                c.DepartmentID = DepartmentID;
                c.Name = NameTextBox.Text;
                c.Description = DescriptionTextBox.Text;
                db.lc_Categories.InsertOnSubmit(c);
                db.SubmitChanges();
                RadGrid1.Rebind();
                statusLabel.Visible = true;
                statusLabel.Text = "Category inserted successfully!";
            }
            catch
            {
                statusLabel.Visible = true;
                statusLabel.Text = "Insert failed! Contact your system admin.";

            }
        }
        else
        {
            statusLabel.Visible = true;
            statusLabel.Text = "Insert failed. You must include a category name.";

        }
    }
}
