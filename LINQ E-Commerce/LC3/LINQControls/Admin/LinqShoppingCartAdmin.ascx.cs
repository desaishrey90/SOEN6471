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

public partial class UserControls_LinqShoppingCartAdmin : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }



    // deletes old shopping carts
    protected void deleteButton_Click(object sender, EventArgs e)
    {
        LinqCommerceDataContext db = new LinqCommerceDataContext();
        var query = from a in db.lc_ShoppingCarts
                    select a;
        db.lc_ShoppingCarts.DeleteAllOnSubmit(query);
        db.SubmitChanges();
        countLabel.Text = "All carts removed.";
    }
}
