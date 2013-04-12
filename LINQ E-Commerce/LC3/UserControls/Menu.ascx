<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Menu.ascx.cs" Inherits="UserControls_Menu" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadMenu ID="RadMenu1" runat="server" DataNavigateUrlField="Url" 
    DataTextField="Title" Skin="Vista" Width="100%" 
    onitemclick="RadMenu1_ItemClick">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    <Items>
        <telerik:RadMenuItem runat="server" Text="Administer Catalog">
            <Items>
                <telerik:RadMenuItem runat="server" 
                    NavigateUrl="~/LINQControls/Admin/CatalogAdmin.aspx" 
                    Text="Administer Departments, Categories and Products">
                    <Items>
                        <telerik:RadMenuItem runat="server" 
                            NavigateUrl="~/LINQControls/Admin/CatalogAdmin.aspx?CatalogAdmin=3" 
                            Text="View/Edit All Products">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" 
                            NavigateUrl="~/LINQControls/Admin/CatalogAdmin.aspx?CatalogAdmin=6" 
                            Text="Add a Product">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" 
                            NavigateUrl="~/LINQControls/Admin/CatalogAdmin.aspx?CatalogAdmin=8" 
                            Text="View/Edit Digital Products">
                        </telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
               <telerik:RadMenuItem runat="server" Text="Administer Reviews" 
                    NavigateUrl="~/LINQControls/Admin/CatalogAdmin.aspx?CatalogAdmin=4">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Text="Administer Orders" 
           >
            <Items>
            <telerik:RadMenuItem runat="server" Text="Orders Admin" 
                    NavigateUrl="~/LINQControls/Admin/OrdersAdmin.aspx">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Shopping Cart/Colors/Size Admin" 
                    NavigateUrl="~/LINQControls/Admin/OrdersAdmin.aspx?OrdersAdmin=1">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Coupon Admin" 
                    NavigateUrl="~/LINQControls/Admin/OrdersAdmin.aspx?OrdersAdmin=2">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Text="Inventory">
            <Items>
                <telerik:RadMenuItem runat="server" 
                    NavigateUrl="~/LINQControls/Admin/Inventory.aspx" 
                    Text="View Inventory">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" 
                    NavigateUrl="~/LINQControls/Admin/Inventory.aspx?Inventory=2" Text="Add Product Orders">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" 
                    NavigateUrl="~/LINQControls/Admin/Inventory.aspx?Inventory=3" Text="Add/View Your Product Suppliers">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" Text="Import Data">
            <Items>
                <telerik:RadMenuItem runat="server" Text="XML" 
                    NavigateUrl="~/LINQControls/Admin/DataImport.aspx?Import=XML">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="MS Excel" 
                    NavigateUrl="~/LINQControls/Admin/DataImport.aspx?Import=Excel">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" 
            NavigateUrl="~/LINQControls/Admin/OrdersAdmin.aspx?OrdersAdmin=3" Text="Tax Admin">
        </telerik:RadMenuItem>
        <telerik:RadMenuItem runat="server" NavigateUrl="~/Catalog.aspx" 
            Text="Back to Public Site">
        </telerik:RadMenuItem>
       

    </Items>
</telerik:RadMenu>



