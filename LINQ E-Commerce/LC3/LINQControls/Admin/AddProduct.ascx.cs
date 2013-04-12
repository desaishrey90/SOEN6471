using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LinqCommerce;

public partial class LINQControls_Admin_AddProduct : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Button1.Click += new EventHandler(Button1_Click);
        Button2.Click += new EventHandler(Button2_Click);
        if (LinqProductAccess.ProductID > 0)
        {
            LinqProductAccess lp = new LinqProductAccess();
            NameRadTextBox.Text = lp.GetProduct().Name;
            DescriptionRadEditor.Content = lp.GetProduct().Description;
            PriceRadNumericTextBox.Text = lp.GetProduct().Price.ToString();
            OnDeptCheckBox.Checked = lp.GetProduct().OnDepartmentPromotion;
            OnCatCheckBox.Checked = lp.GetProduct().OnCatalogPromotion;
            SizeCheckBox.Checked = lp.GetProduct().Sizeable;
            ColorCheckBox.Checked = lp.GetProduct().Colorable;
        }

    }

    void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/LinqControls/Admin/CatalogAdmin.aspx?CatalogAdmin=3");
    }

    void Button1_Click(object sender, EventArgs e)
    {
        LinqProductAccess lp = new LinqProductAccess();
        if (LinqProductAccess.ProductID > 0)
        {
            lp.EditProduct(Convert.ToInt16(Request.QueryString["ProductID"]), (Convert.ToDecimal(PriceRadNumericTextBox.Text)), OnDeptCheckBox.Checked,
    OnCatCheckBox.Checked, NameRadTextBox.Text, ColorCheckBox.Checked, SizeCheckBox.Checked,
    DescriptionRadEditor.Content);
            MessageLabel.Text = "Record updated successfully!";

        }
        else
        {
            lp.AddProduct((Convert.ToDecimal(PriceRadNumericTextBox.Text)), OnDeptCheckBox.Checked,
    OnCatCheckBox.Checked, NameRadTextBox.Text, ColorCheckBox.Checked, SizeCheckBox.Checked,
    DescriptionRadEditor.Content);
            MessageLabel.Text = "Record submitted successfully!";
        }
    }
}
