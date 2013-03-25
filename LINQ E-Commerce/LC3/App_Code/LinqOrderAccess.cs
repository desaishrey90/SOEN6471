using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;

namespace LinqCommerce
{
    /// <summary>
    /// Maintains all info about an order
    /// </summary>
    public class LinqOrderAccess
    {
        public LinqOrderAccess()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public void SendCompleteEMail(string to, string from, string OrderID)
        {
            MailMessage message = new System.Net.Mail.MailMessage(from, to);
            message.Subject = "Google Checkout Order #: " + " " + OrderID + " processed successfully";
            SmtpClient sc = new System.Net.Mail.SmtpClient();
            sc.Send(message);

        }

        /// <summary>
        /// Inserts an Order into the database
        /// </summary>
        /// <param name="UnitCost"></param>
        /// <param name="UserName"></param>
        /// <param name="Quantity"></param>
        /// <param name="ProductName"></param>
        /// <param name="ProductID"></param>
        /// <param name="CustomerEMail"></param>
        /// <param name="CustomerName"></param>
        /// <param name="Comments"></param>
        public void InsertOrder(decimal UnitCost, string UserName, int Quantity, string ProductName, int ProductID, string CustomerEMail, string CustomerName, string Comments)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_Order o = new lc_Order();
            o.CustomerEmail = CustomerEMail;
            o.CustomerName = CustomerName;
            o.Verified = true;
            o.DateCreated = DateTime.Now;
            o.Comments = Comments;
            lc_OrderDetail od = new lc_OrderDetail();
            od.ProductID = ProductID;
            od.ProductName = ProductName;
            od.Quantity = Quantity;
            od.UserName = UserName;
            od.UnitCost = UnitCost;
            o.lc_OrderDetails.Add(od);
            db.lc_Orders.InsertOnSubmit(o);
            db.SubmitChanges();

        }

        /// <summary>
        /// Inserts a record into the billing table
        /// </summary>
        /// <param name="FirstName"></param>
        /// <param name="LastName"></param>
        /// <param name="MiddleName"></param>
        /// <param name="NickName"></param>
        /// <param name="OrderID"></param>
        /// <param name="Phone"></param>
        /// <param name="Prefix"></param>
        /// <param name="State"></param>
        /// <param name="Zip"></param>
        public void InsertBilling(string FirstName, string LastName, string MiddleName, string NickName, int OrderID, string Phone, string Prefix, string State, string Zip)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            
            lc_BillingInfoTable bi = new lc_BillingInfoTable();
            bi.FirstName = FirstName;
            bi.LastName = LastName;
            bi.MiddleName = MiddleName;
            bi.NickName = NickName;
            bi.OrderID = OrderID;
            bi.Phone = Phone;
            bi.Prefix = Prefix;
            bi.State = State;
            bi.Zip = Zip;
            db.lc_BillingInfoTables.InsertOnSubmit(bi);
            db.SubmitChanges();

        }

        //LinqEcommerce
        //SOEN-6471 - Milestone 4 change on 25/03/2015
        //Modified by Abhinav Shah, Manthan Makwana, Mohnish Sethi, Niketh Jain and Shrey Jain
        public void InsertBilling(ProfileGroupBilling Billing, int Order_ID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();

            lc_BillingInfoTable bi = new lc_BillingInfoTable();
            bi.FirstName = Billing.FirstName;
            bi.LastName = Billing.LastName;
            bi.MiddleName = Billing.MiddleName;
            bi.NickName = Billing.NickName;
            bi.OrderID = Order_ID;
            bi.Phone = Billing.Phone;
            bi.Prefix = Billing.Prefix;
            bi.State = Billing.State;
            bi.Zip = Billing.Zip;
            db.lc_BillingInfoTables.InsertOnSubmit(bi);
            db.SubmitChanges();

        }

        /// <summary>
        /// Inserts a record into the shipping info table
        /// </summary>
        /// <param n`ame="FirstName"></param>
        /// <param name="LastName"></param>
        /// <param name="MiddleName"></param>
        /// <param name="NickName"></param>
        /// <param name="OrderID"></param>
        /// <param name="Phone"></param>
        /// <param name="Prefix"></param>
        /// <param name="State"></param>
        /// <param name="Zip"></param>
        public void InsertShipping(string FirstName, string LastName, string MiddleName, string NickName, int OrderID, string Phone, string Prefix, string State, string Zip)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_ShippingInfoTable bi = new lc_ShippingInfoTable();
            bi.FirstName = FirstName;
            bi.LastName = LastName;
            bi.MiddleName = MiddleName;
            bi.NickName = NickName;
            bi.OrderID = OrderID;
            bi.Phone = Phone;
            bi.Prefix = Prefix;
            bi.State = State;
            bi.Zip = Zip;
            db.lc_ShippingInfoTables.InsertOnSubmit(bi);
            db.SubmitChanges();

        }


        //LinqEcommerce
        //SOEN-6471 - Milestone 4 change on 25/03/2015
        //Modified by Abhinav Shah, Manthan Makwana, Mohnish Sethi, Niketh Jain and Shrey Jain
        public void InsertShipping(ProfileGroupShipping Shipping, int OrderID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_ShippingInfoTable bi = new lc_ShippingInfoTable();
            bi.FirstName = Shipping.FirstName;
            bi.LastName = Shipping.LastName;
            bi.MiddleName = Shipping.MiddleName;
            bi.NickName = Shipping.NickName;
            bi.OrderID = OrderID;
            bi.Phone = Shipping.Phone;
            bi.Prefix = Shipping.Prefix;
            bi.State = Shipping.State;
            bi.Zip = Shipping.Zip;
            db.lc_ShippingInfoTables.InsertOnSubmit(bi);
            db.SubmitChanges();

        }

        /// <summary>
        /// Gets all billing details for an lc_Order, based on an lc_Order ID (supplied in query string)
        /// </summary>
        /// <param name="OrderID"></param>
        /// <returns></returns>
        public List<lc_BillingInfoTable> GetAllBillingDetails(int OrderID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var billingAdmin = from b in db.lc_BillingInfoTables
                               where b.OrderID == Convert.ToInt32(OrderID)
                               select b;
            return billingAdmin.ToList();
        }

        /// <summary>
        /// Gets all shipping details for an order, based on an order ID (supplied in query string)
        /// </summary>
        /// <param name="OrderID"></param>
        /// <returns></returns>
        public List<lc_ShippingInfoTable> GetAllShippingDetails(int OrderID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var shippingAdmin = from s in db.lc_ShippingInfoTables
                                where s.OrderID == Convert.ToInt32(OrderID)
                                select s;
            return shippingAdmin.ToList();
        }

        /// <summary>
        /// Gets a list of order details
        /// </summary>
        /// <param name="OrderID"></param>
        /// <returns></returns>
        public List<lc_OrderDetail> GetOrderDetails(string OrderID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from a in db.lc_OrderDetails
                        where a.OrderID == Convert.ToInt16(OrderID)
                        select a;
            return query.ToList();
        }

        /// <summary>
        /// Completes order by marking it as verified, meaning the payment has been received and deposited
        /// </summary>
        /// <param name="OrderID"></param>
        /// <param name="Tax"></param>
        public void CompleteOrder(int OrderID, double Tax, string BillingState)
        {
            LinqShoppingCartAccess ls = new LinqShoppingCartAccess();
            //Update the lc_Orders table and say the lc_Order is complete
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var lc_OrdersQuery = db.lc_Orders.Single(o => o.OrderID == OrderID);
            lc_OrdersQuery.Completed = true;
            lc_OrdersQuery.Verified = true;
            lc_OrderDetail or = new lc_OrderDetail();
            or.OrderID = OrderID;
            or.Region = BillingState;
            or.Tax = Tax;
            db.SubmitChanges();
        }

        /// <summary>
        /// Completes order by marking it as completed, meaning the payment has been received and deposited
        /// </summary>
        /// <param name="OrderID"></param>
        /// <param name="Tax"></param>
        public void GoogleCompleteOrder(string CustomerEMail)
        {
            //Update the lc_Orders table and say the lc_Order is complete
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var lc_OrdersQuery = db.lc_Orders.Single(o => o.CustomerEmail == CustomerEMail);
            lc_OrdersQuery.Completed = true;
            lc_OrdersQuery.DateShipped = DateTime.Now;
            db.SubmitChanges();
        }

        /// <summary>
        /// Gets an Order based on an OrderID
        /// </summary>
        /// <param name="OrderID"></param>
        /// <returns></returns>
        public List<lc_Order> GetOrder(int OrderID)
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from a in db.lc_Orders
                        where a.OrderID == OrderID
                        select a;
            return query.ToList();
        }

        /// <summary>
        /// Gets all lc_Orders
        /// </summary>
        /// <returns></returns>
        public List<lc_Order> GetOrders()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from a in db.lc_Orders
                        select a;
            return query.ToList();

        }

        /// <summary>
        /// Gets all Countries
        /// </summary>
        /// <returns></returns>
        public List<lc_Country> GetCountries()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from c in db.lc_Countries
                        select c;
            return query.ToList();

        }
        
        /// <summary>
        /// Gets all Countries that the system will ship to.
        /// </summary>
        /// <returns></returns>
        public List<lc_Country> GetShipToCountries()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from c in db.lc_Countries
                        where c.ShipTo.Equals(true)
                        select c;
            return query.ToList();

        }

        /// <summary>
        /// Gets all States/Provinces
        /// </summary>
        /// <returns></returns>
        public List<lc_State> GetStates()
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            var query = from s in db.lc_States
                        select s;
            return query.ToList();
        }
    }
}
