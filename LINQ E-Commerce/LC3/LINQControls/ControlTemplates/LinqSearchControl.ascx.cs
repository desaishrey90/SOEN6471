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

public partial class Sandbox_LinqSearchControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RadComboBox1_ItemsRequested(object o, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        //Get the text typed in the RadComboBox
        string text = e.Context["CustomText"].ToString();
        //Get all of the product names
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var data = from p in db.lc_Products
                   where p.Name.StartsWith(text)
                   orderby p.Name ascending
                   select new { p.Name };

        //load the query into a data table
        DataTable table = new DataTable();
        table.Columns.Add("Name", typeof(string));

        //For each row in the query, make a row in the data table
        foreach (var ProductName in data)
        {
            table.LoadDataRow(new object[] { ProductName.Name }, true);
        }

        //load the table into a dataset
        DataSet dataset = new DataSet();
        dataset.Tables.Add(table);
        try
        {

            int itemsPerRequest = 10;
            int itemOffset = e.NumberOfItems;
            int endOffset = itemOffset + itemsPerRequest;
            if (endOffset > table.Rows.Count)
            {
                endOffset = table.Rows.Count;
            }
            if (endOffset == table.Rows.Count)
            {
                e.EndOfItems = true;
            }
            else
            {
                e.EndOfItems = false;
            }
            //For every item, add a row to the RadComboBox
            for (int i = itemOffset; i < endOffset; i++)
            {
                RadComboBox1.Items.Add(new RadComboBoxItem(table.Rows[i]["Name"].ToString()));
            }

            if (table.Rows.Count > 0)
            {
                e.Message = String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", endOffset.ToString(), table.Rows.Count.ToString());
            }
            else
            {
                e.Message = "No matches";
            }
        }
        catch
        {
            e.Message = "No matches";
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Response.Redirect("Catalog.aspx?Search=" + RadComboBox1.Text);
    }
}
