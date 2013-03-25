using System;
using System.Configuration;
using System.ComponentModel;

namespace LinqCommerce
{
    ///<summary>
    /// This controls reading properties from the Web.config for the LinqCommerce Section group
    /// </summary>
    /// 
    //For more info on which each field does, review this manual:
    //https://cms.paypal.com/cms_content/US/en_US/files/developer/PP_WebsitePaymentsStandard_IntegrationGuide.pdf
    public class SectionConfigurationGroup : ConfigurationSection
    {
        #region PayPal Section Group
        // Create a "PayPal" element.
        [ConfigurationProperty("PayPal")]
        public PayPalElement PayPal
        {
            get
            {
                return (PayPalElement)this["PayPal"];
            }
            set
            {
                this["PayPal"] = value;
            }
        }

        //Define the PayPal Element
        public class PayPalElement : ConfigurationElement
        {
            [ConfigurationProperty("PayPalEMailAccount", IsRequired = false)]
            public string PayPalEMailAccount
            {
                get
                {
                    return (String)this["PayPalEMailAccount"];
                }
                set
                {
                    this["PayPalEMailAccount"] = value;
                }
            }

            [ConfigurationProperty("PayPalEnvironment", IsRequired = true, DefaultValue="sandbox")]
            public string PayPalEnvironment
            {
                get
                {
                    return (String)this["PayPalEnvironment"];
                }
                set
                {
                    this["PayPalEnvironment"] = value;
                }
            }

            [ConfigurationProperty("URLReturn", IsRequired = false)]
            public string URLReturn
            {
                get
                {
                    return (String)this["URLReturn"];
                }
                set
                {
                    this["URLReturn"] = value;
                }
            }

            [ConfigurationProperty("PayPalHeaderImage", IsRequired = false)]
            public string PayPayHeaderImage
            {
                get
                {
                    return (String)this["PayPalHeaderImage"];
                }
                set
                {
                    this["PayPalHeaderImage"] = value;
                }
            }

            [ConfigurationProperty("URLCancel", IsRequired = false)]
            public string URLCancel
            {
                get
                {
                    return (String)this["URLCancel"];
                }
                set
                {
                    this["URLCancel"] = value;
                }
            }

            [Description("UserID for PayPal PayFlow Pro")]
            [ConfigurationProperty("UserID", IsRequired = false)]
            public string UserID
            {
                get
                {
                    return (String)this["UserID"];
                }
                set
                {
                    this["UserID"] = value;
                }
            }

            [Description("VendorID for PayPal PayFlow Pro")]
            [ConfigurationProperty("VendorID", IsRequired = false)]
            public string VendorID
            {
                get
                {
                    return (String)this["VendorID"];
                }
                set
                {
                    this["VendorID"] = value;
                }
            }

            [Description("Password for PayPal PayFlow Pro")]
            [ConfigurationProperty("PayFlowPassword", IsRequired = false)]
            public string PayFlowPassword
            {
                get
                {
                    return (String)this["PayFlowPassword"];
                }
                set
                {
                    this["PayFlowPassword"] = value;
                }
            }

            [Description("Partner for PayPal PayFlow Pro")]
            [ConfigurationProperty("Partner", IsRequired = false, DefaultValue="PayPal")]
            public string Partner
            {
                get
                {
                    return (String)this["Partner"];
                }
                set
                {
                    this["Partner"] = value;
                }
            }

            
        }
        #endregion

        //#region Error Handling Settings

        ////Create ErrorHandlingSettings Element
        //[ConfigurationProperty("ErrorHandlingSettings")]
        //public ErrorHandlingSettingsElement ErrorHandlingSettings
        //{
        //    get
        //    {
        //        return (ErrorHandlingSettingsElement)this["ErrorHandlingSettings"];
        //    }
        //    set
        //    {
        //        this["ErrorHandlingSettings"] = value;
        //    }
        //}

        //public class ErrorHandlingSettingsElement : ConfigurationElement
        //{

        //    [ConfigurationProperty("MailServer", IsRequired = false)]
        //    public string MailServer
        //    {
        //        get
        //        {
        //            return (String)this["MailServer"];
        //        }
        //        set
        //        {
        //            this["MailServer"] = value;
        //        }
        //    }

        //    [ConfigurationProperty("EnableErrorLogEmail", IsRequired = false)]
        //    public bool EnableErrorLogEmail
        //    {
        //        get
        //        {
        //            return (bool)this["EnableErrorLogEmail"];
        //        }
        //        set
        //        {
        //            this["EnableErrorLogEmail"] = value;
        //        }
        //    }
        //    [ConfigurationProperty("ErrorLogEmail", IsRequired = false)]
        //    public string ErrorLogEmail
        //    {
        //        get
        //        {
        //            return (String)this["ErrorLogEmail"];
        //        }
        //        set
        //        {
        //            this["ErrorLogEmail"] = value;
        //        }
        //    }
        //    [ConfigurationProperty("ErrorLogEmailFrom", IsRequired = false)]
        //    public string ErrorLogEmailFrom
        //    {
        //        get
        //        {
        //            return (String)this["ErrorLogEmailFrom"];
        //        }
        //        set
        //        {
        //            this["ErrorLogEmailFrom"] = value;
        //        }
        //    }

        //}

        //#endregion

        #region Product Settings
        //Create ProductSettings Element
        [ConfigurationProperty("ProductSettings")]
        public ProductSettingsElement ProductSettings
        {
            get
            {
                return (ProductSettingsElement)this["ProductSettings"];
            }
            set
            {
                this["ProductSettings"] = value;
            }
        }

        public class ProductSettingsElement : ConfigurationElement
        {
            [ConfigurationProperty("EnableDigitalProducts", DefaultValue = true, IsRequired = true)]
            public bool EnableDigitalProducts
            {
                get
                {
                    return (bool)this["EnableDigitalProducts"];
                }
                set
                {
                    this["EnableDigitalProduct"] = value;
                }
            }

            [ConfigurationProperty("DigitalCancelURL")]
            public String DigitalCancelURL
            {
                get
                {
                    return (String)this["DigitalCancelURL"];
                }
                set
                {
                    this["DigitalCancelURL"] = value;
                }
            }

            [ConfigurationProperty("DigitalReturnURL")]
            public String DigitalReturnURL
            {
                get
                {
                    return (String)this["DigitalReturnURL"];
                }
                set
                {
                    this["DigitalReturnURL"] = value;
                }
            }


            [ConfigurationProperty("ProductImagePath", DefaultValue = "~/ProductImages/", IsRequired = true)]
            public String ProductImagePath
            {
                get
                {
                    return (String)this["ProductImagePath"];
                }
                set
                {
                    this["ProductImagePath"] = value;
                }
            }

            [ConfigurationProperty("EnableInventory", DefaultValue = true, IsRequired = true)]
            public bool EnableInventory
            {
                get
                {
                    return (bool)this["EnableInventory"];
                }
                set
                {
                    this["EnableInventory"] = value;
                }
            }

            [ConfigurationProperty("EnableRecommendedProducts", DefaultValue = true, IsRequired = true)]
            public bool EnableRecommendedProducts
            {
                get
                {
                    return (bool)this["EnableRecommendedProducts"];
                }
                set
                {
                    this["EnableRecommendedProducts"] = value;
                }
            }

            [ConfigurationProperty("EnableProductReviews", DefaultValue = true, IsRequired = true)]
            public bool EnableProductReviews
            {
                get
                {
                    return (bool)this["EnableProductReviews"];
                }
                set
                {
                    this["EnableProductReviews"] = value;
                }
            }

            [ConfigurationProperty("EnableWishList", DefaultValue = true, IsRequired = true)]
            public bool EnableWishList
            {
                get
                {
                    return (bool)this["EnableWishList"];
                }
                set
                {
                    this["EnableWishList"] = value;
                }
            }

            [ConfigurationProperty("ImageThumbMaxWidth", DefaultValue = 100, IsRequired = true)]
            [IntegerValidator(ExcludeRange = false, MaxValue = 500, MinValue = 0)]
            public int ImageThumbMaxWidth
            {
                get
                {
                    return (int)this["ImageThumbMaxWidth"];
                }
                set
                {
                    this["ImageThumbMaxWidth"] = value;
                }
            }

            [ConfigurationProperty("ImageThumbMaxHeight", DefaultValue = 100, IsRequired = true)]
            [IntegerValidator(ExcludeRange = false, MaxValue = 500, MinValue = 0)]
            public int ImageThumbMaxHeight
            {
                get
                {
                    return (int)this["ImageThumbMaxHeight"];
                }
                set
                {
                    this["ImageThumbMaxHeight"] = value;
                }
            }

            [ConfigurationProperty("ImageDetailMaxWidth", DefaultValue = 225, IsRequired = true)]
            [IntegerValidator(ExcludeRange = false, MaxValue = 2500, MinValue = 0)]
            public int ImageDetailMaxWidth
            {
                get
                {
                    return (int)this["ImageDetailMaxWidth"];
                }
                set
                {
                    this["ImageDetailMaxWidth"] = value;
                }
            }

            [ConfigurationProperty("ImageDetailMaxHeight", DefaultValue = 225, IsRequired = true)]
            [IntegerValidator(ExcludeRange = false, MaxValue = 2500, MinValue = 0)]
            public int ImageDetailMaxHeight
            {
                get
                {
                    return (int)this["ImageDetailMaxHeight"];
                }
                set
                {
                    this["ImageDetailMaxHeight"] = value;
                }
            }
        }

        #endregion

        #region Shopping Cart Settings
        //Create ShoppingCartSettings Element
        [ConfigurationProperty("ShoppingCartSettings")]
        public ShoppingCartSettingsElement ShoppingCartSettings
        {
            get
            {
                return (ShoppingCartSettingsElement)this["ShoppingCartSettings"];
            }
            set
            {
                this["ShoppingCartSettings"] = value;
            }
        }

        public class ShoppingCartSettingsElement : ConfigurationElement
        {
            [ConfigurationProperty("SiteName", IsRequired = true)]
            [StringValidator(InvalidCharacters = "~!@#$%^&*()[]{}/;'\"|\\", MaxLength = 60)]
            public String SiteName
            {
                get
                {
                    return (String)this["SiteName"];
                }
                set
                {
                    this["SiteName"] = value;
                }
            }

            [ConfigurationProperty("RecentProducts", DefaultValue = -7, IsRequired = true)]
            [IntegerValidator(ExcludeRange = false, MaxValue = -1, MinValue = -365)]
            public int RecentProducts
            {
                get
                {
                    return (int)this["RecentProducts"];
                }
                set
                {
                    this["RecentProducts"] = value;
                }
            }


            [ConfigurationProperty("CartPersistDays", DefaultValue = 7, IsRequired = true)]
            [IntegerValidator(ExcludeRange = false, MaxValue = 1000, MinValue = 1)]
            public int CartPersistDays
            {
                get
                {
                    return (int)this["CartPersistDays"];
                }
                set
                {
                    this["CartPersistDays"] = value;
                }
            }

        }

        #endregion

        #region Authorize.NET Settings
        //Create Authorize.NET Element
        [ConfigurationProperty("AuthorizeNET")]
        public AuthorizeNETElement AuthorizeNET
        {
            get
            {
                return (AuthorizeNETElement)this["AuthorizeNET"];
            }
            set
            {
                this["AuthorizeNET"] = value;
            }
        }

        public class AuthorizeNETElement : ConfigurationElement
        {

            [ConfigurationProperty("APILogin", IsRequired = false)]
            //[StringValidator(InvalidCharacters = "~!@#$%^&*()[]{}/;'\"|\\", MaxLength = 10)]
            public String APILogin
            {
                get
                {
                    return (String)this["APILogin"];
                }
                set
                {
                    this["APILogin"] = value;
                }
            }

            [ConfigurationProperty("TransactionKey", IsRequired = false)]
            //[StringValidator(InvalidCharacters = "~!@#$%^&*()[]{}/;'\"|\\")]
            public String TransactionKey
            {
                get
                {
                    return (String)this["TransactionKey"];
                }
                set
                {
                    this["TransactionKey"] = value;
                }
            }
        }
        #endregion

    }

}
