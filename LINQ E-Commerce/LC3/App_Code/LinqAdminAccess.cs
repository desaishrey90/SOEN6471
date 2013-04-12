using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing.Imaging;


namespace LinqCommerce
{
    /// <summary>
    /// Controls methods for LinqCommerce administration
    /// </summary>
    public class LinqAdminAccess
    {
        public LinqAdminAccess()
        {
        }

        /// <summary>
        /// Adds a coupon to the database. Amount must be negative for a discount.
        /// </summary>
        public void AddCoupon(decimal Amount, string CouponCode, string CouponName, decimal DiscountPercent, DateTime ExpireDate)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_CouponTable ct = new lc_CouponTable();
            ct.Amount = Amount;
            ct.CouponCode = CouponCode;
            ct.CouponName = CouponName;
            ct.DateMade = DateTime.Now;
            ct.DiscountPercent = DiscountPercent;
            ct.ExpireDate = ExpireDate;
            db.lc_CouponTables.InsertOnSubmit(ct);
            db.SubmitChanges();
        }

        /// <summary>
        /// Updates a product's thumbnail image.
        /// </summary>
        /// <param name="FileName"></param>
        /// <param name="lp"></param>
        public void UpdateProductImage(string thumbFileName, string detailFileName, int productID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var p = db.lc_Products.Single(a => a.ProductID == productID);
            p.Image1FileName = thumbFileName;
            p.Image2FileName = detailFileName;
            db.SubmitChanges();
        }

        /// <summary>
        /// Updates a product's thumbnail image.
        /// </summary>
        /// <param name="FileName"></param>
        /// <param name="lp"></param>
        public void UpdateAlternateProductImages(string fileName, int productID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var pimage = (from pi in db.lc_ProductImages
                          where pi.ProductID == productID
                          && pi.ImageName == fileName
                          select pi).SingleOrDefault();
            // image doesn't exist so add it otherwise update current image
            // ToDo - add option to prompt for overwrite
            if (pimage == null)
            {
                lc_ProductImage npi = new lc_ProductImage();
                npi.ImageName = fileName;
                npi.ProductID = productID;
                db.lc_ProductImages.InsertOnSubmit(npi);
                db.SubmitChanges();
            }
            else
            {
                pimage.ImageName = fileName;
                pimage.ProductID = productID;
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// Resizes image in file structure.
        /// </summary>
        /// <param name="location"></param>
        /// <param name="Height"></param>
        /// <param name="UsePercentages"></param>
        public void ResizeImage(string location, double Height, bool UsePercentages)
        {
            ImageResize o = new ImageResize();
            o.File = location;
            o.Height = Height;
            o.UsePercentages = UsePercentages;
            o.GetThumbnail().Save(location, ImageFormat.Jpeg);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="location"></param>
        /// <param name="width"></param>
        /// <param name="height"></param>
        /// <param name="usePercentages"></param>
        /// <param name="preserveAspectRatio"></param>
        public void ResizeImage(string fileType, string location, double width, double height, bool usePercentages, bool preserveAspectRatio)
        {
            ImageResize o = new ImageResize();
            o.File = location;
            o.Width = width;
            o.Height = height;
            o.UsePercentages = usePercentages;
            o.PreserveAspectRatio = preserveAspectRatio;
            
            switch (fileType)
            {
                case "image/jpeg":
                    o.GetThumbnail().Save(location, ImageFormat.Jpeg);
                    break;
                case "image/gif":
                    o.GetThumbnail().Save(location, ImageFormat.Gif);
                    break;
                case "image/png":
                    o.GetThumbnail().Save(location, ImageFormat.Png);
                    break;
                case "image/bmp":
                    o.GetThumbnail().Save(location, ImageFormat.Bmp);
                    break;
            }
        }

        /// <summary>
        /// Deletes product and its entries in the product categories table
        /// </summary>
        /// <param name="ProductID"></param>
        public void DeleteProductCategories(int ProductID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from a in db.lc_ProductCategories
                        where a.ProductID == ProductID
                        select a;
            db.lc_ProductCategories.DeleteAllOnSubmit(query);
            db.SubmitChanges();
        }

        public void DeleteProduct(int ProductID)
        {
            LinqCommerceDataContext db2 = new LinqCommerceDataContext();
            var query2 = (from b in db2.lc_Products
                          where b.ProductID == ProductID
                          select b).SingleOrDefault();
            db2.lc_Products.Attach(query2);
            db2.lc_Products.DeleteOnSubmit(query2);
            db2.SubmitChanges();
        }
    }
}