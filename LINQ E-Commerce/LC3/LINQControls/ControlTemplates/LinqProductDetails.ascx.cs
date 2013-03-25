using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Linq;
using System.Web;
//using Telerik.Cms.Web.UI; // need to include this if you want to drop into Sitefinity
using Telerik.Web.UI;
using LinqCommerce;

public partial class LINQControls_ProductDetails : System.Web.UI.UserControl
{
    #region Public Properties
    public string productImagesPath;
    
    public string PageShoppingCart = "~/ShoppingCart.aspx";
    public string PageProductCatalog = "~/Catalog.aspx";
    public string PageInsertReview = "~/InsertReview.aspx";
    public string PageViewRecommendations = "~/ViewRecommendations.aspx";

    // Sitefinity URL Params 
    // If using Sitefinity you can comment the hard coded properties above and uncomment 
    // the properties below and they can then be set when adding control to a page.
    /*
    /// <summary>  
    /// Gets or sets the page containing LinqShoppingCart control.  
    /// </summary>  
    [WebEditor("Telerik.Cms.Web.UI.UrlEditorWrapper, Telerik.Cms"),
     Category("Redirect Urls"),
     DisplayName("Shopping Cart Page"),
     Description("The page in your Sitefinity site that contains the LinqShoppingCart user control.")]
    public virtual string PageShoppingCart
    {
        get
        {
            object obj = this.ViewState["PageShoppingCart"];
            if (obj != null)
                return (string)obj;
            return "~/ShoppingCart.aspx"; // default page
        }
        set
        {
            this.ViewState["PageShoppingCart"] = value;
        }
    }

    /// <summary>  
    /// Gets or sets the page containing LinqProductList control.  
    /// </summary>  
    [WebEditor("Telerik.Cms.Web.UI.UrlEditorWrapper, Telerik.Cms"),
     Category("Redirect Urls"),
     DisplayName("Product Catalog Page"),
     Description("The page in your Sitefinity site that contains the LinqProductList user control.")]
    public virtual string PageProductCatalog
    {
        get
        {
            object obj = this.ViewState["PageProductCatalog"];
            if (obj != null)
                return (string)obj;
            return "~/Catalog.aspx"; // default page
        }
        set
        {
            this.ViewState["PageProductCatalog"] = value;
        }
    }

    /// <summary>  
    /// Gets or sets the page containing RecommendationsForm control.  
    /// </summary>  
    [WebEditor("Telerik.Cms.Web.UI.UrlEditorWrapper, Telerik.Cms"),
     Category("Redirect Urls"),
     DisplayName("Insert Review Page"),
     Description("The page in your Sitefinity site that contains the RecommendationsForm user control.")]
    public virtual string PageInsertReview
    {
        get
        {
            object obj = this.ViewState["PageInsertReview"];
            if (obj != null)
                return (string)obj;
            return "~/InsertReview.aspx"; // default page
        }
        set
        {
            this.ViewState["PageInsertReview"] = value;
        }
    }

    /// <summary>  
    /// Gets or sets the page containing ViewRecommendations control.  
    /// </summary>  
    [WebEditor("Telerik.Cms.Web.UI.UrlEditorWrapper, Telerik.Cms"),
     Category("Redirect Urls"),
     DisplayName("Recommendations Page"),
     Description("The page in your Sitefinity site that contains the ViewRecommendations user control.")]
    public virtual string PageViewRecommendations
    {
        get
        {
            object obj = this.ViewState["PageViewRecommendations"];
            if (obj != null)
                return (string)obj;
            return "~/ViewRecommendations.aspx"; // default page
        }
        set
        {
            this.ViewState["PageViewRecommendations"] = value;
        }
    }
    */
    #endregion

    // ToDo - Instead of Continue Shopping button, after clicking add to cart, display js popup with checkout or continue buttons
    protected void Page_Load(object sender, EventArgs e)
    {
        SectionConfigurationGroup s =
            (SectionConfigurationGroup)ConfigurationManager.GetSection("LinqCommerce/SiteSettings");
        productImagesPath = s.ProductSettings.ProductImagePath;
        if (!Page.IsPostBack)
        {
            if (LinqProductAccess.ProductID > 0)
            {
                BindProductData();
            }
            else
            {
                pnlProductDetails.Visible = false;
                pnlErrorMessage.Visible = true;
            }
        }
    }

    #region Data Binding Methods
    /// <summary>
    /// Fill the Controls with data on the Product
    /// </summary>
    private void BindProductData()
    {
        LinqProductAccess lp = new LinqProductAccess();
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        SectionConfigurationGroup s = 
            (SectionConfigurationGroup)ConfigurationManager.GetSection("LinqCommerce/SiteSettings");
        try
        {
            // Retrieve ProductID from the query string and Display product details
            lc_Product p = lp.GetProduct();
            titleLabel.Text = p.Name;
            descriptionLabel.Text = p.Description;
            priceLabel.Text = String.Format("{0:c}", p.Price);
            // If there is no Detail Image2FileName w use the thumbnail instead
            if(String.IsNullOrEmpty(p.Image2FileName))
                pictureImage.ImageUrl = s.ProductSettings.ProductImagePath + p.Image1FileName;
            else
                pictureImage.ImageUrl = s.ProductSettings.ProductImagePath + p.Image2FileName;

            //Hide the color and size boxes, if the product does not allow color, size or both
            if (lp.GetProduct().Colorable == false)
            {
                ColorPanel.Visible = false;
                ColorRadComboBox.Enabled = false;
            }
            if (lp.GetProduct().Sizeable == false)
            {
                SizePanel.Visible = false;
            }

            // Check for detail images, if availabe display them
            List<lc_ProductImage> imageList = lp.GetProductImages(LinqProductAccess.ProductID);
            if (imageList != null)
            {
                rpProductImages.Visible = true;
                rpProductImages.DataSource = imageList;
                rpProductImages.DataBind();
            }

            // Check to see if item is "out of stock" for all variations
            // If out of stock disable add to cart button
            // To Do - when checking stock if out of stock for a particular color and/or size need to remove
            // those particular options from the drop down menus
            if (LinqProductAccess.GetProductInventory(LinqProductAccess.ProductID) == false)
            {
                pnlOutOfStock.Visible = true; // display out of stock msg
                addToCartButton.Enabled = false; // disable add to cart button
            }

            // Wish List Option, hide if disabled
            if (s.ProductSettings.EnableWishList)
            {
                addToWishListButton.Visible = true;
            }

            // Product Reviews
            if (s.ProductSettings.EnableProductReviews)
            {
                // Product reviews are enabled so unhide the panel
                pnlProductReviews.Visible = true;
                double? averagePoints = lp.GetProductPointsMethod(LinqProductAccess.ProductID);
                if (averagePoints.Value == 0)
                {
                    Rating1.Visible = false;
                    ValueLabel.Text = "This product has not been rated yet. Be the first to rate it!<br/>";
                    ReviewHyperLink.Text = "Review this product";
                    ReviewHyperLink.NavigateUrl = PageInsertReview + "?ProductID=" + LinqProductAccess.ProductID;
                }
                else
                {
                    ValueLabel.Text = "Average Rating: " + String.Format("{0:N}", averagePoints.ToString() + " out of 5");
                    Rating1.Value = Convert.ToInt16(averagePoints);
                    ReviewHyperLink.NavigateUrl = PageViewRecommendations + "?ProductID=" + LinqProductAccess.ProductID;
                }
            }

            // Recommended/Related Products
            if (s.ProductSettings.EnableRecommendedProducts)
            {
                // Recommended Products are enabled so unhide the panel, but only if there is data to display
                int? productDescriptionlength = 0;

                var query = db.GetProductRecommendations(LinqProductAccess.ProductID, productDescriptionlength);
                RecommendationsDataList.DataSource = query.ToList();
                RecommendationsDataList.DataBind();
                // display header
                if (RecommendationsDataList.Items.Count > 0)
                {
                    // If there are recommendations make the panel visible
                    pnlRecommendedProducts.Visible = true;
                }
            }

            //Digital Products
            if (s.ProductSettings.EnableDigitalProducts)
            {
                if (lp.GetDigitalProduct(LinqProductAccess.ProductID) != null)
                {
                    pnlOutOfStock.Visible = false;
                    QuantityPanel.Visible = false;
                    addToCartButton.Visible = false;
                    pnlProductReviews.Visible = false;
                    ColorPanel.Visible = false;
                    SizePanel.Visible = false;
                    pnlDigital.Visible = true;
                }
            }
        }
        catch(Exception ex)
        {
            // There was an error, most likely productid was not passed in 
            // or id provided was not for a valid product
            pnlProductDetails.Visible = false;
            pnlErrorMessage.Visible = true;
            // Only show detailed error if debug = true in web.config
            if (HttpContext.Current.IsDebuggingEnabled)
                lblErrorMessage.Text = ex.Message + "<br/><br/>" + ex.StackTrace;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    public void ProductImageRadAjaxManager_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        LinqProductAccess lp = new LinqProductAccess();

        lc_ProductImage pi = (lc_ProductImage)lp.GetProductImage(Convert.ToInt32(e.Argument));
        pictureImage.ImageUrl = ResolveUrl(productImagesPath + pi.ImageName);
    }
    #endregion

    #region Button Click Methods
    /// <summary>
    /// Adds the product to the users cart
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void addToCartButton_Click(object sender, EventArgs e)
    {
        LinqProductAccess lp = new LinqProductAccess();
        LinqShoppingCartAccess ls = new LinqShoppingCartAccess();
        //Add a cart if a user does not have one. If the user already has the product in the cart, then do not add it again
        // ToDo - update inventory so it stores colorID and sizeID instead of having to deal with both name and ID. 
        // The no size/color option should be either null or 0 so it won't be affected by users creating custom lists missing the "None" option
        string pSize = "None";
        //int pSizeID = 1;
        string pColor = "None";
        //int pColorID = 1;

        if (SizePanel.Visible == true){
            pSize = SizeRadComboBox.Text;
            //pSizeID = Convert.ToInt16(SizeRadComboBox.SelectedValue);
        }
        if (ColorPanel.Visible == true){
            pColor = ColorRadComboBox.Text;
            //pColorID = Convert.ToInt16(ColorRadComboBox.SelectedValue);
        }


        // Check product inventory
        if (LinqProductAccess.GetProductInventory(LinqProductAccess.ProductID, pSize, pColor) == true)
        {
            try
            {
                //How many of that product are in stock?
                int quantityInStock = LinqProductAccess.QuantityInStock(LinqProductAccess.ProductID, pSize, pColor);
                //Are there enough available?
                if (QuantityTextBox.Value <= quantityInStock)
                {
                    ls.InsertProductIntoCart(lp.GetProduct().Price, pSize, pColor, Convert.ToInt32(QuantityTextBox.Value));
                    FeedbackLabel.Text = "Product added successfully!";
                    FeedbackLabel.CssClass = "success";
                    FeedbackLabel.Visible = true;
                }
                else
                {
                    FeedbackLabel.Text = "<b>I'm sorry, but that quantity isn't available.</b>";
                    FeedbackLabel.CssClass = "error";
                    FeedbackLabel.Visible = true;

                }
            }
                //Product exists in cart
            catch(Exception ex)
            {
                FeedbackLabel.Text = "<b>This product has already been added to the shopping cart.</b>";
                FeedbackLabel.CssClass = "information";
                FeedbackLabel.Visible = true;
            }
        }
        else
        {
            FeedbackLabel.Text = "<b>I'm sorry, but this product is out of stock.</b>";
            FeedbackLabel.CssClass = "error";
            FeedbackLabel.Visible = true;
        }
    }

    protected void continueShoppingButton_Click(object sender, EventArgs e)
    {
        LinqProductAccess.LastVistedCatalogPage();
    }

    /// <summary>
    /// Add product to users wish list
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void addToWishListButton_Click(object sender, EventArgs e)
    {
        //If the user is logged in
        if (Profile.UserName != null)
        {
            //Add a cart if a user does not have one. If the user already has the product in the cart, then do not add it again
            string pSize = "None";
            string pColor = "None";
            if (SizePanel.Visible == true)
                pSize = SizeRadComboBox.Text;
            if (ColorPanel.Visible == true)
                pColor = ColorRadComboBox.Text;
            // Check product inventory
            //If the product is in the wish list, then tell the user it cannot be added
            if (LinqProductAccess.IsProductInWishList(LinqProductAccess.ProductID, pSize, pColor) == false)
            {
                try
                {
                    LinqCommerceDataContext db = new LinqCommerceDataContext();
                    lc_WishList w = new lc_WishList();
                    w.UserName = Profile.UserName;
                    w.ProductID = Convert.ToInt32(LinqProductAccess.ProductID);
                    w.DateAdded = DateTime.Now;
                    //w.SizeID = Convert.ToInt32(SizeRadComboBox.SelectedValue);
                    //w.ColorID = Convert.ToInt32(ColorRadComboBox.SelectedValue);
                    w.SizeID = 1;
                    w.ColorID = 1;
                    db.lc_WishLists.InsertOnSubmit(w);
                    db.SubmitChanges();
                    FeedbackLabel.Text = "Product added to your wish list!";
                    FeedbackLabel.CssClass = "success";
                    FeedbackLabel.Visible = true;
                }
                catch
                {
                    FeedbackLabel.Text = "This product already exists in your wish list";
                    FeedbackLabel.CssClass = "information";
                    FeedbackLabel.Visible = true;
                }
            }
            else
            {
                FeedbackLabel.Text = "This product already exists in your wish list";
                FeedbackLabel.CssClass = "information";
                FeedbackLabel.Visible = true;
            }
        }
        else
        {
            FeedbackLabel.Text = "Please login to add products to your wish list.";
            FeedbackLabel.CssClass = "error";
            FeedbackLabel.Visible = true;
        }
    }
    #endregion
}