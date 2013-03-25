using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using LinqCommerce;

public partial class LINQControls_ControlTemplates_WishList : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SetTitleLabel();
        GetWishList();
        //InStock();
    }

    private void SetTitleLabel()
    {
        WishListLabel.Text = Profile.FirstName + " " + Profile.LastName + "'s " + "Wish List";
    }

    

    private void GetWishList()
    {
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var query = from w in db.lc_WishLists
                    select new
                    {
                        ProductID = w.ProductID,
                        Image1FileName = w.lc_Product.Image1FileName,
                        Name = w.lc_Product.Name,
                        DateAdded = w.DateAdded.ToShortDateString(),
                        Price = w.lc_Product.Price.ToString(),
                        Description = w.lc_Product.Description,
                        Color = w.lc_ColorTable.Color,
                        Size = w.lc_SizeTable.Size,
                    };
        list.DataSource = query;
        list.DataBind();
    }
    
    ////Occurs when any button is clicked in the DataList control. 

    protected void list_ItemCommand(object source, GridCommandEventArgs e)
    {
        LinqCommerceDataContext db = new LinqCommerceDataContext();

        if (e.CommandName == "Insert")
        {
            try
            {

                string ProductID = e.CommandArgument.ToString();
                int PID = Convert.ToInt32(ProductID);
                //LinqCommerceDataContext db = new LinqCommerceDataContext();
                lc_WishList w = (from wi in db.lc_WishLists
                              where wi.ProductID == Convert.ToInt32(ProductID)
                              select wi).First();

                if (LinqProductAccess.QuantityInStock(PID, w.lc_SizeTable.Size, w.lc_ColorTable.Color) > 0)
                {
                    lc_ShoppingCart s = new lc_ShoppingCart
                    {
                        CartID = LinqShoppingCartAccess.cartID,
                        ProductID = Convert.ToInt32(ProductID),
                        Price = w.lc_Product.Price,
                        DateAdded = System.DateTime.Today,
                        Quantity = 1,
                        //Size = w.lc_SizeTable.Size,
                        //Color = w.lc_ColorTable.Color,

                    };

                    db.lc_ShoppingCarts.InsertOnSubmit(s);
                    db.lc_WishLists.DeleteOnSubmit(w);
                    db.SubmitChanges();
                    list.Rebind();
                    Response.Redirect(@"~\ShoppingCart.aspx");

                }
                else
                {
                    ErrorLabel.Visible = true;
                    ErrorLabel.Text = w.lc_Product.Name + " is out of stock";
                }
            }
            catch(Exception ex)
            {
                ErrorLabel.Visible = true;
                ErrorLabel.Text = "This item has already been added to your cart.";
            }
        }
        
    }
    protected void list_DeleteCommand(object source, GridCommandEventArgs e)
    {
        string ProductID = e.CommandArgument.ToString();
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        lc_WishList w = (from wi in db.lc_WishLists
                      where wi.ProductID == Convert.ToInt32(ProductID)
                      select wi).SingleOrDefault();
        db.lc_WishLists.DeleteOnSubmit(w);
        db.SubmitChanges();
        GetWishList();
    }
}
