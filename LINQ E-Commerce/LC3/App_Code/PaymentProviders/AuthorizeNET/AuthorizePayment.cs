using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using LinqCommerce;
using System.Web.Configuration;

/// <summary>
/// Summary description for AuthorizePayment
/// </summary>
public class AuthorizePayment
{
    #region Properties

    private static string AuthNetVersion = "3.1"; // Contains CCV support

    #endregion

    public AuthorizePayment()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static bool DoAuthorizePayment(out string message, string FirstName, string LastName, string Address,
    string City, string State, string ZIP, string Country, double Amount
        ,bool IsTest, string CCNumber, string ExpireDate, string CCV)
    {

        SectionConfigurationGroup config = (SectionConfigurationGroup)WebConfigurationManager.GetSection("LinqCommerce/AuthorizeNETSettings");
        message = null;
        WebClient objRequest = new WebClient();
        System.Collections.Specialized.NameValueCollection objInf =
          new System.Collections.Specialized.NameValueCollection(30);
        System.Collections.Specialized.NameValueCollection objRetInf =
          new System.Collections.Specialized.NameValueCollection(30);
        byte[] objRetBytes;
        string[] objRetVals;
        string strError;

        objInf.Add("x_version", AuthNetVersion);
        objInf.Add("x_delim_data", "True");
        objInf.Add("x_login", config.AuthorizeNET.APILogin);
        //objInf.Add("x_password", AuthNetPassword);
        objInf.Add("x_tran_key", config.AuthorizeNET.TransactionKey);
        objInf.Add("x_relay_response", "False");

        // Switch this to False once you go live
        objInf.Add("x_test_request", "True");

        objInf.Add("x_delim_char", ",");
        objInf.Add("x_encap_char", "|");

        // Billing Address
        objInf.Add("x_first_name", FirstName);
        objInf.Add("x_last_name", LastName);
        objInf.Add("x_address", Address);
        objInf.Add("x_city", City);
        objInf.Add("x_state", State);
        objInf.Add("x_zip", ZIP);
        objInf.Add("x_country", Country);

        objInf.Add("x_description", "lc_Order");

        // Card Details
        objInf.Add("x_card_num", CCNumber);
        //objInf.Add("x_exp_date", "01/06");
        objInf.Add("x_exp_date", ExpireDate);
        // Authorisation code of the card (CCV)
        objInf.Add("x_card_code", CCV);

        objInf.Add("x_method", "CC");
        objInf.Add("x_type", "AUTH_CAPTURE");
        objInf.Add("x_amount", Amount.ToString());

        // Currency setting. Check the guide for other supported currencies
        objInf.Add("x_currency_code", "USD");

        try
        {
            // Pure Test Server
            if (IsTest)
            {
                objRequest.BaseAddress =
                  "https://test.authorize.net/gateway/transact.dll";
            }

            // Actual Server
            else
            {
                objRequest.BaseAddress =
                  "https://secure.authorize.net/gateway/transact.dll";
            }

            objRetBytes =
              objRequest.UploadValues(objRequest.BaseAddress, "POST", objInf);
            objRetVals =
              System.Text.Encoding.ASCII.GetString(objRetBytes).Split(",".ToCharArray());

            if (objRetVals[0].Trim(char.Parse("|")) == "1")
            {
                // Returned Authorisation Code
                //this.lblAuthNetCode.Text = objRetVals[4].Trim(char.Parse("|"));
                // Returned Transaction ID
                //this.lblAuthNetTransID.Text = objRetVals[6].Trim(char.Parse("|"));
                //message = objRetVals[4].Trim(char.Parse("|"));
                message = "Success! Your lc_Order shall be shipped soon.";
                return true;
            }
            else
            {
                // Error!
                strError = objRetVals[3].Trim(char.Parse("|")) + " (" +
                  objRetVals[2].Trim(char.Parse("|")) + ")";

                if (objRetVals[2].Trim(char.Parse("|")) == "44")
                {
                    // CCV transaction decline
                    strError += "Our Card Code Verification (CCV) returned " +
                      "the following error: ";

                    switch (objRetVals[38].Trim(char.Parse("|")))
                    {
                        case "N":
                            strError += "Card Code does not match.";
                            break;
                        case "P":
                            strError += "Card Code was not processed.";
                            break;
                        case "S":
                            strError += "Card Code should be on card but was not indicated.";
                            break;
                        case "U":
                            strError += "Issuer was not certified for Card Code.";
                            break;
                    }
                }

                if (objRetVals[2].Trim(char.Parse("|")) == "45")
                {
                    if (strError.Length > 1)
                        strError += "<br />n";

                    // AVS transaction decline
                    strError += "Our Address Verification System (AVS) " +
                      "returned the following error: ";

                    switch (objRetVals[5].Trim(char.Parse("|")))
                    {
                        case "A":
                            strError += " the zip code entered does not match " +
                              "the billing address.";
                            break;
                        case "B":
                            strError += " no information was provided for the AVS check.";
                            break;
                        case "E":
                            strError += " a general error occurred in the AVS system.";
                            break;
                        case "G":
                            strError += " the credit card was issued by a non-US bank.";
                            break;
                        case "N":
                            strError += " neither the entered street address nor zip " +
                              "code matches the billing address.";
                            break;
                        case "P":
                            strError += " AVS is not applicable for this transaction.";
                            break;
                        case "R":
                            strError += " please retry the transaction; the AVS system " +
                              "was unavailable or timed out.";
                            break;
                        case "S":
                            strError += " the AVS service is not supported by your " +
                              "credit card issuer.";
                            break;
                        case "U":
                            strError += " address information is unavailable for the " +
                              "credit card.";
                            break;
                        case "W":
                            strError += " the 9 digit zip code matches, but the " +
                              "street address does not.";
                            break;
                        case "Z":
                            strError += " the zip code matches, but the address does not.";
                            break;
                    }
                }

                // strError contains the actual error
                //lblMsg1.Text = strError;
                message = strError;
                return false;
            }
        }
        catch (Exception ex)
        {
            //lblMsg1.Text = ex.Message;
            message = ex.Message.ToString();
            return false;
        }
    }

}
