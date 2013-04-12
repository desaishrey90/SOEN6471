using System;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Data.Linq;
using Telerik.Web.UI;
using System.IO;
using System.Drawing.Imaging;
using System.Linq;
using LinqCommerce;

public partial class LINQControls_Admin_LinqProductCategoriesAdmin : System.Web.UI.UserControl
{


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LinqProductAccess lp = new LinqProductAccess();
            lblProductName.Text = lp.GetProduct().Name;
        }
    }
 
    /// <summary>
    /// Add the product to the selected category
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddCategory_Click(object sender, EventArgs e)
    {
        LinqProductAccess lp = new LinqProductAccess();
        try
        {
            lp.AddProductCategory(LinqProductAccess.ProductID, Convert.ToInt32(CategoriesDDL.SelectedValue));
            ProductCategoryRadGrid.Rebind();
        }
        catch
        {
            statusLabel.Text = "The product already belongs to this category.";
            statusLabel.CssClass = "warning";
        }
    }
}
