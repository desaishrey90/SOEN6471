using System;
using System.Net;
using PayPal.Payments.Common;
using PayPal.Payments.Common.Utility;
using PayPal.Payments.DataObjects;
using PayPal.Payments.Transactions;
using System.Web.Configuration;
using System.Configuration;

namespace LinqCommerce
{
    /// <summary>
    /// This class uses the Payflow .NET SDK Data Objects to do a Sale transaction including some business rules.
    /// This class depicts the use of the Data Objects which would normally be used in a transaction.
    /// </summary>
    public class DOSaleCompleteCS
    {
        public DOSaleCompleteCS()
        {
        }

        /// <summary>
        /// Returns an approved/disapproved message, based on CC info
        /// </summary>
        /// <param name="RespMsg"></param>
        /// <param name="Amount"></param>
        /// <param name="BillFirstName"></param>
        /// <param name="BillLastName"></param>
        /// <param name="BillCompany"></param>
        /// <param name="BillAddress"></param>
        /// <param name="BillAddress2"></param>
        /// <param name="BillCity"></param>
        /// <param name="BillZip"></param>
        /// <param name="BillState"></param>
        /// <param name="CCNumber"></param>
        /// <param name="CCV"></param>
        /// <param name="ExpireDate"></param>
        public static bool DoCompleteSale(out string RespMsg, double Amount, string BillFirstName, string BillLastName, string BillCompany,
            string BillAddress, string BillAddress2, string BillCity, string BillZip,
            string BillState, string CCNumber, string CCV, string ExpireDate, string BillPhone)
        {
            RespMsg = null;
            #region Docs
            //Console.WriteLine("------------------------------------------------------");
            //Console.WriteLine("Executing Sample from File: DOSaleComplete.cs");
            //Console.WriteLine("------------------------------------------------------");

            // NOTE: All information regarding the available objects within payflow_dotNET.dll can be found in the API doc
            //       found under the "Docs" directory of the installed SDK.  You will also need to refer to the Website
            //		 Payments Pro Payflow Edition or Payflow Pro Developer’s Guide found in the downloads section of PayPal
            //		 Manager at https://manager.paypal.com.
            //
            // Request ID: the request Id is a unique id that you send with your transaction data.  This Id if not changed
            // will help prevent duplicate transactions.  The idea is to set this Id outside the loop or if on a page,
            // prior to the final confirmation page.
            //
            // Once the transaction is sent and if you don't receive a response you can resend the transaction and the 
            // server will respond with the response data of the original submission.  Also, the object,
            // Trans.Response.TransactionResponse.Duplicate will be set to "1" if the transaction is a duplicate.
            //
            // This allows you to resend transaction requests should there be a network or user issue without re-charging
            // a customers credit card.
            //
            // Set the Request ID
            // Uncomment the line below and run two concurrent transactions to show how duplicate works.  You will notice on
            // the second transaction that the response returned is identical to the first, but the duplicate object will be set.
            // String strRequestID = "123456";
            // Comment out this line if testing duplicate response. 
            #endregion
            String strRequestID = PayflowUtility.RequestId;

            #region Docs
            // *** Create the Data Objects. ***
            //
            // *** Create the User data object with the required user details. ***
            //         
            // Should you choose to store the login information (Vendor, User, Partner and Password) in
            // app.config, you can retrieve the data using PayflowUtility.AppSettings. 
            //
            // For Example:
            //
            //      App.Config Entry: <add key="PayflowPartner" value="PayPal"/>
            //
            //      String mUser = PayflowUtility.AppSettings("PayflowUser"); 
            //      String mVendor = PayflowUtility.AppSettings("PayflowVendor");
            //      String mPartner = PayflowUtility.AppSettings("PayflowPartner");
            //      String mPassword = PayflowUtility.AppSettings("PayflowPassword");
            //
            // UserInfo User = new UserInfo (mUser, mVendor, mPartner, mPassword);

            // Remember: <vendor> = your merchant (login id), <user> = <vendor> unless you created a separate <user> for Payflow Pro.
            // Result code 26 will be issued if you do not provide both the <vendor> and <user> fields.

            // The other most common error with authentication is result code 1, user authentication failed.  This is usually
            // due to invalid account information or ip restriction on the account.  You can verify ip restriction by logging 
            // into Manager.
            #endregion

            SectionConfigurationGroup config = (SectionConfigurationGroup)WebConfigurationManager.GetSection("LinqCommerce/Payment");

            UserInfo User = new UserInfo(config.PayPal.UserID, config.PayPal.VendorID, config.PayPal.Partner, config.PayPal.PayFlowPassword);

            #region Docs
            // *** Create the Payflow Connection data object with the required connection details. ***
            //
            // To allow the ability to change easily between the live and test servers, the PFPRO_HOST 
            // property is defined in the App.config (or web.config for a web site) file.  However,
            // you can also pass these fields and others directly from the PayflowConnectionData contructor. 
            // This will override the values passed in the App.config file.
            //
            // For Example:
            //
            //      Example values passed below are as follows:
            //      Payflow Pro Host address : pilot-payflowpro.paypal.com 
            //      Payflow Pro Host Port : 443
            //      Timeout : 45 ( in seconds )
            //
            //      PayflowConnectionData Connection = new PayflowConnectionData("pilot-payflowpro.paypal.com", 443, 45, "",0,"","");
            //
            // Obtain Host address from the app.config file and use default values for
            // timeout and proxy settings.

            //PayflowConnectionData Connection = new PayflowConnectionData();
            #endregion
            //Test Server
                PayflowConnectionData Connection = new PayflowConnectionData("pilot-payflowpro.paypal.com", 443, 45, "", 0, "", "");
                //Live Server
                //PayflowConnectionData Connection = new PayflowConnectionData("payflowpro.paypal.com", 443, 45, "", 0, "", "");
            // *** Create a new Invoice data object ***
                // Set Invoice object with the Amount, Billing & Shipping Address, etc. ***

                Invoice Inv = new Invoice();

                // Set the amount object.
                // Currency Code USD is US ISO currency code.  If no code passed, USD is default.
                // See the Developer's Guide regarding the CURRENCY parameter for the list of
                // three-character currency codes available.
                Currency Amt = new Currency(new decimal(Amount), "USD");

                #region Docs
                // A valid amount has either no decimal value or only a two decimal value. 
                // An invalid amount will generate a result code 4.
                //
                // For values which have more than two decimal places such as:
                // Currency Amt = new Currency(new Decimal(25.1214));
                // You will either need to truncate or round as needed using the following property: Amt.NoOfDecimalDigits
                //
                // If the NoOfDecimalDigits property is used then it is mandatory to set one of the following
                // properties to true.
                //
                //Amt.Round = true;
                //Amt.Truncate = true;
                //
                // For Currencies without a decimal, you'll need to set the NoOfDecimalDigits = 0.
                //Amt.NoOfDecimalDigits = 0;
                #endregion
                Inv.Amt = Amt;

                #region Docs
                // PONum, InvNum and CustRef are sent to the processors and could show up on a customers
                // or your bank statement. These fields are reportable but not searchable in PayPal Manager.
                //Inv.PoNum = "PO12345";
                //Inv.InvNum = "INV12345";
                //Inv.CustRef ="CustRef1";
                //Inv.MerchDescr = "Merchant Descr";
                //Inv.MerchSvc = "Merchant Svc";

                // Comment1 and Comment2 fields are searchable within PayPal Manager .
                // You may want to populate these fields with any of the above three fields or any other data.
                // However, the search is a case-sensitive and is a non-wildcard search, so plan accordingly.
                //Inv.Comment1 = "Comment1";
                //Inv.Comment2 = "Comment2";

                // There are additional Invoice parameters that could assist you in obtaining a better rate
                // from your merchant bank.  Refer to the Payflow Pro Developer’s Guide
                // and consult your Internet Merchant Bank on what parameters (if any) you can use.
                // Some of the parameters could include:
                // Inv.Recurring = "Y";
                // Inv.TaxExempt = "Y";

                // *** Set the Billing Address details. ***
                //
                // The billing details below except for Street and Zip are for reporting purposes only. 
                // It is suggested that you pass all the billing details for enhanced reporting and as data backup.
                #endregion
                // Create the BillTo object.
                BillTo Bill = new BillTo();

                // Set the customer name.
                Bill.FirstName = BillFirstName;
                // Bill.MiddleName = "M";
                Bill.LastName = BillLastName;
                Bill.CompanyName = BillCompany;

                // It is highly suggested that you pass at minimum Street and Zip for AVS response.
                // However, AVS is only supported by US banks and some foreign banks.  See the Payflow 
                // Developer's Guide for more information.  Sending these fields could help in obtaining
                // a lower discount rate from your Internet merchant Bank.  Consult your bank for more information.

                Bill.Street = BillAddress;
                // Secondary street address.
                Bill.BillToStreet2 = BillAddress2;
                Bill.City = BillCity;
                Bill.State = BillState;
                Bill.Zip = BillZip;
                // BillToCountry code is based on numeric ISO country codes. (e.g. 840 = USA)
                // For more information, refer to the Payflow Developer's Guide.
                //Bill.BillToCountry = "840";			

                Bill.PhoneNum = BillPhone;
                // Secondary phone numbers (could be mobile number etc).
                // Bill.BillToPhone2 = "222-222-2222";
                // Bill.HomePhone = "555-123-9867";
                // Bill.Fax = "555-343-5444";

                //Bill.Email = "Joe.Smith@anyemail.com";

                // Set the BillTo object into invoice.
                Inv.BillTo = Bill;

                #region Docs
                // Shipping details may not be necessary if providing a
                // service or downloadable product such as software etc.
                //
                // Set the Shipping Address details.
                // The shipping details are for reporting purposes only. 
                // It is suggested that you pass all the shipping details for enhanced reporting.
                //
                // Create the ShipTo object.
                //ShipTo Ship = new ShipTo();

                // To prevent an 'Address Mismatch' fraud trigger, we are shipping to the billing address.  However,
                // shipping parameters are listed.
                // Comment line below if you want a separate Ship To address.
                //Ship = Bill.Copy();

                // Uncomment statements below to send to separate Ship To address.

                // Set the recipient's name.			
                // Ship.ShipToFirstName = "Sam";
                // Ship.ShipToMiddleName = "J";
                // Ship.ShipToLastName = "Spade";
                // Ship.ShipToStreet = "456 Shipping St.";
                // Ship.ShipToStreet2 = "Apt A";
                // Ship.ShipToCity = "Las Vegas";
                // Ship.ShipToState = "NV";
                // Ship.ShipToZip = "99999";
                // ShipToCountry code is based on numeric ISO country codes. (e.g. 840 = USA)
                // For more information, refer to the Payflow Pro Developer's Guide.
                // Ship.ShipToCountry = "840";
                // Ship.ShipToPhone = "555-123-1233";
                // Secondary phone numbers (could be mobile number etc).
                // Ship.ShipToPhone2 = "555-333-1222";
                // Ship.ShipToEmail = "Sam.Spade@email.com";
                // Ship.ShipFromZip = Bill.Zip;

                // Following 2 items are just for reporting purposes and are not required.
                // Ship.ShipCarrier = "UPS";
                // Ship.ShipMethod = "Ground";

                //Inv.ShipTo = Ship;

                // *** 	Create Customer Data ***
                // There are additional CustomerInfo parameters that can be sent to assist in obtaining a better discount rate.
                // Refer to the Website Payments Pro Payflow Edition Developer’s Guide and consult with your Internet
                // Merchant Bank regarding what parameters to send.
                // Some of the parameters could include:
                //
                //CustomerInfo CustInfo = new CustomerInfo();
                //CustInfo.CustCode = "Cust123";
                //CustInfo.CustId = "CustomerID";

                // *** Create a new Payment Device - Credit Card data object. ***
                // The input parameters are Credit Card Number and Expiration Date of the Credit Card.
                // Note: Expiration date is in the format MMYY.
                #endregion
                CreditCard CC = new CreditCard(CCNumber, ExpireDate);

                // Example of Swipe Transaction.
                // See DOSwipe.cs example for more information.
                //SwipeCard Swipe = new SwipeCard(";5105105105105100=15121011000012345678?");

                // *** Card Security Code ***
                // This is the 3 or 4 digit code on either side of the Credit Card.
                // It is highly suggested that you obtain and pass this information to help prevent fraud.
                // Sending this fields could help in obtaining a lower discount rate from your Internet merchant Bank.
                // CVV2 is not required when performing a Swipe transaction as the card is present.
                CC.Cvv2 = CCV;
                // Name on Credit Card is optional.
                //CC.Name = "Joe M Smith";

                // *** Create a new Tender - Card Tender data object. ***
                CardTender Card = new CardTender(CC);  // credit card
                //CardTender Card = new CardTender(Swipe); // swipe card

                // *** Create a new Sale Transaction. ***
                // The Request Id is the unique id necessary for each transaction.  If you are performing an authorization
                // - delayed capture trnsaction, make sure that you pass two different unique request ids for each of the
                // transaction.
                // If you pass a non-unique request id, you will receive the transaction details from the original request.
                // The only difference is you will also receive a parameter DUPLICATE indicating this request id has been used
                // before.
                // The Request Id can be any unique number such lc_Order id, invoice number from your implementation or a random
                // id can be generated using the PayflowUtility.RequestId.
                SaleTransaction Trans = new SaleTransaction(User, Connection, Inv, Card, strRequestID);

                // Transaction results (especially values for declines and error conditions) returned by each PayPal-supported
                // processor vary in detail level and in format. The Payflow Verbosity parameter enables you to control the kind
                // and level of information you want returned. 

                // By default, Verbosity is set to LOW. A LOW setting causes PayPal to normalize the transaction result values. 
                // Normalizing the values limits them to a standardized set of values and simplifies the process of integrating 
                // the Payflow SDK.

                // By setting Verbosity to MEDIUM, you can view the processor’s raw response values. This setting is more “verbose”
                // than the LOW setting in that it returns more detailed, processor-specific information. 

                //  Review the chapter in the Payflow Pro Developer's Guide regarding VERBOSITY and the INQUIRY function for more details.

                // Set the transaction verbosity to MEDIUM.
                Trans.Verbosity = "MEDIUM";

                // Submit the Transaction
                Response Resp = Trans.SubmitTransaction();

                // Display the transaction response parameters.
                if (Resp != null)
                {
                    // Get the Transaction Response parameters.
                    TransactionResponse TrxnResponse = Resp.TransactionResponse;

                    #region Docs
                    // Refer to the Payflow Pro .NET API Reference Guide and the Payflow Pro Developer's Guide
                    // for explanation of the items returned and for additional information and parameters available.
                    //if (TrxnResponse != null)
                    //{
                    //    Console.WriteLine("Transaction Response:");
                    //        Console.WriteLine("Result Code (RESULT) = " + TrxnResponse.Result);
                    //        Console.WriteLine("Transaction ID (PNREF) = " + TrxnResponse.Pnref);
                    //        Console.WriteLine("Response Message (RESPMSG) = " + TrxnResponse.RespMsg);
                    //        Console.WriteLine("Authorization (AUTHCODE) = " + TrxnResponse.AuthCode);
                    //        Console.WriteLine("Street Address Match (AVSADDR) = " + TrxnResponse.AVSAddr);
                    //        Console.WriteLine("Streep Zip Match (AVSZIP) = " + TrxnResponse.AVSZip);
                    //        Console.WriteLine("International Card (IAVS) = " + TrxnResponse.IAVS);
                    //        Console.WriteLine("CVV2 Match (CVV2MATCH) = " + TrxnResponse.CVV2Match);
                    //        Console.WriteLine("------------------------------------------------------");
                    //        Console.WriteLine("Verbosity Response:");
                    //        Console.WriteLine("Processor AVS (PROCAVS) = " + TrxnResponse.ProcAVS);
                    //        Console.WriteLine("Processor CSC (PROCCVV2) = " + TrxnResponse.ProcCVV2);
                    //}

                    // Get the Fraud Response parameters.
                    // All trial accounts come with basic Fraud Protection Services enabled.
                    // Review the PayPal Manager guide to set up your Fraud Filters prior to 
                    // running this sample code.
                    // If Fraud Filters are not set, you will receive a RESULT code 126.
                    //FraudResponse FraudResp =  Resp.FraudResponse;
                    //if (FraudResp != null)
                    //{
                    //    Console.WriteLine("Fraud Response:");
                    //    Console.WriteLine("Pre-Filters (PREFPSMSG) = " + FraudResp.PreFpsMsg);
                    //    Console.WriteLine("Post-Filters (POSTFPSMSG) = " + FraudResp.PostFpsMsg);
                    //}

                    // Was this a duplicate transaction?
                    // If this value is true, then the orignal response of the orginal transaction will
                    // be returned.  The transction type listed in Manager will be "N" and the Original
                    // Transaction ID will be the PNREF of the original transaction.  The value would be
                    // true if the Request ID of the Transaction Object has not been changed.
                    //Console.WriteLine("------------------------------------------------------");
                    //Console.WriteLine("Duplicate Response:");
                    //string DupMsg; 
                    //if (TrxnResponse.Duplicate == "1") 
                    //{ 
                    //    DupMsg = "Duplicate Transaction"; 
                    //} 
                    //else 
                    //{ 
                    //    DupMsg = "Not a Duplicate Transaction"; 
                    //} 
                    //Console.WriteLine(("Duplicate Transaction (DUPLICATE) = " + DupMsg));

                    // Example of adding in business rules.  This is not an exhaustive list of failures or issues
                    // that could arise.  Review the list of Result Code's in the Developer's Guide and add logic as 
                    // you deem necessary.
                    // 
                    // These responses are just an example of what you can do and how you handle the response received
                    // from the bank is dependent on your business rules and needs.
                    #endregion
                    //string RespMsg; 
                    // Evaluate Result Code
                    if (TrxnResponse.Result == 0)
                    {
                        RespMsg = "Your transaction was approved. Will ship in 24 hours.";
                        return true;
                    }
                    else
                    {
                        if (TrxnResponse.Result < 0)
                        {
                            // Transaction failed.
                            RespMsg = "There was an error processing your transaction. Please contact Customer Service." + Environment.NewLine + "Error: " + TrxnResponse.Result.ToString();
                        }
                        else if (TrxnResponse.Result == 1 || TrxnResponse.Result == 26)
                        {
                            // This is just checking for invalid login information.  You would not want to display this to your customers.
                            RespMsg = "Account configuration issue.  Please verify your login credentials.";
                        }
                        else if (TrxnResponse.Result == 12)
                        {
                            // Hard decline from bank.
                            RespMsg = "Your transaction was declined.";
                        }
                        else if (TrxnResponse.Result == 13)
                        {
                            // Voice authorization required.
                            RespMsg = "Your Transaction is pending. Contact Customer Service to complete your lc_Order.";
                        }
                        else if (TrxnResponse.Result == 23 || TrxnResponse.Result == 24)
                        {
                            // Issue with credit card number or expiration date.
                            RespMsg = "Invalid credit card information. Please re-enter.";
                        }
                        else if (TrxnResponse.Result == 125)
                        {
                            // 125, 126 and 127 are Fraud Responses.
                            // Refer to the Payflow Pro Fraud Protection Services User's Guide or Website Payments Pro Payflow Edition - Fraud Protection Services User's Guide.
                            RespMsg = "Your Transactions has been declined. Contact Customer Service.";
                        }
                        else if (TrxnResponse.Result == 126)
                        {
                            // Decline transaction if AVS fails.
                            if ((TrxnResponse.AVSAddr != "Y" | TrxnResponse.AVSZip != "Y"))
                            {
                                // Display message that transaction was not accepted.  At this time, you
                                // could display message that information is incorrect and redirect user 
                                // to re-enter STREET and ZIP information.  However, there should be some sort of
                                // 3 strikes your out check.
                                RespMsg = "Your billing information does not match. Please re-enter.";
                            }
                            else
                            {
                                RespMsg = "Your Transaction is Under Review. We will notify you via e-mail if accepted.";
                            }
                        }
                        else if (TrxnResponse.Result == 127)
                        {
                            RespMsg = "Your Transaction is Under Review. We will notify you via e-mail if accepted.";
                        }
                        else
                        {
                            // Error occurred, display normalized message returned.
                            RespMsg = TrxnResponse.RespMsg;
                        }
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
        }
    }