using System;
using System.Linq;
using System.Web;
using System.Net;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;

namespace LinqCommerce
{
    /// <summary>
    /// Supplies all methods and properties for LinqCommerce's shopping cart
    /// </summary>
    public class LinqShoppingCartAccess
    {
        #region Properties
        /// <summary>
        /// Gets the amount from the query string
        /// </summary>
        public static string Amount
        {
            get
            {
                return System.Web.HttpContext.Current.Request.QueryString["Amount"].ToString();
            }
        }

        /// <summary>
        /// Gets the shipping amount from the query string
        /// </summary>
        public static string Shipping
        {
            get
            {
                return System.Web.HttpContext.Current.Request.QueryString["Shipping"].ToString();
            }
        }

        /// <summary>
        /// Gets the tax from the query string
        /// </summary>
        public static string Tax
        {
            get
            {
                return System.Web.HttpContext.Current.Request.QueryString["Tax"].ToString();
            }
        }

        /// <summary>
        /// Gets the amount tax shipping from the query string
        /// </summary>
        public static string amountTaxShipping
        {
            get
            {
                return System.Web.HttpContext.Current.Request.QueryString["amountTaxShipping"].ToString();
            }
        }

        /// <summary>
        /// Gets the OrderID from the query string
        /// </summary>
        public static string OrderID
        {
            get
            {
                return System.Web.HttpContext.Current.Request.QueryString["OrderID"].ToString();
            }
        }

        /// <summary>
        /// Gets the CartID from session state
        /// </summary>
        public static string cartID
        {
            get
            {
                return GetShoppingCartID();
            }
        }

        #endregion

        public IQueryable<lc_ShoppingCart> GetAllCartsByID()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();

            var g = from s in db.lc_ShoppingCarts
                    where s.CartID.Equals(LinqShoppingCartAccess.cartID)
                    select s;
            return g;
        }


        // GetShoppingCart requires SqlUpdate_3.2_3.3.sql to be run in order to update
        // lc_ShoppingCart table to use single CartItemID PK
        /*
        /// <summary>
        /// Returns an IList of items in the users shopping cart
        /// </summary>
        /// <returns></returns>
        public static IList GetShoppingCart()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var sc = from s in db.lc_ShoppingCarts
                     join p in db.lc_Products on s.ProductID equals p.ProductID
                     join size in db.lc_SizeTables on s.SizeID equals size.SizeID
                     join color in db.lc_ColorTables on s.ColorID equals color.ColorID
                        where s.CartID.Equals(LinqShoppingCartAccess.cartID)
                select new
                {
                    CartItemID = s.CartItemID,
                    CartID = s.CartID,
                    ProductID = s.ProductID,
                    SizeID = s.SizeID,
                    ColorID = s.ColorID,
                    Thumbnail = p.Image1FileName,
                    Name = p.Name,
                    Description = p.Description,
                    Quantity = s.Quantity,
                    Price = p.Price,
                    Size = size.Size,
                    Color = color.Color,
                    Subtotal = p.Price * s.Quantity
                };
            return sc.ToList();
        }
        */
        /// <summary>
        /// Returns a string representing the number of items in a users shopping cart
        /// </summary>
        /// <returns></returns>
        public static string GetShoppingCartItemCount()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var sc = (from c in db.lc_ShoppingCarts
                     where c.CartID.Equals(LinqShoppingCartAccess.cartID)
                     select c).Count();

            return sc.ToString();
        }

        /// <summary>
        /// Checks to see if a Product with specific size/color attributes is already in the cart
        /// </summary>
        /// <param name="productID"></param>
        /// <param name="sizeID"></param>
        /// <param name="colorID"></param>
        /// <returns>If product is in cart returns true, otherwise returns false</returns>
        public static bool IsItemInCart(int productID, string Size, string Color)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var sc = (from c in db.lc_ShoppingCarts
                      where c.CartID.Equals(LinqShoppingCartAccess.cartID)
                      where c.ProductID.Equals(productID)
                      where c.SizeID == 1
                      where c.ColorID == 1
                      select c).FirstOrDefault();

            if (sc != null)
                return true;
            else
                return false;
        }

        /// <summary>
        /// Inserts a product into the shopping cart
        /// </summary>
        /// <param name="Price"></param>
        /// <param name="SizeID"></param>
        /// <param name="ColorID"></param>
        public void InsertProductIntoCart(decimal Price, string Size, string Color)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_ShoppingCart s = new lc_ShoppingCart
            {
                CartID = LinqShoppingCartAccess.cartID,
                ProductID = LinqProductAccess.ProductID,
                DateAdded = System.DateTime.Today,
                Quantity = 1,
                Price = Price,
                SizeID = 1,
                ColorID = 1
            };
            db.lc_ShoppingCarts.InsertOnSubmit(s);
            db.SubmitChanges();
        }

        /// <summary>
        /// Inserts a product into the shopping cart with a quantity set by user
        /// </summary>
        /// <param name="Price"></param>
        /// <param name="SizeID"></param>
        /// <param name="ColorID"></param>
        /// <param name="Quantity"></param>
        public void InsertProductIntoCart(decimal Price, string Size, string Color, int Quantity)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from a in db.lc_ShoppingCarts
                        where a.ColorID  == 1
                        where a.SizeID == 1
                        where a.ProductID == LinqProductAccess.ProductID
                        select a;

            //See if the record already exists and if it does not
            //insert that into the cart
            if (query.Count() == 0)
            {
                lc_ShoppingCart s = new lc_ShoppingCart
                {
                    CartID = LinqShoppingCartAccess.cartID,
                    ProductID = LinqProductAccess.ProductID,
                    DateAdded = System.DateTime.Today,
                    Quantity = Quantity,
                    Price = Price,
                    SizeID = 1,
                    ColorID = 1,

                    //Size = string.Empty,
                    //Color = string.Empty
                };
                db.lc_ShoppingCarts.InsertOnSubmit(s);
                db.SubmitChanges();
            }
                //Gets caught in the product details page and shows message
                //product already added
            else
            {
                throw new Exception("Item exists in cart");
            }
        }

        /// <summary>
        /// Delete order from shopping cart, once the user clicks the proceed to checkout button
        /// </summary>
        public void DeleteOrderfromShoppingCart()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var shQuery = from s in db.lc_ShoppingCarts
                          where s.CartID == LinqShoppingCartAccess.cartID
                          select s;

            foreach (lc_ShoppingCart sh in shQuery)
            {
                db.lc_ShoppingCarts.DeleteOnSubmit(sh);
            }

            db.SubmitChanges();
        }



        /// <summary>
        /// Decrements product inventory table.
        /// </summary>
        public void DoProductInventory()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            //Get the shopping cart instance
            var shQuery = from s in db.lc_ShoppingCarts
                          where s.CartID == LinqShoppingCartAccess.cartID
                          select s;

            foreach (lc_ShoppingCart sc in shQuery)
            {
                //Decrement the Product Table's Total Remaining row with the quantity
                var ProductInventoryQuery = (from pr in db.lc_ProductInventories
                                             join c in db.lc_ColorTables on pr.Color equals c.Color
                                             join s in db.lc_SizeTables on pr.Size equals s.Size
                                             where pr.ProductID == Convert.ToInt32(sc.ProductID)
                                             where pr.Color == c.Color
                                             where pr.Size == s.Size
                                             select pr).First();
                ProductInventoryQuery.Quantity = ProductInventoryQuery.Quantity - sc.Quantity;
            }
            db.SubmitChanges();

            //Delete Order from shopping cart, once the user clicks the proceed to checkout button
            foreach (lc_ShoppingCart sh in shQuery)
            {
                db.lc_ShoppingCarts.DeleteOnSubmit(sh);
            }
            db.SubmitChanges();
        }


        public bool CheckProductInventory(int Quantity, int ProductID, string Size, string Color)
        {
            //check to see if the product is in stock and if not, throw an error
            if ((Quantity > LinqProductAccess.QuantityInStock(ProductID,
            Size, Color)))
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        /// <summary>
        /// Add shipping, based on what's selected
        /// </summary>
        /// <param name="RegionName"></param>
        /// <returns></returns>
        public decimal AddShipping(string RegionName)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from r in db.lc_RegionShippingTables
                        where r.Name == RegionName
                        select r;
            if (query.Count() > 0)
            {
                return Convert.ToDecimal(query.First().ShippingCost);
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Get the tax based on the user's profile billing state
        /// </summary>
        /// <param name="UserState"></param>
        /// <returns></returns>
        public decimal AddTax(string UserState)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from t in db.lc_StateTaxTables
                        where t.Name == UserState
                        select t;
            if (query.Count() > 0)
            {
                return Convert.ToDecimal(query.First().TaxPercent) / 100;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Addds the tax and the shipping amount
        /// </summary>
        /// <returns></returns>
        public decimal AddTaxShipAmount()
        {
            decimal a = Convert.ToDecimal(LinqShoppingCartAccess.Amount) +
                Convert.ToDecimal(LinqShoppingCartAccess.Shipping);
            decimal b = Convert.ToDecimal(LinqShoppingCartAccess.Tax);
            return (a * b) + a;
        }

        /// <summary>
        /// Creates an order in the order detail table
        /// </summary>
        /// <param name="OrderID"></param>
        /// <param name="CouponCode"></param>
        /// <param name="UserName"></param>
        public void CreateOrderDetail(int OrderID, string CouponCode, string UserName)
        {
            //Get all carts
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var shopQuery = from s in db.lc_ShoppingCarts
                            where s.CartID == LinqShoppingCartAccess.cartID
                            select s;
            //for each one, enter record into Order detail table
            foreach (lc_ShoppingCart shopping in shopQuery)
            {

                lc_OrderDetail or = new lc_OrderDetail
                {
                    ProductID = shopping.ProductID,
                    ProductName = string.Empty,
                    Quantity = shopping.Quantity,
                    Subtotal = (shopping.Quantity * shopping.Price),
                    //1 = shopping.SizeID,
                    UnitCost = shopping.Price,
                    //1 = shopping.ColorID,
                    OrderID = OrderID,
                    CouponCode = CouponCode,
                    UserName = UserName
                };
                    db.lc_OrderDetails.InsertOnSubmit(or);
                    db.SubmitChanges();
            }
        }

        /// <summary>
        /// Creates an Order and returns an OrderID
        /// </summary>
        /// <returns></returns>
        public int CreateOrder()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_Order ord = new lc_Order
            {
                DateCreated = System.DateTime.Now,
                Verified = false,
                Completed = false,
                Canceled = false,
            };
            db.lc_Orders.InsertOnSubmit(ord);
            db.SubmitChanges();
            return ord.OrderID;
        }


        /// <summary>
        ///  Get Shopping Cart ID
        /// </summary>
        /// <returns></returns>
        public static string GetShoppingCartID()
        {

            // get the current HttpContext
            HttpContext context = HttpContext.Current;
            // try to retrieve the cart ID from the user session object
            string cartId = "";
            object cartIdSession = context.Session["BalloonShop_CartID"];
            if (cartIdSession != null)
                cartId = cartIdSession.ToString();
            // if the ID exists in the current session...
            if (cartId != "")
                // return its value
                return cartId;
            else
            // if the cart ID isn't in the session...
            {
                // check if the cart ID exists as a cookie
                if (context.Request.Cookies["BalloonShop_CartID"] != null)
                {
                    // if the cart exists as a cookie, use the cookie to get its value
                    cartId = context.Request.Cookies["BalloonShop_CartID"].Value;
                    // save the id to the session, to avoid reading the cookie next time
                    context.Session["BalloonShop_CartID"] = cartId;
                    // return the id
                    return cartId;
                }
                else
                // if the cart ID doesn't exist in the cookie as well, generate a new ID
                {
                    SectionConfigurationGroup s =
            (SectionConfigurationGroup)ConfigurationManager.GetSection(
            "LinqCommerce/SiteSettings");
                    // generate a new GUID
                    cartId = Guid.NewGuid().ToString();
                    // create the cookie object and set its value
                    HttpCookie cookie = new HttpCookie("BalloonShop_CartID", cartId.ToString());
                    // set the cookie's expiration date 
                    int howManyDays = s.ShoppingCartSettings.CartPersistDays;
                    DateTime currentDate = DateTime.Now;
                    TimeSpan timeSpan = new TimeSpan(howManyDays, 0, 0, 0);
                    DateTime expirationDate = currentDate.Add(timeSpan);
                    cookie.Expires = expirationDate;
                    // set the cookie on client's browser
                    context.Response.Cookies.Add(cookie);
                    // save the ID to the Session as well
                    context.Session["BalloonShop_CartID"] = cartId;
                    // return the CartID
                    return cartId.ToString();
                }
            }
        }

        /// <summary>
        /// Get the coupon's amount in money format based on the coupon code
        /// </summary>
        /// <param name="CouponName"></param>
        /// <returns></returns>
        public static decimal GetMoneyCoupon(string CouponName)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var MoneyCoupon = from c in db.lc_CouponTables
                              where c.CouponCode == CouponName
                              //Make sure coupon date is OK
                              & c.ExpireDate > DateTime.Today.Date
                              select c;

            //If there is a coupon, return its monetary discount
            if (MoneyCoupon.Count() > 0)
            {
                return MoneyCoupon.First().Amount;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Get the percentage for a coupon
        /// </summary>
        /// <param name="CouponName"></param>
        /// <returns></returns>
        public static decimal GetPercentCoupon(string CouponName)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var PercentCoupon = from c in db.lc_CouponTables
                                where c.CouponCode == CouponName
                                //Make sure date is OK
                                & c.ExpireDate > DateTime.Today.Date
                                select c;

            //If there is a coupon, return its percentage
            if (PercentCoupon.Count() > 0)
            {
                return PercentCoupon.First().DiscountPercent;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Get the total amount in the shopping cart
        /// </summary>
        /// <param name="cartID"></param>
        /// <returns></returns>
        public static decimal GetTotalAmount(string cartID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            // display the total amount
            var amount = (from s in db.lc_ShoppingCarts
                          where s.CartID.Equals(cartID)
                          select s).Sum(i => i.Price * i.Quantity);
            return amount;
        }

        /// <summary>
        /// If there is a coupon in the box, validate it and determine the discount
        /// </summary>
        /// <param name="CouponName"></param>
        /// <returns></returns>
        public static decimal CheckCoupon(string CouponName)
        {
            decimal amount = GetTotalAmount(cartID);
            //If there is a coupon in the textbox, then check to see if it's valid
            if (CouponName != "")
            {

                //Does the coupon have a negative number value, which means it is a discount?
                if (GetMoneyCoupon(CouponName) < 0)
                {
                    amount = amount + GetMoneyCoupon(CouponName);
                }
                //If the percent of the coupon is more than 0, which means it is a valid percent coupon
                if (GetPercentCoupon(CouponName) > 0)
                {
                    amount =
                        //Subtract the percent from the amount
                        amount - (amount * GetPercentCoupon(CouponName));
                }
                //if the coupon is invalid, just return the total amount
                else
                {
                    return amount;
                }
            }
            return amount;
        }

        /// <summary>
        /// Check to see if the user has filled out the profile, using billing first name as
        /// a mandatory field. If the profile isn't filled, disable checkout
        /// </summary>
        /// <param name="statusLabel"></param>
        /// <param name="checkoutButton"></param>
        /// <param name="checkoutButton2"></param>
        /// <param name="Profile"></param>
        public static bool ProfileCheck(string BillingFirstName)
        {
            if (BillingFirstName == "")
            {
                return false;

            }
            else
            {
                return true;
            }
        }

        /// <summary>
        /// Use to show the Authorize.NET Standard Payment Form
        /// </summary>
        /// <param name="amount"></param>
        /// <returns></returns>
        public static string ShowPaymentForm(decimal amount)
        {
            SectionConfigurationGroup se =
                    (SectionConfigurationGroup)ConfigurationManager.GetSection(
                    "LinqCommerce/AuthorizeNETSettings");
            string APILogin = se.AuthorizeNET.APILogin;
            //string TransactionKey = se.AuthorizeNET.TransactionKey;
            string Amount = amount.ToString();
            string url = "https://test.authorize.net/gateway/transact.dll";
            string RelayResponseURL = @"/ReceiptPage.htm";
            string strPost = "";
            string result = "";
            strPost += "&x_login=" + APILogin;
            strPost += "&x_show_form=PAYMENT_FORM";
            strPost += "&x_type=AUTH_CAPTURE";
            strPost += "&x_method=CC";
            strPost += "&x_amount=" + Amount;
            //strPost += "&x_tran_key=" + TransactionKey;
            strPost += "&x_delim_data=TRUE&x_delim_char=|&x_relay_response=TRUE";
            strPost += "&x_relay_url=" + RelayResponseURL;
            strPost += "&x_test_request=TRUE&x_version=3.1";

            StreamWriter myWriter = null;

            HttpWebRequest objRequest = (HttpWebRequest)WebRequest.Create(url);
            objRequest.Method = "POST";
            objRequest.ContentLength = strPost.Length;
            objRequest.ContentType = "application/x-www-form-urlencoded";

            try
            {
                myWriter = new StreamWriter(objRequest.GetRequestStream());
                myWriter.Write(strPost);
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                myWriter.Close();
            }

            HttpWebResponse objResponse = (HttpWebResponse)objRequest.GetResponse();
            using (StreamReader sr =
               new StreamReader(objResponse.GetResponseStream()))
            {
                result = sr.ReadToEnd();

                // Close and clean up the StreamReader
                sr.Close();
            }
            return result;
        }
    }
}
