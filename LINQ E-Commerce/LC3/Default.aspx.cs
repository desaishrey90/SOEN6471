using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LinqCommerce;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LinqProductAccess p = new LinqProductAccess();
        Response.Write(p.GetProductPointsMethod(1));
    }
}
