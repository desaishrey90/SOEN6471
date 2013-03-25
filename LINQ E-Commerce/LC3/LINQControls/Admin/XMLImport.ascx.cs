using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Telerik.Web.UI;

public partial class LINQControls_Admin_XMLImport : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnInsert_Click(object sender, EventArgs e)
    {
        try
        {
            if (RadUpload1.UploadedFiles.Count > 0)
            {
                foreach (UploadedFile validFile in RadUpload1.UploadedFiles)
                {
                    string location = @"~\App_Data\";
                    string fileString = validFile.GetName();
                    string document = Server.MapPath(location + fileString);
                    validFile.SaveAs(document);
                    XDocument xmlFile = XDocument.Load(document);
                    LinqCommerceDataContext db = new LinqCommerceDataContext();
                    var products = from p in xmlFile.Descendants(DescendentsTextBox.Text)
                                   select new lc_Product
                                   {
                                       Name = (string)p.Element(NameTextBox.Text),
                                       Price = (decimal)p.Element(PriceTextBox.Text),
                                       Description = (string)p.Element(DescriptionTextBox.Text),
                                       DateAdded = System.DateTime.Now
                                   };
                    db.lc_Products.InsertAllOnSubmit(products);
                    db.SubmitChanges();
                    ErrorLabel.Text = "Info inserted successfully!";
                }
            }
            else
            {
                ErrorLabel.Text = "Please upload an XML file";
            }
            if (RadUpload1.InvalidFiles.Count > 0)
            {
                ErrorLabel.Text = "Info insertion failed. You must upload a valid XML file.";
            }
        }
        catch (Exception ex)
        {
            ErrorLabel.Text = ex.ToString();
        }
    }
}
