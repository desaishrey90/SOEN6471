using System;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Data.Linq;
using Telerik.Web.UI;
using System.IO;
using System.Drawing.Imaging;
using System.Linq;
using LinqCommerce;

public partial class LINQControls_Admin_LinqProductDetailsAdmin : System.Web.UI.UserControl
{
    public double _thumbMaxWidth = 0;
    public double _thumbMaxHeight = 0;
    public double _detailMaxWidth = 0;
    public double _detailMaxHeight = 0;
    public string _productImagePath = ""; // default but should be set in config section

    protected void Page_Load(object sender, EventArgs e)
    {
        // Get the values for image resizing and path from the config section
        SectionConfigurationGroup s =
            (SectionConfigurationGroup)ConfigurationManager.GetSection("LinqCommerce/SiteSettings");
        _thumbMaxWidth = Convert.ToDouble(s.ProductSettings.ImageThumbMaxWidth);
        _thumbMaxHeight = Convert.ToDouble(s.ProductSettings.ImageThumbMaxHeight);
        _detailMaxWidth = Convert.ToDouble(s.ProductSettings.ImageDetailMaxWidth);
        _detailMaxHeight = Convert.ToDouble(s.ProductSettings.ImageDetailMaxHeight);
        _productImagePath = s.ProductSettings.ProductImagePath;

        lblThumbSize.Text = "(" + _thumbMaxWidth.ToString() + "x" + _thumbMaxHeight.ToString() + ")";
        lblDetailSize.Text = "(" + _detailMaxWidth.ToString() + "x" + _detailMaxHeight.ToString() + ")";

        if (!Page.IsPostBack)
        {
            LinqProductAccess lp = new LinqProductAccess();
            lc_Product p = lp.GetProduct();
            lblProductName.Text = lblProductName2.Text = p.Name;
            RenderProductImages(p.Image1FileName, p.Image2FileName);
        }
    }

    /// <summary>
    /// Upload the Product Thumbnail and Detail Images
    /// The images will be scaled based on the ProductSettings set in the web.config file.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void upload1Button_Click(object sender, EventArgs e)
    {
        try
        {
            UploadedFile thumbFile = null;
            UploadedFile detailFile = null;
            // Check that there is a file in the Thumbnail Upload Control
            if (thumbFileUpload.UploadedFiles.Count > 0)
            {
                //if the file uploaded is not a picture, then show an error message
                if (thumbFileUpload.InvalidFiles.Count > 0)
                {
                    statusLabel.Text = "File upload failed. Allowed extensions are .jpg, .png, .bmp and .gif";
                    statusLabel.CssClass = "error";
                }
                else
                {
                    // Get the thumbnail image
                    thumbFile = thumbFileUpload.UploadedFiles[0];

                    // Check to see if there is a different image for the detail view
                    if (detailFileUpload.UploadedFiles.Count > 0)
                    {
                        detailFile = detailFileUpload.UploadedFiles[0];
                    }
                    else
                    {
                        // If there is no detail image, set it to the thumb image
                        detailFile = thumbFile;
                    }

                    // Upload, save and resize the images
                    LinqAdminAccess la = new LinqAdminAccess();
                    string folderName = Server.MapPath(_productImagePath);
                    string thumbFileName = thumbFile.GetName();
                    string detailFileName = detailFile.GetName();

                    try
                    {
                        // Save the thumbnail image to disk
                        thumbFile.SaveAs(Path.Combine(folderName, thumbFileName), true);
                        // Resize the thumbnail image based on config settings
                        la.ResizeImage(thumbFile.ContentType, folderName + thumbFileName, _thumbMaxWidth, _thumbMaxHeight, false, true);

                        // Check for existing image w/ same name as detail image and save
                        detailFileName = CheckForFile(_productImagePath, detailFile);
                        // Resize the detail image based on config settings
                        la.ResizeImage(detailFile.ContentType, folderName + detailFileName, _detailMaxWidth, _detailMaxHeight, false, true);

                        // Save the names of the product images to the db
                        la.UpdateProductImage(thumbFileName, detailFileName, LinqProductAccess.ProductID);

                        // Update status message
                        statusLabel.Text = "File uploaded successfully!";
                        statusLabel.CssClass = "success";

                        RenderProductImages(thumbFileName, detailFileName);
                    }
                    catch (Exception ex)
                    {
                        statusLabel.Text = "File not uploaded.<br/>" + ex.Message + "<br/>" + ex.StackTrace;
                        statusLabel.CssClass = "error";
                    }
                }
            }
            else
            {
                statusLabel.Text = "No file(s) selected. The minimum requirement is to select an image for the Thumbnail view.<br/>";
                statusLabel.Text += "It can be larger and will be scaled down for the thumbnail and used for the detail view as well.";
                statusLabel.CssClass = "error";
            }
        }
        catch (System.UnauthorizedAccessException ex)
        {
            statusLabel.Text = "Your user account is unauthorized to upload pictures to the " + _productImagePath + " directory. Please contact a system admin.";
            statusLabel.CssClass = "error";
        }
    }

    /// <summary>
    /// Upload multiple alternate images for use in ProductImages table
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnInsert2_Click(object sender, EventArgs e)
    {
        try
        {
            // proceed with uploading only if the user selected a file
            if (alternateFileUpload.UploadedFiles.Count > 0)
            {
                foreach (UploadedFile validFile in alternateFileUpload.UploadedFiles)
                {
                    // Save image to the server
                    string folderName = Server.MapPath(_productImagePath);
                    validFile.SaveAs(Path.Combine(folderName, validFile.GetName()), true);

                    try
                    {
                        string fileName = validFile.GetName();
                        string location = Server.MapPath(_productImagePath) + fileName;

                        //Resize the image to 150 px for the product details page
                        LinqAdminAccess la = new LinqAdminAccess();

                        la.ResizeImage(validFile.ContentType, folderName + validFile.GetName(), _detailMaxWidth, _detailMaxHeight, false, true);

                        // Save image name and id to db
                        la.UpdateAlternateProductImages(validFile.GetName(), LinqProductAccess.ProductID);

                        // Update the status message
                        statusLabel.Text = "File(s) uploaded successfully!";
                        statusLabel.CssClass = "success";
                        // Update the image grid 
                        ProductAlternateImagesRadGrid.Rebind();
                    }
                    catch (Exception ex)
                    {
                        statusLabel.Text = "File not uploaded. If the problem persists, contact your system admin.";
                        statusLabel.Text += "<br/>" + ex.Message + "<br/>" + ex.StackTrace;
                        statusLabel.CssClass = "error";
                    }

                }
            }
            if (alternateFileUpload.InvalidFiles.Count > 0)
            {
                statusLabel.Text = "Not all files were uploaded. Allowed extensions are .jpg, .png, .bmp and .gif";
                statusLabel.CssClass = "error";
            }
        }
        catch (System.UnauthorizedAccessException ex)
        {
            statusLabel.Text = "Your user account is unauthorized to upload pictures to the " + _productImagePath + " directory. Please contact a system admin.";
            statusLabel.CssClass = "error";

        }

    }

    /// <summary>
    /// Check for existing file and if exsits update name, save and return new name
    /// ToDo - this needs to be improved so that it can be used for alternative images as well
    /// need to add a global "overwrite images" setting to config as well.
    /// </summary>
    /// <param name="targetFolder"></param>
    /// <param name="fileToSave"></param>
    /// <returns></returns>
    protected string CheckForFile(string targetFolder, UploadedFile fileToSave)
    {
        int counter = 0;

        string imagePath = Server.MapPath(targetFolder);
        string targetFileName = fileToSave.GetName();
        string targetFilePath = Path.Combine(imagePath,
            fileToSave.GetName());//.GetNameWithoutExtension() + counter.ToString() + fileToSave.GetExtension());

        while (System.IO.File.Exists(targetFilePath))
        {
            counter++;
            targetFilePath = Path.Combine(imagePath,
                fileToSave.GetNameWithoutExtension() + "-" + counter.ToString() + fileToSave.GetExtension());
            targetFileName = fileToSave.GetNameWithoutExtension() + "-" + counter.ToString() + fileToSave.GetExtension();
        }

        fileToSave.SaveAs(targetFilePath, true);
        return targetFileName;
    }

    /// <summary>
    /// Update the product images on page load and when uploaded
    /// </summary>
    /// <param name="imageThumb"></param>
    /// <param name="imageDetail"></param>
    protected void RenderProductImages(string imageThumb, string imageDetail)
    {
        if (!String.IsNullOrEmpty(imageThumb))
        {
            imgThumbnail.Visible = true;
            imgThumbnail.ImageUrl = _productImagePath + imageThumb;
            imgThumbnail.Width = new Unit(_thumbMaxWidth);
        }
        if (!String.IsNullOrEmpty(imageDetail))
        {
            imgDetail.Visible = true;
            imgDetail.ImageUrl = _productImagePath + imageDetail;
            imgDetail.Width = new Unit(_thumbMaxWidth);
        }
    }
}
