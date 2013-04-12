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
using Telerik.Web.UI;
using LinqCommerce;

public partial class LINQControls_ControlTemplates_RecommendationsForm : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Bind the user name textbox to the profile user name, if one is provided. If not, use a dummy name
        if (Profile.UserName != null)
        {
            UserNameTextBox.Text = Profile.UserName;
        }
        else
        {
            //UserNameTextBox.Text = "NoUserName";
            InsertButton.Enabled = false;
            statusLabel.Text = "You must login before submitting a review.";
        }
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        try
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            lc_Recommendation recommendation = new lc_Recommendation
            {
                DateInserted = DateTime.Now,
                Description = DescriptionRadEditor.Content,
                Title = TitleTextBox.Text,
                ProductID = LinqProductAccess.ProductID,
                Points = Rating1.Value,
                UserName = UserNameTextBox.Text
            };


            db.lc_Recommendations.InsertOnSubmit(recommendation);
            db.SubmitChanges();
            statusLabel.Text = "Review submitted successfully! Once it is approved by an admin, it will be published.";
        }
        catch
        {
            statusLabel.Text = "Review insert failed. Contact admin for assistance.";
        }

    }  
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Product.aspx?ProductID=" + LinqProductAccess.ProductID);
    }
    

}
