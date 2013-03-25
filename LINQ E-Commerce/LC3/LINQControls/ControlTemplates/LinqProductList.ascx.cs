using System;
using System.Linq;
using System.Data.Linq.SqlClient;
using Telerik.Web.UI;
using System.ComponentModel;
using LinqCommerce;

public partial class LINQControls_LinqProductList : System.Web.UI.UserControl
{
    [Category("Product List Properties")]
    public RadGrid ProductList
    {
        get
        {
            return list;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        PopulateControls();
    }

    private void PopulateControls()
    {
        LinqProductAccess lp = new LinqProductAccess();
        //Get Database
        LinqCommerceDataContext db = new LinqCommerceDataContext();

        //Search for products
        if (LinqProductAccess.Search != null && LinqProductAccess.DepartmentID.Equals(0) && LinqProductAccess.CategoryID.Equals(0))
        {
            list.DataSource = lp.SearchProduct();
            list.DataBind();

        }

        //Retrieve a list of products based on newest products
        else if (LinqProductAccess.NewestProducts != null)
        {
            list.DataSource = lp.NewestProductsQuery();
            list.DataBind();
        }

        // Retrieve list of products on catalog promotion if no department or category is specified
        else if (LinqProductAccess.DepartmentID.Equals(0) && LinqProductAccess.CategoryID.Equals(0))
        {
            list.DataSource = lp.OnCatalogPromotion();
            list.Rebind();
            TitleLabel.Text = "On Catalog Promotion";

        }
        // Retrieve list of products on department promotion, if a department if specified
        else if (LinqProductAccess.DepartmentID.Value > 0 && LinqProductAccess.CategoryID.Equals(0))
        {
            list.DataSource = lp.OnDepartmentPromotion();
            list.Rebind();
            TitleLabel.Text = lp.GetDepartment().Name;
            DescriptionLabel.Text = lp.GetDepartment().Description;
        }
        // Retrieve list of products in a category, if a category and a department are specified
        else if (LinqProductAccess.DepartmentID.Value > 0 && LinqProductAccess.CategoryID.Value > 0)
        {
            
            list.DataSource = lp.GetProductsInCategory();
            list.DataBind();
            TitleLabel.Text = lp.GetCategory().Name;
            DescriptionLabel.Text = lp.GetCategory().Description;


        }

    }

}
