using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class UserControls_Login_MyProfile : System.Web.UI.UserControl
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
        BillFNTB.Text = Profile.FirstName;
        BillLNTB.Text = Profile.LastName;
        BillMNTB.Text = Profile.MiddleName;
        BillNNTB.Text = Profile.NickName;
        EMailTB.Text = Profile.EMail;
        BillPrefixCombo.SelectedValue = Profile.Prefix;
        BillPhoneTB.Text = Profile.Phone;
        BillFaxTB.Text = Profile.Fax;
        BillAdTB.Text = Profile.Address;
        BillAd2TB.Text = Profile.Address2;
        BillCityTB.Text = Profile.City;
        BillStateDropDown.SelectedValue = Profile.State;
        BillZipCodeTB.Text = Profile.Zip;
        BillStateDropDown.SelectedValue = Profile.State;
        BillCountryDropDown.SelectedValue = Profile.Country;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                //Put all Billing Info into Profile table
                Profile.FirstName = BillFNTB.Text;
                Profile.LastName = BillLNTB.Text;
                Profile.MiddleName = BillMNTB.Text;
                Profile.NickName = BillNNTB.Text;
                Profile.EMail = EMailTB.Text;
                Profile.Prefix = BillPrefixCombo.SelectedValue;
                Profile.Phone = BillPhoneTB.Text;
                Profile.Fax = BillFaxTB.Text;
                Profile.Address = BillAdTB.Text;
                Profile.Address2 = BillAd2TB.Text;
                Profile.City = BillCityTB.Text;
                Profile.State = BillStateDropDown.SelectedValue;
                Profile.Zip = BillZipCodeTB.Text;
                Profile.State = BillStateDropDown.SelectedValue;
                Profile.Country = BillCountryDropDown.SelectedValue;

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
}
