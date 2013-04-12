using System;
using System.Linq;
using Telerik.Web.UI;
using System.ComponentModel;
using LinqCommerce;

public partial class LINQControls_ControlTemplates_LINQDepartCatList : System.Web.UI.UserControl
{
    [Category("Department and Categories List Properties")]
    public RadGrid DepartmentsList
    {
        get
        {
            return list;
        }
    }

    [Category("Department and Categories List Properties")]
    public RadGrid CategoriesList
    {
        get
        {
            return list2;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        LinqProductAccess lp = new LinqProductAccess();
        list.DataSource = lp.GetDepartments();
        list.DataBind();
        brLabel.Text = "<br />";
        if (LinqProductAccess.DepartmentID.Value > 0)
        {
            list2.DataSource = lp.GetCategories();
            list2.DataBind();
        }
        else if (LinqProductAccess.DepartmentID.Equals(0))
        {
            brLabel.Text = "<br />";
            list2.Visible = false;
        }
    }
}
