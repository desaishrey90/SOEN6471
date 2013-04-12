using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LinqCommerce
{
    /// <summary>
    /// Holds all the API for CRUD for inventory
    /// </summary>
    public class LinqInventoryAccess
    {
        /// <summary>
        /// Makes an instance of the product inventory class
        /// </summary>
        private lc_ProductInventory PRI
        {
            get
            {
                return new lc_ProductInventory();
            }
        }

        public LinqInventoryAccess()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        /// <summary>
        /// Inserts a product into the inventory, if it already doesn't exist
        /// </summary>
        /// <param name="ProductID"></param>
        /// <param name="Color"></param>
        /// <param name="Size"></param>
        /// <param name="Quantity"></param>
        /// <param name="SellerID"></param>
        public void InsertProductIntoInventory(int ProductID, string Color, string Size, int Quantity, int SellerID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_ProductInventory pro = new lc_ProductInventory();
            //Add the information to the Product Inventory Table
            pro.ProductID = Convert.ToInt32(ProductID);
            pro.Color = Color;
            pro.Size = Size;
            pro.Quantity = Quantity;
            pro.SellerID = SellerID;
            db.lc_ProductInventories.InsertOnSubmit(pro);
            db.SubmitChanges();
        }

        /// <summary>
        /// Gets a product based on size and color
        /// </summary>
        /// <param name="ProductID"></param>
        /// <param name="Color"></param>
        /// <param name="Size"></param>
        /// <returns></returns>
        public lc_ProductInventory GetProductSizeColor(int ProductID, string Color, string Size)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = (from a in db.lc_ProductInventories
                         where a.Color == Color
                         where a.Size == Size
                         where a.ProductID == ProductID
                         select a).SingleOrDefault();
            return query;
        }

        /// <summary>
        /// Updates quantity, if the product already exists in the inventory
        /// </summary>
        /// <param name="ProductID"></param>
        /// <param name="Color"></param>
        /// <param name="Size"></param>
        /// <param name="Quantity"></param>
        public void UpdateQuantity(int ProductID, string Color, string Size, int Quantity)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = (from a in db.lc_ProductInventories
                         where a.Color == Color
                         where a.Size == Size
                         where a.ProductID == ProductID
                         select a).Single();
            query.Quantity = query.Quantity + Quantity;
            db.SubmitChanges();
        }
    }
}
