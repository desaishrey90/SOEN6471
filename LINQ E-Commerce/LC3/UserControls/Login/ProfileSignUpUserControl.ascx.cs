using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Sandbox_ProfileSignUpUserControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadProfile();
        }

    }

    private void LoadProfile()
    {
        //Put all Billing Info into the form for viewing
        BillFNTB.Text = Profile.Billing.FirstName;
        BillLNTB.Text = Profile.Billing.LastName;
        BillMNTB.Text = Profile.Billing.MiddleName;
        BillNNTB.Text = Profile.Billing.NickName;
        BillPrefixCombo.SelectedValue = Profile.Billing.Prefix;
        BillPhoneTB.Text = Profile.Billing.Phone;
        BillFaxTB.Text = Profile.Billing.Fax;
        BillAdTB.Text = Profile.Billing.Address;
        BillAd2TB.Text = Profile.Billing.Address2;
        BillCityTB.Text = Profile.Billing.City;
        BillStateDropDown.SelectedValue = Profile.Billing.State;
        BillZipCodeTB.Text = Profile.Billing.Zip;
        BillStateDropDown.SelectedValue = Profile.Billing.State;
        BillCountryDropDown.SelectedValue = Profile.Billing.Country;

        //Put all Shipping Info into the form for shipping
        ShipFNTB.Text = Profile.Shipping.FirstName;
        ShipLNTB.Text = Profile.Shipping.LastName;
        ShipMNTB.Text = Profile.Shipping.MiddleName;
        ShipNNTB.Text = Profile.Shipping.NickName;
        ShipPrefixCombo.SelectedValue = Profile.Shipping.Prefix;
        ShipPhoneTB.Text = Profile.Shipping.Phone;
        ShipFaxTB.Text = Profile.Shipping.Fax;
        ShipADTB.Text = Profile.Shipping.Address;
        ShipAD2TB.Text = Profile.Shipping.Address2;
        ShipCityTB.Text = Profile.Shipping.City;
        ShipStateDropDown.SelectedValue = Profile.Shipping.State;
        ShipZipCodeTB.Text = Profile.Shipping.Zip;
        ShipStateDropDown.SelectedValue = Profile.Shipping.State;
        ShipCountryDropDown.SelectedValue = Profile.Shipping.Country;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                //Put all Billing Info into Profile table
                Profile.Billing.FirstName = BillFNTB.Text;
                Profile.Billing.LastName = BillLNTB.Text;
                Profile.Billing.MiddleName = BillMNTB.Text;
                Profile.Billing.NickName = BillNNTB.Text;
                Profile.Billing.Prefix = BillPrefixCombo.SelectedValue;
                Profile.Billing.Phone = BillPhoneTB.Text;
                Profile.Billing.Fax = BillFaxTB.Text;
                Profile.Billing.Address = BillAdTB.Text;
                Profile.Billing.Address2 = BillAd2TB.Text;
                Profile.Billing.City = BillCityTB.Text;
                Profile.Billing.State = BillStateDropDown.SelectedValue;
                Profile.Billing.Zip = BillZipCodeTB.Text;
                Profile.Billing.State = BillStateDropDown.SelectedValue;
                Profile.Billing.Country = BillCountryDropDown.SelectedValue;

                //Put all Shipping Info into Profile table
                Profile.Shipping.FirstName = ShipFNTB.Text;
                Profile.Shipping.LastName = ShipLNTB.Text;
                Profile.Shipping.MiddleName = ShipMNTB.Text;
                Profile.Shipping.NickName = ShipNNTB.Text;
                Profile.Shipping.Prefix = ShipPrefixCombo.SelectedValue;
                Profile.Shipping.Phone = ShipPhoneTB.Text;
                Profile.Shipping.Fax = ShipFaxTB.Text;
                Profile.Shipping.Address = ShipADTB.Text;
                Profile.Shipping.Address2 = ShipAD2TB.Text;
                Profile.Shipping.City = ShipCityTB.Text;
                Profile.Shipping.State = ShipStateDropDown.SelectedValue;
                Profile.Shipping.Zip = ShipZipCodeTB.Text;
                Profile.Shipping.State = ShipStateDropDown.SelectedValue;
                Profile.Shipping.Country = ShipCountryDropDown.SelectedValue;

                //Give the user a friendly message
                ErrorLabel.Text = "<b>Profile info submitted successfully.</b>";
                LoadProfile();
            }
        }
            //If there is some unknown error, tell the person to contact us directly.
        catch
        {
            ErrorLabel.Text = "An error has occurred with your request. Please contact an admin.";
        }
    }

    //If the shipping and billing info are the same, then put the billing info in teh shipping info
    protected void BillShipCheck_CheckedChanged(object sender, EventArgs e)
    {
        ShipFNTB.Text = BillFNTB.Text;
        ShipLNTB.Text = BillLNTB.Text;
        ShipNNTB.Text = BillNNTB.Text;
        ShipADTB.Text = BillAdTB.Text;
        ShipAD2TB.Text = BillAd2TB.Text;
        ShipCityTB.Text = BillCityTB.Text;
        ShipStateDropDown.SelectedValue = BillStateDropDown.SelectedValue;
        ShipCountryDropDown.SelectedValue = BillCountryDropDown.SelectedValue;
        ShipFaxTB.Text = BillFaxTB.Text;
        ShipMNTB.Text = BillMNTB.Text;
        ShipPhoneTB.Text = BillPhoneTB.Text;
        ShipPrefixCombo.SelectedValue = BillPrefixCombo.SelectedValue;
        ShipZipCodeTB.Text = BillZipCodeTB.Text;
    }
}
