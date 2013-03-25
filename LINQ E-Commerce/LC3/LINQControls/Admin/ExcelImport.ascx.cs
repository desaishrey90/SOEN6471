using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using Telerik.Web.UI;

public partial class LINQControls_Admin_ExcelImport : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnInsert_Click(object sender, EventArgs e)
    {

        try
        {
            LinqCommerceDataContext db = new LinqCommerceDataContext();
            DataSet objDataSet = new DataSet();
            FillDataSetUsingLinqToSql(objDataSet);
            DataTable dataTable = objDataSet.Tables[0];
            var a = from b in dataTable.AsEnumerable()
                    select new lc_Product
                    {
                        //type string
                        Name = b.Field<String>(NameTextBox.Text),
                        //type decimal
                        Price = Convert.ToDecimal(b.Field<Double>(PriceTextBox.Text).ToString()),
                        //type string
                        Description = b.Field<String>(DescriptionTextBox.Text),
                        DateAdded = System.DateTime.Now
                    };
            db.lc_Products.InsertAllOnSubmit(a);
            db.SubmitChanges();
            ErrorLabel.Text = "Data inserted successfully";
        }
        catch (Exception ex)
        {
            ErrorLabel.Text = ex.ToString();
        }


    }
    private void FillDataSetUsingLinqToSql(DataSet objDataSet)
    {
        try
        {
            if (RadUpload1.UploadedFiles.Count > 0)
            {
                foreach (UploadedFile validFile in RadUpload1.UploadedFiles)
                {
                    //string fileString = Request.ApplicationPath + validFile.GetName();
                    //string document = Server.MapPath(fileString);
                    string location = @"~\App_Data\";
                    string fileString = validFile.GetName();
                    string document = Server.MapPath(location + fileString);
                    validFile.SaveAs(document);
                    // Connect to the Excel Spreadsheet 
                    string xConnStr = "Provider=Microsoft.Jet.OLEDB.4.0;" +
                    "Data Source=" + document + ";" +
                    "Extended Properties=Excel 8.0;";
                    // create your excel connection object using the connection string 
                    OleDbConnection conn = new OleDbConnection(xConnStr);
                    conn.Open();
                    // use a SQL Select command to retrieve the data from the Excel Spreadsheet 
                    // the "table name" is the name of the worksheet within the spreadsheet 
                    // in this case, the worksheet name is "Products" and is coded as: [Products$] 
                    OleDbCommand objCommand = new OleDbCommand("SELECT * FROM [Products$]", conn);
                    // Create a new Adapter 
                    OleDbDataAdapter objDataAdapter = new OleDbDataAdapter();
                    // retrieve the Select command for the Spreadsheet 
                    objDataAdapter.SelectCommand = objCommand;
                    //DataSet objDataSet = new DataSet();
                    objDataAdapter.Fill(objDataSet);
                }
            }
        }
        catch (Exception ex)
        {
            ErrorLabel.Text = ex.ToString();
        }
    }
}
