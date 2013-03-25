using System;
using System.Web.UI;
using LinqCommerce;
using System.Web.Configuration;

public partial class CatalogAdmin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SectionConfigurationGroup s = (SectionConfigurationGroup)WebConfigurationManager.GetSection("LinqCommerce/SiteSettings");
        this.Title = s.ShoppingCartSettings.SiteName + " : Catalog Admin : ";
        
        //load appropriate control into place holder

        if (LinqProductAccess.DepartmentID > 0 && LinqProductAccess.CategoryID < 1 && LinqProductAccess.ProductID < 1)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/LinqCategoriesAdmin.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
        else if (LinqProductAccess.DepartmentID > 0 && LinqProductAccess.CategoryID > 0 && LinqProductAccess.ProductID < 1)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/LinqProductsAdmin.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
        else if (LinqProductAccess.CatalogAdmin == 3)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/LinqProductsAdminAll.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
        else if (LinqProductAccess.CatalogAdmin == 4)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/ReviewsAdmin.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
        else if (LinqProductAccess.CatalogAdmin == 5)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/LinqProductsAdminAll.ascx");
            adminPlaceHolder.Controls.Add(c);
        }
        else if (LinqProductAccess.CatalogAdmin == 6)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/AddProduct.ascx");
            adminPlaceHolder2.Controls.Add(c);
        }

        else if (LinqProductAccess.CatalogAdmin == 8)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/Linqdigitalproductadmin.ascx");
            adminPlaceHolder.Controls.Add(c);

        }

        else if (LinqProductAccess.CatalogAdmin == 2 && LinqProductAccess.ProductID > 0)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/LinqProductDetailsAdmin.ascx");
            adminPlaceHolder2.Controls.Add(c);
        }
        else if (LinqProductAccess.CatalogAdmin == 7 && LinqProductAccess.ProductID > 0)
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/LinqProductCategoriesAdmin.ascx");
            adminPlaceHolder2.Controls.Add(c);
        }
        else
        {
            Control c = Page.LoadControl("~/LinqControls/Admin/LinqDepartmentsAdmin.ascx");
            adminPlaceHolder.Controls.Add(c);
        }

    }
}
