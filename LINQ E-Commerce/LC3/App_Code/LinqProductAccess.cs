using System;
using System.Configuration;
using System.Linq;
using System.Xml.Linq;
using System.Collections;
using System.Data.Linq.SqlClient;
using System.Collections.Generic;

namespace LinqCommerce
{
    /// <summary>
    /// This controls all of the methods for getting products and checking out. 
    /// It is the heart of all operations for LinqCommerce
    /// </summary>
    public class LinqProductAccess
    {
        #region Public Properties

        /// <summary>
        /// Gets OrderID from query string
        /// </summary>
        public static int? Inventory
        {
            get
            {
                return Convert.ToInt32(System.Web.HttpContext.Current.Request.QueryString["Inventory"]);
            }
        }


        /// <summary>
        /// Gets whether a user should see the shopping cart or color and size admin grid, it shows 1 for true
        /// </summary>
        public static int? OrdersAdmin
        {
            get
            {
                return Convert.ToInt32(System.Web.HttpContext.Current.Request.QueryString["OrdersAdmin"]);
            }
        }

        /// <summary>
        /// Gets whether a user should see the product review grid, it shows 1 for true
        /// </summary>
        public static int? CatalogAdmin
        {
            get
            {
                return Convert.ToInt32(System.Web.HttpContext.Current.Request.QueryString["CatalogAdmin"]);
            }
        }

        /// <summary>
        /// Gets ProductID from query string
        /// </summary>
        public static int ProductID
        {
            get
            {
                return Convert.ToInt32(System.Web.HttpContext.Current.Request.QueryString["ProductID"]);
            }
        }

        /// <summary>
        /// Gets DepartmentID from query string
        /// </summary>
        public static int? DepartmentID
        {
            get
            {
                return Convert.ToInt32(System.Web.HttpContext.Current.Request.QueryString["DepartmentID"]);
            }
        }

        /// <summary>
        /// Gets CategoryID from query string
        /// </summary>
        public static int? CategoryID
        {
            get
            {
                return Convert.ToInt32(System.Web.HttpContext.Current.Request.QueryString["CategoryID"]);
            }
        }

        /// <summary>
        /// Gets search info signal from query string
        /// </summary>
        public static string Search
        {
            get
            {
                return Convert.ToString(System.Web.HttpContext.Current.Request.QueryString["Search"]);
            }
        }

        /// <summary>
        /// Gets newest products signal from query string
        /// </summary>
        public static string NewestProducts
        {
            get
            {
                return Convert.ToString(System.Web.HttpContext.Current.Request.QueryString["NewestProducts"]);
            }
        }

        #endregion

        /// <summary>
        /// Adds a product to a category
        /// </summary>
        /// <param name="ProductID"></param>
        /// <param name="CategoryID"></param>
        public void AddProductCategory(int ProductID, int CategoryID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_ProductCategory pc = new lc_ProductCategory();
            pc.ProductID = ProductID;
            pc.CategoryID = CategoryID;
            db.lc_ProductCategories.InsertOnSubmit(pc);
            db.SubmitChanges();
        }

        /// <summary>
        /// Gets info about a digital product
        /// </summary>
        /// <param name="ProductID"></param>
        /// <returns></returns>
        public List<lc_DigitalProduct> GetDigitalProduct(int ProductID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from a in db.lc_DigitalProducts
                        where a.ProductID == ProductID
                        select a;
            if (query.Count() > 0)
            {
                return query.ToList();
            }
            else
            {
                return null;
            }
        }


        public void EditProduct(int ProductID, decimal price, bool OnDepartmentPromotion, bool OnCatalogPromotion, string name, bool colorable, bool sizeable, string description)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var p = db.lc_Products.Single(a => a.ProductID == ProductID);
            p.Colorable = colorable;
            p.Sizeable = sizeable;
            p.Description = description;
            p.Name = name;
            p.OnCatalogPromotion = OnCatalogPromotion;
            p.OnDepartmentPromotion = OnDepartmentPromotion;
            p.Price = price;
            db.SubmitChanges();
        }

        /// <summary>
        /// Adds a product to the database.
        /// </summary>
        /// <param name="price"></param>
        /// <param name="OnDepartmentPromotion"></param>
        /// <param name="OnCatalogPromotion"></param>
        /// <param name="name"></param>
        /// <param name="colorable"></param>
        /// <param name="sizeable"></param>
        /// <param name="description"></param>
        public void AddProduct(decimal price, bool OnDepartmentPromotion, bool OnCatalogPromotion, string name, bool colorable, bool sizeable, string description)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_Product p = new lc_Product();
            
            // Add a default value of 0 for inventory 
            // ToDo - inventory page needs option to change the supplier.
            lc_ProductInventory pi = new lc_ProductInventory();
            pi.Color = "";
            pi.Size = "";
            pi.Quantity = 0;
            p.lc_ProductInventories.Add(pi);

            // Set product data
            
            //Line below only Added for testing purposes. Remove in production
            p.Image1FileName = "t0704901.jpg";

            p.Colorable = colorable;            
            p.Sizeable = sizeable;
            p.DateAdded = DateTime.Now;
            p.Description = description;
            p.Name = name;
            p.OnCatalogPromotion = OnCatalogPromotion;
            p.OnDepartmentPromotion = OnDepartmentPromotion;
            p.Price = price;
            db.lc_Products.InsertOnSubmit(p);

            db.SubmitChanges();
        }

        public List<lc_Recommendation> GetRecommendations(int ProductID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from a in db.lc_Recommendations
                        where a.ProductID == ProductID
                        select a;
            return query.ToList();
        }

        /// <summary>
        /// Gets last visited page for user when he or she clicks continue shopping button
        /// </summary>
        public static void LastVistedCatalogPage()
        {
            object page;
            if ((page = System.Web.HttpContext.Current.Session["LastVisitedCatalogPage"]) != null)
            {
                System.Web.HttpContext.Current.Response.Redirect(page.ToString());
            }
            else
            {
                System.Web.HttpContext.Current.Response.Redirect(System.Web.HttpContext.Current.Request.ApplicationPath);
            }
        }

        /// <summary>
        /// Gets a list of the newest products added to LinqCommerce
        /// </summary>
        /// <param name="grid"></param>
        public IList NewestProductsQuery()
        {
            SectionConfigurationGroup s =
            (SectionConfigurationGroup)ConfigurationManager.GetSection(
            "LinqCommerce/SiteSettings");
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = (from p in db.lc_Products
                         where p.DateAdded >= DateTime.Today.AddDays(s.ShoppingCartSettings.RecentProducts)
                         & p.DateAdded <= DateTime.Now.Date
                         select p).Distinct();
            return query.ToList();
        }

        /// <summary>
        /// Determines a product's rating from other user's input
        /// </summary>
        /// <param name="Rating1"></param>
        /// <param name="ValueLabel"></param>
        /// <param name="ReviewHyperLink"></param>
        /// <param name="NumberofRecordsLabel"></param>
        public double? GetProductPointsMethod(int ProductID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = (from a in db.lc_Recommendations
                        group a by a.ProductID into g
                        select new { AveragePoints = g.Average(p => p.Points) });
            if (query.Count() > 0)
            {
                return query.FirstOrDefault().AveragePoints;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Gets a specific product image from the ProductImages table
        /// </summary>
        /// <param name="ProductImageID"></param>
        /// <returns></returns>
        public lc_ProductImage GetProductImage(int ProductImageID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var getProductImagequery = (from p in db.lc_ProductImages
                                        where p.ProductImageID == ProductImageID
                                        select p).FirstOrDefault();
            return getProductImagequery;
        }

        /// <summary>
        /// Gets a list of Alternate Product Images from the ProductImage Table
        /// </summary>
        /// <param name="ProductID"></param>
        /// <returns></returns>
        public List<lc_ProductImage> GetProductImages(int ProductID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from a in db.lc_ProductImages
                        where a.ProductID == ProductID
                        select a;
            if (query.Count() > 0)
            {
                return query.ToList();
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// Determines whether a product is available in the inventory to purchase
        /// regardless of size or color
        /// </summary>
        /// <param name="ProductID"></param>
        /// <param name="Size"></param>
        /// <param name="Color"></param>
        /// <returns></returns>
        public static bool GetProductInventory(int ProducutID)
        {
            //Get all the products from the product inventory table, matching the shopping cart item
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var ProductInventory = from pr in db.lc_ProductInventories
                                   join c in db.lc_ColorTables on pr.Color equals c.Color
                                   join s in db.lc_SizeTables on pr.Size equals s.Size
                                   where pr.ProductID == ProductID
                                   where pr.Quantity > 0
                                   select pr;
            //Return true is the quantity is more than 0 and in the database
            if (ProductInventory.Count() > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Determines whether a product is available in the inventory to purchase
        /// </summary>
        /// <param name="ProductID"></param>
        /// <param name="Size"></param>
        /// <param name="Color"></param>
        /// <returns></returns>
        public static bool GetProductInventory(int ProducutID, string Size, string Color)
        {
            //Get all the products from the product inventory table, matching the shopping cart item
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var ProductInventory = from pr in db.lc_ProductInventories
                                   join c in db.lc_ColorTables on pr.Color equals c.Color
                                   join s in db.lc_SizeTables on pr.Size equals s.Size
                                   where pr.ProductID == ProductID
                                   where pr.Color == Color
                                   where pr.Size == Size
                                   where pr.Quantity > 0
                                   select pr;
            //Return true is the quantity is more than 0 and in the database
            if (ProductInventory.Count() > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        /// <summary>
        /// Calculates how much of a product is left in the inventory
        /// </summary>
        /// <param name="ProductID"></param>
        /// <param name="Size"></param>
        /// <param name="Color"></param>
        /// <returns></returns>
        public static int QuantityInStock(int ProductID, string Size, string Color)
        {
            //Get all the products from the product inventory table, matching the shopping cart item
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var ProductInventory = (from pr in db.lc_ProductInventories
                                    join c in db.lc_ColorTables on pr.Color equals c.Color
                                    join s in db.lc_SizeTables on pr.Size equals s.Size
                                    where pr.ProductID == ProductID
                                    where pr.Color == Color
                                    where pr.Size == Size
                                    where pr.Quantity > 0
                                    select pr).FirstOrDefault();
            //Return quantity
            if (ProductInventory.Quantity > 0)
            {
                return ProductInventory.Quantity;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Determines whether a product has colors to choose from
        /// </summary>
        /// <param name="ProductID"></param>
        /// <returns></returns>
        public static bool IsProductColorable(int ProductID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from p in db.lc_Products
                        where p.ProductID == ProductID
                        select new { p.Colorable };
            if (query.First().Colorable == true)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Determines whether a product has sizes to choose from
        /// </summary>
        /// <param name="ProductID"></param>
        /// <returns></returns>
        public static bool IsProductSizeable(int ProductID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from p in db.lc_Products
                        where p.ProductID == ProductID
                        select new { p.Sizeable };
            if (query.First().Sizeable == true)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Determines whether a product has been added to the wish list
        /// </summary>
        /// <param name="ProductID"></param>
        /// <param name="Size"></param>
        /// <param name="Color"></param>
        /// <returns></returns>
        public static bool IsProductInWishList(int ProductID, string Size, string Color)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from wi in db.lc_WishLists
                        where wi.lc_ColorTable.Color == Color
                        where wi.lc_SizeTable.Size == Size
                        where wi.ProductID == ProductID
                        select wi;
            if (query.Count() > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }




        /// <summary>
        /// Gets a product based on a product ID in the query string
        /// </summary>
        /// <returns></returns>
        public lc_Product GetProduct()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var getProductquery = (from p in db.lc_Products
                                  where p.ProductID == LinqProductAccess.ProductID
                                  select p).First();
            return getProductquery;
        }

        /// <summary>
        /// Returns a list of departments
        /// </summary>
        /// <returns></returns>
        public List<lc_Department> GetDepartments()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var getDepartments = from d in db.lc_Departments
                                 select d;
            return getDepartments.ToList();
        }

        /// <summary>
        /// Returns a list of categories based on a department
        /// </summary>
        /// <returns></returns>
        public List<lc_Category> GetCategories()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var getCategories = from c in db.lc_Categories
                                where c.DepartmentID == LinqProductAccess.DepartmentID
                                select c;
            return getCategories.ToList();
        }

        /// <summary>
        ///  Retrieve list of products in a category, if a category and a department are specified
        /// </summary>
        /// <returns></returns>
        public List<lc_Product> GetProductsInCategory()
        {
            if (LinqProductAccess.DepartmentID.Value > 0 && LinqProductAccess.CategoryID.Value > 0)
            {
                LinqCommerceDataContext db = new LinqCommerceDataContext();
                var query3 = (from p in db.lc_Products
                              join pc in db.lc_ProductCategories on p.ProductID equals pc.ProductID
                              orderby p.Name ascending
                              where pc.CategoryID == LinqProductAccess.CategoryID
                              select p).Distinct();
                return query3.ToList();
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        ///  Retrieve list of products in a specified category
        /// </summary>
        /// <returns></returns>
        public IList GetProductsInCategory(int categoryID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var plist = (from p in db.lc_Products
                        join pc in db.lc_ProductCategories on p.ProductID equals pc.ProductID
                        orderby p.Name ascending
                        where pc.CategoryID == categoryID
                        select p).Distinct();
            return plist.ToList();
        }

        /// <summary>
        /// Gets a list of products on catalog promotion
        /// </summary>
        /// <returns></returns>
        public List<lc_Product> OnCatalogPromotion()
        {
            // Retrieve list of products on catalog promotion if no department or category is specified
            if (LinqProductAccess.DepartmentID.Equals(0) && LinqProductAccess.CategoryID.Equals(0))
            {
                LinqCommerceDataContext db = new LinqCommerceDataContext();
                var query = (from p in db.lc_Products
                             where p.OnCatalogPromotion == true
                             select p).Distinct();
                return query.ToList();
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// Gets a list of products on department promotion
        /// </summary>
        /// <returns></returns>
        public List<lc_Product> OnDepartmentPromotion()
        {
            if (LinqProductAccess.DepartmentID.Value > 0 && LinqProductAccess.CategoryID.Equals(0))
            {
                LinqCommerceDataContext db = new LinqCommerceDataContext();
                var query2 = (from p in db.lc_Products
                              join pc in db.lc_ProductCategories on p.ProductID equals pc.ProductID
                              join c in db.lc_Categories on pc.CategoryID equals c.CategoryID
                              where p.OnDepartmentPromotion == true & c.DepartmentID == LinqProductAccess.DepartmentID
                              select p).Distinct();
                return query2.ToList();
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// Gets a category based on a CategoryID, which is in the query string
        /// </summary>
        /// <returns></returns>
        public lc_Category GetCategory()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var getCategory = (from c in db.lc_Categories
                               where c.CategoryID == LinqProductAccess.CategoryID
                               select c).SingleOrDefault();
            return getCategory;
        }

        /// <summary>
        /// Gets a department based on a DepartmentID, which is in the query string
        /// </summary>
        /// <returns></returns>
        public lc_Department GetDepartment()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var DeptQuery = (from d in db.lc_Departments
                             where d.DepartmentID == LinqProductAccess.DepartmentID
                             select d).SingleOrDefault();
            return DeptQuery;
        }

        /// <summary>
        /// Gets a list of products from the product search drop down
        /// </summary>
        /// <returns></returns>
        public IList SearchProduct()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            if (LinqProductAccess.Search != null && LinqProductAccess.DepartmentID.Equals(0) && LinqProductAccess.CategoryID.Equals(0))
            {
                var query = (from p in db.lc_Products
                             where SqlMethods.Like(p.Name, LinqProductAccess.Search)
                             select p).Distinct();
                return query.ToList();
            }
            else
            {
                return null;
            }
        }



        /// <summary>
        /// Selects all the products in the user's shopping cart
        /// </summary>
        /// <returns></returns>
        public IList GetUserShoppingCart()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var squery = from s in db.lc_ShoppingCarts
                         where s.CartID == LinqShoppingCartAccess.cartID
                         select s;
            return squery.ToList();

        }

        /// <summary>
        /// Determines whether a product is in the user's shopping cart
        /// </summary>
        /// <returns></returns>
        public bool IsProductInCart()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var pquery = from s in db.lc_ShoppingCarts
                         where s.ProductID == LinqProductAccess.ProductID & s.CartID == LinqShoppingCartAccess.cartID
                         select s;
            if (pquery.Count() > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Returns a list of product recommendations, based on a product (value is set from query string)
        /// </summary>
        /// <returns></returns>
        public IList ProductRecommendations()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from q in db.lc_Recommendations
                        where q.ProductID == ProductID
                        where q.Approved == true
                        select new
                        {
                            RecommendationID = q.RecommendationID,
                            Title = q.Title,
                            DateInserted = q.DateInserted,
                            UserName = q.UserName,
                            Description = q.Description,
                            Points = q.Points
                        };
            return query.ToList();
        }
    }
}

