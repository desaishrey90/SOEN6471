<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddInventory.ascx.cs" Inherits="LINQControls_Admin_AddInventory" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<link href="../../App_Themes/BalloonShopDefault/BalloonShop.css" rel="stylesheet"
    type="text/css" />
<div id="CategoryFormDiv">
    <b><h3>Insert a Product Order</h3></b>
        <br />
        Product Name:<br />
        <br />
    <telerik:RadComboBox ID="ProductDropDown" Runat="server"
        DataSourceID="LinqDataSource1" DataTextField="Name" DataValueField="ProductID" 
        MarkFirstMatch="True" Skin="Vista" Width="300px" AutoPostBack="True" 
        onselectedindexchanged="ProductDropDown_SelectedIndexChanged">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    </telerik:RadComboBox>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LinqCommerceDataContext" OrderBy="Name" 
        Select="new (ProductID, Name)" TableName="lc_Products">
    </asp:LinqDataSource>
    <br />
    <br />
    Quantity:<br />
    <br />
    <telerik:RadNumericTextBox ID="QuantityTextBox" MinValue="1" Runat="server" MaxValue="1000" 
    Skin="Vista">
    </telerik:RadNumericTextBox>
    <br />
    <br />

    Size:<br />
    <br />
    <telerik:RadComboBox ID="SizeDropDown" Runat="server" 
        DataSourceID="LinqDataSource2" DataTextField="Size" DataValueField="SizeID" 
        Skin="Vista">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    </telerik:RadComboBox>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LinqCommerceDataContext" Select="new (SizeID, Size)" 
        TableName="lc_SizeTables">
    </asp:LinqDataSource>
    <br />
    <br />
    Color:<br />
    <br />
    <telerik:RadComboBox ID="ColorDropDown" Runat="server" 
        DataSourceID="LinqDataSource3" DataTextField="Color" DataValueField="ColorID" 
        Skin="Vista">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    </telerik:RadComboBox>
    <asp:LinqDataSource ID="LinqDataSource3" runat="server" 
        ContextTypeName="LinqCommerceDataContext" OrderBy="Color" 
        Select="new (ColorID, Color)" TableName="lc_ColorTables">
    </asp:LinqDataSource>
    <br />
    <br />
    Name of Seller:<br />
    <br />
    <telerik:RadComboBox ID="SellerDropDown" Runat="server" 
        DataSourceID="LinqDataSource4" DataTextField="SellerName" 
        DataValueField="SellerID" Skin="Vista">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    </telerik:RadComboBox>
    <asp:LinqDataSource ID="LinqDataSource4" runat="server" 
        ContextTypeName="LinqCommerceDataContext" OrderBy="SellerName" 
        Select="new (SellerID, SellerName)" TableName="lc_SellerTables">
    </asp:LinqDataSource>
    <br />
    <br />
    <asp:Button ID="btnInsert" runat="server" CommandName="Insert" 
        onclick="btnInsert_Click" Text="Insert" />
    <br />
    <br />
    <asp:Label ID="ErrorLabel" runat="server" ForeColor="Red" Text="Label"></asp:Label>
    <br />
    <br />
    </div>