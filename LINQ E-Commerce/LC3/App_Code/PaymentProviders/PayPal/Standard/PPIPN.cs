/// <summary>
/// Copyright 2008 - XDev Software, LLC
/// Use this code at your own risk. XDev Software is not responsible 
/// for any damage that may come from using this code.  This code is provided as is.
/// </summary>

/* This code does not account for some of the variables that are passed back from IPN.
 * Howevever, it does account for most of them. This code does not also account for all shopping
 * cart functionality as you will have to handle the multiple items yourself. In addition,
 * it does not handle refunds in anyway for IPN.
 * Thanks again for using the code and any changes you feel that are needed please email to
 * 
 * support@xdevsoftware.com
 *
 */

using System.Net;
using System.Net.Mail;
using System.IO;
using System.Text;
using System.Web;
using System;

namespace LinqCommerce
{
    /// <summary>
    /// Handles all PayPal IPN methods. Reads info posted from PayPal and completes lc_Order for PayPal Website Standard.
    /// </summary>
    public class PPIPN
    {
        string _txnID, _txnType, _paymentStatus, _receiverEmail, _itemName, _itemNumber, _quantity, _invoice, _custom,
        _paymentGross, _payerEmail, _pendingReason, _paymentDate, _paymentFee, _firstName, _lastName, _address,
        _city, _state, _zip, _country, _countryCode, _addressStatus, _payerStatus, _payerID, _paymentType, _notifyVersion,
        _verifySign, _response, _payerPhone, _payerBusinessName, _business, _receiverID, _memo, _tax, _qtyCartItems,
        _shippingMethod, _shipping;

        private string _postUrl = "";
        private string _strRequest = "";
        private string _smtpHost, _fromEmail, _toEmail, _fromEmailPassword, _smtpPort;

        /// <summary>
        /// valid strings are "TEST" for sandbox use 
        /// "LIVE" for production use
        /// "ELITE" for test use off of PayPal...avoid having to be logged into PayPal Developer
        /// </summary>
        /// <param name="mode"></param>
        public PPIPN(string mode)
        {
            if (mode.ToLower() == "test")
                this.PostUrl = "https://www.sandbox.paypal.com/cgi-bin/webscr";
            else if (mode.ToLower() == "live")
                this.PostUrl = "https://www.paypal.com/cgi-bin/webscr";
            else if (mode.ToLower() == "elite")
                this.PostUrl = "http://www.eliteweaver.co.uk/testing/ipntest.php";
            else
                this.PostUrl = "";

            this.fillProperties();
        }

        #region "Properties"

        private string PostUrl
        {
            get { return _postUrl; }
            set { _postUrl = value; }
        }

        /// <summary>
        /// This is the reponse back from the http post back to PayPal.
        /// Possible values are "VERIFIED" or "INVALID"
        /// </summary>
        private string Response
        {
            get { return _response; }
            set { _response = value; }
        }

        private string RequestLength
        {
            get { return _strRequest; }
            set { _strRequest = value; }
        }

        /// <summary>
        /// Provide your outgoing email server to use are your SMTP host
        /// </summary>
        public string SmtpHost
        {
            get { return _smtpHost; }
            set { _smtpHost = value; }
        }

        /// <summary>
        /// Provide the port your outgoing SMTP host uses
        /// </summary>
        public string SmtpPort
        {
            get { return _smtpPort; }
            set { _smtpPort = value; }
        }

        /// <summary>
        /// This is the email address that will show to the customer and you. This most likely
        /// needs to be a valid email address that your SMTP server will accept
        /// Examples would be something like no-reply@yourdomain.com
        /// </summary>
        public string FromEmail
        {
            get { return _fromEmail; }
            set { _fromEmail = value; }
        }

        /// <summary>
        /// This is the password that the FromEmail property will use. This needs to be the password
        /// for the email account itself
        /// </summary>
        public string FromEmailPassword
        {
            get { return _fromEmailPassword; }
            set { _fromEmailPassword = value; }
        }

        /// <summary>
        /// This is the email address that you use for yourself. This should be set to
        /// the email that is registered for your PayPal account.
        /// </summary>
        public string ToEmail
        {
            get { return _toEmail; }
            set { _toEmail = value; }
        }

        /// <summary>
        /// Email address or Account ID of the payment recipient.  This is equivalent
        ///  to the value of receiver_email if the payment is sent to the primary account
        /// , which is most cases it is.  This value is that value of what is set in the button html
        /// markup.  This value also get normalized to lowercase when coming back from PayPal
        /// </summary>
        private string Business
        {
            get { return _business; }
            set { _business = value; }
        }


        /// <summary>
        /// Unique transaction ID generated by PayPal. Helpful to use for checking
        ///  against fraud to make sure the transaction hasn't already occured.
        /// </summary>
        private string TXN_ID
        {
            get { return _txnID; }
            set { _txnID = value; }
        }

        /// <summary>
        /// Type of transaction from the customer. Possible values are
        /// "cart", "express_checkout", "send_money", "virtual_terminal", "web-accept"
        /// </summary>
        private string TXN_Type
        {
            get { return _txnType; }
            set { _txnType = value; }
        }

        /// <summary>
        /// This is the status of the payment from the Customer.Possible values are: 
        /// "Canceled_Reversal", "Completed", "Denied", "Expired", "Failed", "Pending",
        ///  "Processed", "Refunded", "Reversed", "Voided"
        /// </summary>
        private string PaymentStatus
        {
            get { return _paymentStatus; }
            set { _paymentStatus = value; }
        }

        /// <summary>
        /// Primary email address of you, the recipient, of the payment.
        /// </summary>
        private string ReceiverEmail
        {
            get { return _receiverEmail; }
            set { _receiverEmail = value; }
        }

        /// <summary>
        /// unique account ID of the payment recipient, which is most likely yourself.
        /// </summary>
        private string ReceiverID
        {
            get { return _receiverID; }
            set { _receiverID = value; }
        }

        /// <summary>
        /// This is the item name passed by yourself or if the customer if you let them enter in an item name
        /// </summary>
        private string ItemName
        {
            get { return _itemName; }
            set { _itemName = value; }
        }

        /// <summary>
        /// This is the item number you set for your own tracking purposes. It is not required by PayPal
        /// so if you didn't set it most likely will come back blank.
        /// </summary>
        private string ItemNumber
        {
            get { return _itemNumber; }
            set { _itemNumber = value; }
        }

        /// <summary>
        /// Quantity of the item lc_Ordered by the customer
        /// </summary>
        private string Quantity
        {
            get { return _quantity; }
            set { _quantity = value; }
        }

        /// <summary>
        /// Quantity of the items in the shopping cart from the Customer
        /// </summary>
        private string QuantityCartItems
        {
            get { return _qtyCartItems; }
            set { _qtyCartItems = value; }
        }

        /// <summary>
        /// Invoice number passed by yourself, if you didn't pass it to PayPal then this is omitted.
        /// </summary>
        private string Invoice
        {
            get { return _invoice; }
            set { _invoice = value; }
        }

        /// <summary>
        /// Custom value passed by yourself with the item.
        /// </summary>
        private string Custom
        {
            get { return _custom; }
            set { _custom = value; }
        }

        /// <summary>
        /// Memo entered in by the customer on PayPal website note field
        /// </summary>
        private string Memo
        {
            get { return _memo; }
            set { _memo = value; }
        }

        /// <summary>
        /// Amount of tax charged on the payment
        /// </summary>
        private string Tax
        {
            get { return _tax; }
            set { _tax = value; }
        }

        /// <summary>
        /// Full USD amount of customer's payment before the PayPal fee is subtracted
        /// </summary>
        private string PaymentGross
        {
            get { return _paymentGross; }
            set { _paymentGross = value; }
        }

        /// <summary>
        /// Date Time stamp created by PayPal in the following format: 
        /// HH:MM:SS DD Mmm YY, YYYY PST
        /// </summary>
        private string PaymentDate
        {
            get { return _paymentDate; }
            set { _paymentDate = value; }
        }

        /// <summary>
        /// PayPal's transaction fees associated with purchase.
        /// </summary>
        private string PaymentFee
        {
            get { return _paymentFee; }
            set { _paymentFee = value; }
        }


        /// <summary>
        /// This is the email that the customer used on PayPal or that
        /// is registered with PayPal
        /// </summary>
        private string PayerEmail
        {
            get { return _payerEmail; }
            set { _payerEmail = value; }
        }

        /// <summary>
        /// Customer's phone number
        /// </summary>
        private string PayerPhone
        {
            get { return _payerPhone; }
            set { _payerPhone = value; }
        }

        /// <summary>
        /// Customer's company name if they represent a business
        /// </summary>
        private string PayerBusinessName
        {
            get { return _payerBusinessName; }
            set { _payerBusinessName = value; }
        }

        /// <summary>
        /// This variable is only set if the payment_status=Pending. Possible values are the following:
        /// "address", "authorization", "echeck", "intl", "multi-currency", "unilateral", "upgrade",
        ///  "verify", other"
        /// </summary>
        private string PendingReason
        {
            get { return _pendingReason; }
            set { _pendingReason = value; }
        }

        /// <summary>
        /// This is indicated from what is set in your PayPal profile settings
        /// </summary>
        private string ShippingMethod
        {
            get { return _shippingMethod; }
            set { _shippingMethod = value; }
        }

        /// <summary>
        /// Shipping charges associated with the lc_Order.
        /// </summary>
        private string Shipping
        {
            get { return _shipping; }
            set { _shipping = value; }
        }

        /// <summary>
        /// Customer's First Name
        /// </summary>
        private string PayerFirstName
        {
            get { return _firstName; }
            set { _firstName = value; }
        }

        /// <summary>
        /// Customer's Last Name
        /// </summary>
        private string PayerLastName
        {
            get { return _lastName; }
            set { _lastName = value; }
        }

        /// <summary>
        /// Customer's street address
        /// </summary>
        private string PayerAddress
        {
            get { return _address; }
            set { _address = value; }
        }

        /// <summary>
        /// Customer's city
        /// </summary>
        private string PayerCity
        {
            get { return _city; }
            set { _city = value; }
        }

        /// <summary>
        /// Customer state of address
        /// </summary>
        private string PayerState
        {
            get { return _state; }
            set { _state = value; }
        }

        /// <summary>
        /// Zip code of customer's address
        /// </summary>
        private string PayerZipCode
        {
            get { return _zip; }
            set { _zip = value; }
        }

        /// <summary>
        /// Customer's country
        /// </summary>
        private string PayerCountry
        {
            get { return _country; }
            set { _country = value; }
        }

        /// <summary>
        /// Customer's 2 character country code
        /// </summary>
        private string PayerCountryCode
        {
            get { return _countryCode; }
            set { _countryCode = value; }
        }

        /// <summary>
        /// The the address provided is either confirmed or uncomfirmed from PayaPal. Possible values  from PayPal
        /// are going to be "confirmed" or "unconfirmed"
        /// </summary>
        private string PayerAddressStatus
        {
            get { return _addressStatus; }
            set { _addressStatus = value; }
        }

        /// <summary>
        /// Customer either had a verified or unverified account with PayPal. 
        /// Possible return values from PayPal are "verified" or "unverified"
        /// </summary>
        private string PayerStatus
        {
            get { return _payerStatus; }
            set { _payerStatus = value; }
        }

        /// <summary>
        /// Customer's unique ID
        /// </summary>
        private string PayerID
        {
            get { return _payerID; }
            set { _payerID = value; }
        }

        /// <summary>
        /// Type of payment from Customer. Possible values from PayPal are "echeck" and "instant"
        /// </summary>
        private string PaymentType
        {
            get { return _paymentType; }
            set { _paymentType = value; }
        }

        /// <summary>
        /// This is the version number of the IPN that makes the post.
        /// </summary>
        private string NotifyVersion
        {
            get { return _notifyVersion; }
            set { _notifyVersion = value; }
        }

        /// <summary>
        /// An encrypted string that is used to validate the transaction. You don't have to use this for anything
        ///  unless you want to keep it and store it for your records.
        /// </summary>
        private string VerifySign
        {
            get { return _verifySign; }
            set { _verifySign = value; }
        }

        #endregion

        #region "Make HTTP POST"

        /// <summary>
        /// This makes the post back to PayPal to verify the lc_Order.
        /// </summary>
        public void MakeHttpPost()
        {
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create(this.PostUrl);

            req.Method = "POST";
            req.ContentLength = this.RequestLength.Length + 21;
            req.ContentType = "application/x-www-form-urlencoded";
            byte[] param = HttpContext.Current.Request.BinaryRead(HttpContext.Current.Request.ContentLength);
            this.RequestLength = Encoding.ASCII.GetString(param);
            this.RequestLength += "&cmd=_notify-validate";
            req.ContentLength = this.RequestLength.Length;

            StreamWriter streamOut = new StreamWriter(req.GetRequestStream(), System.Text.Encoding.ASCII);
            streamOut.Write(this.RequestLength);
            streamOut.Close();
            StreamReader streamIn = new StreamReader(req.GetResponse().GetResponseStream());
            this.Response = streamIn.ReadToEnd();
            streamIn.Close();
        }

        #endregion

        #region "Check Status of Order"

        /// <summary>
        /// Gets the OrderID and marks it as complete
        /// </summary>
        private void CompletePayPalOrder()
        {
            LinqOrderAccess lo = new LinqOrderAccess();
            lo.CompleteOrder(Convert.ToInt16(ItemNumber), 0, "");
            //empty user cart
            LinqShoppingCartAccess ls = new LinqCommerce.LinqShoppingCartAccess();
            ls.DeleteOrderfromShoppingCart();

        }

        /// <summary>
        /// This checks the status of the lc_Order and notifies you via email the status.
        /// </summary>
        public void CheckStatus()
        {
            LinqOrderAccess lo = new LinqOrderAccess();
            switch (this.Response)
            {
                case "VERIFIED":
                    switch (this.PaymentStatus)
                    {
                        case "Completed":
                            if (this.ReceiverEmail == this.ToEmail)
                            {
                                switch (this.TXN_Type)
                                {
                                    case "cart":
                                        this.EmailUs("PayPal: Successful lc_Order from Cart");
                                        break;
                                    case "express_checkout":
                                        this.EmailUs("PayPal: Successful lc_Order from Express Checkout");
                                        break;
                                    case "send_money":
                                        this.EmailUs("PayPal: Successful lc_Order from Send Money");
                                        break;
                                    case "virtual_terminal":
                                        this.EmailUs("PayPal: Successful lc_Order from Virtual Terminal");
                                        break;
                                    case "web_accept":
                                        //For sandbox, insert method for completing lc_Order here
                                        CompletePayPalOrder();
                                        this.EmailUs("PayPal: Successful lc_Order from Web_Accept");
                                        break;
                                    default:
                                        this.EmailUs("PayPal: lc_Order has been placed");
                                        break;
                                }
                            }
                            else
                            {
                                //Complete the lc_Order
                                CompletePayPalOrder();
                                this.EmailUs("PayPal: Unknown lc_Order...please check your paypal account");
                            }
                            break;
                        case "Pending":
                            switch (this.PendingReason)
                            {
                                case "address":
                                    this.EmailUs("PayPal: Pending lc_Order because of address");
                                    break;
                                case "authorization":
                                    this.EmailUs("PayPal: Pending lc_Order because of authorization");
                                    break;
                                case "echeck":
                                    this.EmailUs("PayPal: Pending lc_Order because of echeck");
                                    break;
                                case "intl":
                                    this.EmailUs("PayPal: Pending lc_Order because of non-US Acccount");
                                    break;
                                case "multi-currency":
                                    this.EmailUs("PayPal: Pending lc_Order because of multi-currency");
                                    break;
                                case "unilateral":
                                    this.EmailUs("PayPal: Pending lc_Order because of Unilateral");
                                    break;
                                case "upgrade":
                                    this.EmailUs("PayPal: Pending lc_Order because of Upgrade");
                                    break;
                                case "verify":
                                    this.EmailUs("PayPal: Pending lc_Order because of Verification needed");
                                    break;
                                case "other":
                                    this.EmailUs("PayPal: Pending lc_Order because of other reason");
                                    break;
                                default:
                                    this.EmailUs(string.Format("PayPal: Pending lc_Order because of unknown reason of {0}", this.PendingReason));
                                    break;
                            }
                            break;
                        case "Failed":
                            this.EmailUs("PayPal: Failed lc_Order");
                            break;
                        case "Denied":
                            this.EmailUs("PayPal: Denied lc_Order");
                            break;
                    }

                    this.EmailBuyer("lc_Order Received", "Your lc_Order has been received and will begin processing shortly.");

                    break;
                case "INVALID":
                    this.EmailUs("PayPal: Invalid Order, please review and investigate");
                    break;
                default:
                    this.EmailUs("PayPal: ERROR, response is " + this.Response);
                    break;
            }
        }


        #endregion

        #region "Mail Company the lc_Order"
        /// <summary>
        /// Email yourself/company the lc_Order. This requires a subject line. Make sure to set SMTP properties of the PayPal object 
        /// and the FromEmail and ToEmail properties as well.
        /// </summary>
        /// <param name="subject"></param>
        private void EmailUs(string subject)
        {
            MailMessage mailObj = new MailMessage();
            mailObj.From = new MailAddress(this.FromEmail);
            mailObj.Subject = subject;
            mailObj.To.Add(new MailAddress(this.ToEmail));
            mailObj.IsBodyHtml = true;
            mailObj.Body = "<br />"
            + "Transaction ID: " + this.TXN_ID + "<br />"
            + "Transaction Type:" + this.TXN_Type + "<br />"
            + "Payment Type: " + this.PaymentType + "<br />"
            + "Payment Status: " + this.PaymentStatus + "<br />"
            + "Pending Reason: " + this.PendingReason + "<br />"
            + "Payment Date: " + this.PaymentDate + "<br />"
            + "Receiver Email: " + this.ReceiverEmail + "<br />"
            + "Invoice: " + this.Invoice + "<br />"
            + "Item Number: " + this.ItemNumber + "<br />"
            + "Item Name: " + this.ItemName + "<br />"
            + "Quantity: " + this.Quantity + "<br />"
            + "Custom: " + this.Custom + "<br />"
            + "Payment Gross: " + this.PaymentGross + "<br />"
            + "Payment Fee: " + this.PaymentFee + "<br />"
            + "Payer Email: " + this.PayerEmail + "<br />"
            + "First Name: " + this.PayerFirstName + "<br />"
            + "Last Name: " + this.PayerLastName + "<br />"
            + "Street Address: " + this.PayerAddress + "<br />"
            + "City: " + this.PayerCity + "<br />"
            + "State: " + this.PayerState + "<br />"
            + "Zip Code: " + this.PayerZipCode + "<br />"
            + "Country: " + this.PayerCountry + "<br />"
            + "Address Status: " + this.PayerAddressStatus + "<br />"
            + "Payer Status: " + this.PayerStatus + "<br />"
            + "Verify Sign: " + this.VerifySign + "<br />"
            + "Notify Version: " + this.NotifyVersion + "<br />";

            SmtpClient objSmtp = new SmtpClient();

            objSmtp.Host = this.SmtpHost;
            objSmtp.Port = System.Int32.Parse(this.SmtpPort);
            objSmtp.UseDefaultCredentials = false;
            objSmtp.Credentials = new System.Net.NetworkCredential(this.FromEmail, this.FromEmailPassword);
            objSmtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            objSmtp.Send(mailObj);
        }

        #endregion

        #region "Mail the Customer the lc_Order details"

        private void EmailBuyer(string subject, string message)
        {
            MailMessage mailObj = new MailMessage();
            mailObj.From = new MailAddress(this.FromEmail);
            mailObj.Subject = subject;
            mailObj.Body = message;
            mailObj.To.Add(new MailAddress(this.PayerEmail));
            mailObj.IsBodyHtml = true;

            SmtpClient objSmtp = new SmtpClient();

            objSmtp.Host = this.SmtpHost;
            objSmtp.Port = System.Int32.Parse(this.SmtpPort);
            objSmtp.UseDefaultCredentials = false;
            objSmtp.Credentials = new System.Net.NetworkCredential(this.FromEmail, this.FromEmailPassword);
            objSmtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            objSmtp.Send(mailObj);
        }

        #endregion

        #region "Fill Properties"

        private void fillProperties()
        {
            this.RequestLength = HttpContext.Current.Request.Form.ToString();
            this.PayerCity = HttpContext.Current.Request.Form["address_city"];
            this.PayerCountry = HttpContext.Current.Request.Form["address_country"];
            this.PayerCountryCode = HttpContext.Current.Request.Form["address_country_code"];
            this.PayerState = HttpContext.Current.Request.Form["address_state"];
            this.PayerAddressStatus = HttpContext.Current.Request.Form["address_status"];
            this.PayerAddress = HttpContext.Current.Request.Form["address_street"];
            this.PayerZipCode = HttpContext.Current.Request.Form["address_zip"];
            this.PayerFirstName = HttpContext.Current.Request.Form["first_name"];
            this.PayerLastName = HttpContext.Current.Request.Form["last_name"];
            this.PayerBusinessName = HttpContext.Current.Request.Form["payer_business_name"];
            this.PayerEmail = HttpContext.Current.Request.Form["payer_email"];
            this.PayerID = HttpContext.Current.Request.Form["payer_id"];
            this.PayerStatus = HttpContext.Current.Request.Form["payer_status"];
            this.PayerPhone = HttpContext.Current.Request.Form["contact_phone"];
            this.Business = HttpContext.Current.Request.Form["business"];
            this.ItemName = HttpContext.Current.Request.Form["item_name"];
            this.ItemNumber = HttpContext.Current.Request.Form["item_number"];
            this.Quantity = HttpContext.Current.Request.Form["quantity"];
            this.ReceiverEmail = HttpContext.Current.Request.Form["receiver_email"];
            this.ReceiverID = HttpContext.Current.Request.Form["receiver_id"];
            this.Custom = HttpContext.Current.Request.Form["custom"];
            this.Memo = HttpContext.Current.Request.Form["memo"];
            this.Invoice = HttpContext.Current.Request.Form["invoice"];
            this.Tax = HttpContext.Current.Request.Form["tax"];
            this.QuantityCartItems = HttpContext.Current.Request.Form["num_cart_items"];
            this.PaymentDate = HttpContext.Current.Request.Form["payment_date"];
            this.PaymentStatus = HttpContext.Current.Request.Form["payment_status"];
            this.PaymentType = HttpContext.Current.Request.Form["payment_type"];
            this.PendingReason = HttpContext.Current.Request.Form["pending_reason"];
            this.TXN_ID = HttpContext.Current.Request.Form["txn_id"];
            this.TXN_Type = HttpContext.Current.Request.Form["txn_type"];
            this.PaymentFee = HttpContext.Current.Request.Form["mc_fee"];
            this.PaymentGross = HttpContext.Current.Request.Form["mc_gross"];
            this.NotifyVersion = HttpContext.Current.Request.Form["notify_version"];
            this.VerifySign = HttpContext.Current.Request.Form["verify_sign"];
        }

        #endregion

    }
}