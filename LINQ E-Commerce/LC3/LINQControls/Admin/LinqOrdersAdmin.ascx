<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinqOrdersAdmin.ascx.cs" Inherits="LINQControls_LinqOrdersAdmin" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
    <b><h3>Order Information</h3></b>
<telerik:RadGrid ID="grid" runat="server" Skin="Vista" 
    AutoGenerateColumns="False" GridLines="None" AllowFilteringByColumn="True" 
    AllowPaging="True" AllowSorting="True" DataSourceID="LinqDataSource1" 
    AllowAutomaticDeletes="True" AllowAutomaticInserts="True" 
    AllowAutomaticUpdates="True" PageSize="5" ShowGroupPanel="True">
    <PagerStyle Mode="NextPrevAndNumeric" />
<MasterTableView datasourceid="LinqDataSource1" commanditemdisplay="Top" 
        datakeynames="OrderID" editmode="PopUp">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
      <telerik:GridClientSelectColumn UniqueName="CheckboxSelectColumn" />
        <telerik:GridBoundColumn DataField="OrderID" ReadOnly="True" HeaderText="Order ID" 
            UniqueName="column">
        </telerik:GridBoundColumn>
        <telerik:GridDateTimeColumn DataField="DateCreated" DataFormatString="{0:f}" 
            HeaderText="Date Created" ReadOnly="False" UniqueName="DateCreated" 
            PickerType="DateTimePicker">
        </telerik:GridDateTimeColumn>
        <telerik:GridDateTimeColumn DataField="DateShipped" DataFormatString="{0:f}" 
            HeaderText="Date Shipped" ReadOnly="False" UniqueName="DateShipped" 
            PickerType="DateTimePicker">
        </telerik:GridDateTimeColumn>
        <telerik:GridCheckBoxColumn DataField="Verified" HeaderText="Verified" 
            ReadOnly="False" UniqueName="column3">
        </telerik:GridCheckBoxColumn>
        <telerik:GridCheckBoxColumn DataField="Completed" HeaderText="Completed" 
            ReadOnly="False" UniqueName="column4">
        </telerik:GridCheckBoxColumn>
        <telerik:GridCheckBoxColumn DataField="Canceled" HeaderText="Canceled" 
            ReadOnly="False" UniqueName="column5">
        </telerik:GridCheckBoxColumn>
        <telerik:GridHyperLinkColumn DataNavigateUrlFields="OrderID" 
            DataNavigateUrlFormatString="~/LinqControls/Admin/OrdersAdmin.aspx?OrderID={0}" 
            DataTextField="OrderID" Text="Order Details" UniqueName="column1" 
            AllowFiltering="False" DataTextFormatString="Order Details">
        </telerik:GridHyperLinkColumn>
    </Columns>
</MasterTableView>

        <ClientSettings EnableRowHoverStyle="True" allowdragtogroup="True">
        <Selecting AllowRowSelect="True" />
    </ClientSettings>

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
</telerik:RadGrid>
<br />
    <b><h3>Order Details Information</h3></b>
<telerik:RadGrid ID="OrderDetailsGrid" runat="server" AllowFilteringByColumn="True" 
    AllowPaging="True" AllowSorting="True" 
    GridLines="None" Skin="Vista" AutoGenerateColumns="False" 
    DataSourceID="ObjectDataSource3">
<MasterTableView datakeynames="OrderID,ProductID" DataSourceID="ObjectDataSource3" >
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
    <telerik:GridClientSelectColumn UniqueName="CheckboxSelectColumn" />
        <telerik:GridBoundColumn DataField="OrderID" DataType="System.Int32" 
            HeaderText="OrderID" ReadOnly="True" SortExpression="OrderID" 
            UniqueName="OrderID">
        </telerik:GridBoundColumn>
        <telerik:GridDropDownColumn DataField="ProductID" 
            DataSourceID="LinqDataSource2" HeaderText="Name" ListTextField="Name" 
            ListValueField="ProductID" UniqueName="column">
        </telerik:GridDropDownColumn>
        <telerik:GridBoundColumn DataField="Quantity" DataType="System.Int32" 
            HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="UnitCost" DataType="System.Decimal" 
            HeaderText="UnitCost" SortExpression="UnitCost" UniqueName="UnitCost" 
            DataFormatString="{0:c}">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Size" HeaderText="Size" 
            SortExpression="Size" UniqueName="SizeField">
        </telerik:GridBoundColumn>
               <telerik:GridBoundColumn DataField="Color" HeaderText="Color" 
            SortExpression="Color" UniqueName="Color">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="CouponCode" HeaderText="Coupon Code" 
            SortExpression="Coupon Code" UniqueName="CouponCodeField">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Subtotal" DataType="System.Decimal" 
            HeaderText="Subtotal" ReadOnly="True" SortExpression="Subtotal" 
            UniqueName="Subtotal2" DataFormatString="{0:c}">
        </telerik:GridBoundColumn>
    </Columns>
    <PagerStyle Mode="NextPrevAndNumeric" />
</MasterTableView>

     <ClientSettings EnableRowHoverStyle="True">
        <Selecting AllowRowSelect="True" />
    </ClientSettings>

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
</telerik:RadGrid>
<asp:LinqDataSource ID="LinqDataSource2" runat="server" 
    ContextTypeName="LinqCommerceDataContext" Select="new (ProductID, Name)" 
    TableName="lc_Products">
</asp:LinqDataSource>
<asp:ObjectDataSource ID="ObjectDataSource3" runat="server" 
    SelectMethod="GetOrderDetails" TypeName="LinqCommerce.LinqOrderAccess">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="OrderID" 
            QueryStringField="OrderID" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
<p>
    <br />
</p>
    <b><h3>Billing Information</h3></b>
<telerik:RadGrid ID="BillingGrid" runat="server" AllowPaging="True" 
    AllowSorting="True" GridLines="None" Skin="Vista" 
    DataSourceID="ObjectDataSource2">
<MasterTableView AutoGenerateColumns="False" DataKeyNames="OrderID" 
        DataSourceID="ObjectDataSource2">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="OrderID" DataType="System.Int32" 
            HeaderText="OrderID" ReadOnly="True" SortExpression="OrderID" 
            UniqueName="OrderID">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="FirstName" HeaderText="FirstName" 
            SortExpression="FirstName" UniqueName="FirstName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LastName" HeaderText="LastName" 
            SortExpression="LastName" UniqueName="LastName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="MiddleName" HeaderText="MiddleName" 
            SortExpression="MiddleName" UniqueName="MiddleName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="NickName" HeaderText="NickName" 
            SortExpression="NickName" UniqueName="NickName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Prefix" HeaderText="Prefix" 
            SortExpression="Prefix" UniqueName="Prefix">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Address" HeaderText="Address" 
            SortExpression="Address" UniqueName="Address">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Address2" HeaderText="Address2" 
            SortExpression="Address2" UniqueName="Address2">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="City" HeaderText="City" 
            SortExpression="City" UniqueName="City">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="State" HeaderText="State" 
            SortExpression="State" UniqueName="State">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Zip" HeaderText="Zip" SortExpression="Zip" 
            UniqueName="Zip">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" 
            SortExpression="Phone" UniqueName="Phone">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Fax" HeaderText="Fax" SortExpression="Fax" 
            UniqueName="Fax">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Country" HeaderText="Country" 
            SortExpression="Country" UniqueName="Country">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
</telerik:RadGrid>
<asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
    SelectMethod="GetAllBillingDetails" TypeName="LinqCommerce.LinqOrderAccess">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="OrderID" 
            QueryStringField="OrderID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<br />
    <b><h3>Shipping Information</h3></b>
<telerik:RadGrid ID="ShippingGrid" runat="server" AllowPaging="True" 
    AllowSorting="True" GridLines="None" Skin="Vista" 
    DataSourceID="ObjectDataSource1">
<MasterTableView AutoGenerateColumns="False" DataKeyNames="OrderID" 
        DataSourceID="ObjectDataSource1">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="OrderID" DataType="System.Int32" 
            HeaderText="OrderID" ReadOnly="True" SortExpression="OrderID" 
            UniqueName="OrderID">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="FirstName" HeaderText="FirstName" 
            SortExpression="FirstName" UniqueName="FirstName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LastName" HeaderText="LastName" 
            SortExpression="LastName" UniqueName="LastName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="MiddleName" HeaderText="MiddleName" 
            SortExpression="MiddleName" UniqueName="MiddleName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="NickName" HeaderText="NickName" 
            SortExpression="NickName" UniqueName="NickName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Prefix" HeaderText="Prefix" 
            SortExpression="Prefix" UniqueName="Prefix">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Address" HeaderText="Address" 
            SortExpression="Address" UniqueName="Address">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Address2" HeaderText="Address2" 
            SortExpression="Address2" UniqueName="Address2">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="City" HeaderText="City" 
            SortExpression="City" UniqueName="City">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="State" HeaderText="State" 
            SortExpression="State" UniqueName="State">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Zip" HeaderText="Zip" SortExpression="Zip" 
            UniqueName="Zip">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" 
            SortExpression="Phone" UniqueName="Phone">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Fax" HeaderText="Fax" SortExpression="Fax" 
            UniqueName="Fax">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Country" HeaderText="Country" 
            SortExpression="Country" UniqueName="Country">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
</telerik:RadGrid>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
    SelectMethod="GetAllShippingDetails" TypeName="LinqCommerce.LinqOrderAccess">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="OrderID" 
            QueryStringField="OrderID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<p>
</p>
<asp:LinqDataSource ID="LinqDataSource1" runat="server" 
    ContextTypeName="LinqCommerceDataContext" EnableDelete="True" 
    EnableInsert="True" EnableUpdate="True" TableName="lc_Orders">
</asp:LinqDataSource>
<br />
<asp:Label ID="ErrorLabel" runat="server" ForeColor="Red"></asp:Label>




