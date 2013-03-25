using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using LinqCommerce;

public partial class LINQControls_Admin_AddInventory : System.Web.UI.UserControl
{
    private LinqInventoryAccess li
    {
        get
        {
            return new LinqInventoryAccess();
        }
    }

    private int ProductID
    {
        get
        {
            return int.Parse((ProductDropDown.SelectedValue));
        }
    }

    public int Quantity
    {
        get
        {
            if (!String.IsNullOrEmpty(QuantityTextBox.Text))
            {
                return int.Parse(QuantityTextBox.Text);
            }
            else
            {
                return 0;
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ErrorLabel.Visible = false;
    }

    /// <summary>
    /// Inserts a product, test whether it is colorable or sizeable
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnInsert_Click(object sender, EventArgs e)
    {
        if (Quantity > 0)
        {
            #region If both dropdowns are disabled
            if (ColorDropDown.Enabled == false && SizeDropDown.Enabled == false)
            {
                //If the product exists in inventory, then just update its quantity
                lc_ProductInventory p = li.GetProductSizeColor(ProductID, "None", "None");
                if (p != null)
                {
                    li.UpdateQuantity(ProductID, "None", "None", Quantity);
                }
                else
                {
                    li.InsertProductIntoInventory(Convert.ToInt16(ProductDropDown.SelectedValue), "None", "None", Convert.ToInt16(QuantityTextBox.Text), Convert.ToInt16(SellerDropDown.SelectedValue));
                }
            }
            #endregion

            #region If the size is disabled
            else if (SizeDropDown.Enabled == false)
            {
                lc_ProductInventory p = li.GetProductSizeColor(ProductID, ColorDropDown.Text, "None");
                if (p != null)
                {
                    li.UpdateQuantity(ProductID, ColorDropDown.Text, "None", Quantity);
                }
                else
                {
                    li.InsertProductIntoInventory(Convert.ToInt16(ProductDropDown.SelectedValue), ColorDropDown.Text, "None", Convert.ToInt16(QuantityTextBox.Text), Convert.ToInt16(SellerDropDown.SelectedValue));
                }
            }
            #endregion

            #region If the color is disabled
            else if (ColorDropDown.Enabled == false)
            {
                lc_ProductInventory p = li.GetProductSizeColor(ProductID, "None", SizeDropDown.Text);
                if (p != null)
                {
                    li.UpdateQuantity(ProductID, ColorDropDown.Text, "None", Quantity);
                }
                else
                {
                    li.InsertProductIntoInventory(Convert.ToInt16(ProductDropDown.SelectedValue), "None", SizeDropDown.Text, Convert.ToInt16(QuantityTextBox.Text), Convert.ToInt16(SellerDropDown.SelectedValue));
                }
            }
            #endregion

            #region If they're both enabled
            else
            {
                //If the product exists in inventory, then just update its quantity
                lc_ProductInventory p = li.GetProductSizeColor(ProductID, ColorDropDown.Text, SizeDropDown.Text);
                if (p != null)
                {
                    li.UpdateQuantity(ProductID, ColorDropDown.Text, SizeDropDown.Text, Quantity);
                }
                else
                {
                    li.InsertProductIntoInventory(Convert.ToInt16(ProductDropDown.SelectedValue), ColorDropDown.Text, SizeDropDown.Text, Convert.ToInt16(QuantityTextBox.Text), Convert.ToInt16(SellerDropDown.SelectedValue));
                }
            }
            #endregion
            ErrorLabel.Visible = true;
            ErrorLabel.Text = "Record inserted successfully!";
        }
        else
        {
            ErrorLabel.Visible = true;
            ErrorLabel.Text = "Please insert a quantity!";
        }
    }

    /// <summary>
    /// If the product doesn't isn't sizeable or colorable, then disable the appropriate dropdown
    /// </summary>
    /// <param name="o"></param>
    /// <param name="e"></param>
    protected void ProductDropDown_SelectedIndexChanged(object o, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (LinqProductAccess.IsProductColorable(ProductID) == false)
        {
            ColorDropDown.Enabled = false;
        }
        if (LinqProductAccess.IsProductSizeable(ProductID) == false)
        {
            SizeDropDown.Enabled = false;
        }
    }
}
