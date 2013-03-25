<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderHistory.ascx.cs" Inherits="UserControls_Login_lc_OrderHistory" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" 
    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
    DataSourceID="LinqDataSource1" GridLines="None" Skin="Web20" 
    ShowGroupPanel="True" ShowFooter="True">
    <PagerStyle Mode="NextPrevAndNumeric" />
<MasterTableView datakeynames="lc_OrderID,ProductID" datasourceid="LinqDataSource1">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="lc_OrderID" DataType="System.Int32" 
            HeaderText="lc_OrderID" ReadOnly="True" SortExpression="lc_OrderID" 
            UniqueName="lc_OrderID">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ProductID" DataType="System.Int32" 
            HeaderText="ProductID" ReadOnly="True" SortExpression="ProductID" 
            UniqueName="ProductID" Visible="False">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ProductName" HeaderText="ProductName" 
            SortExpression="ProductName" UniqueName="ProductName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Quantity" AllowFiltering="false" DataType="System.Int32" 
            HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="UnitCost" DataFormatString="{0:c}" 
            DataType="System.Decimal" HeaderText="UnitCost" SortExpression="UnitCost" 
            UniqueName="UnitCost">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Subtotal" DataFormatString="{0:c}" 
            DataType="System.Decimal" HeaderText="Subtotal" SortExpression="Subtotal" 
            UniqueName="Subtotal" Aggregate="Sum">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn AllowFiltering="false" DataField="Size" HeaderText="Size" 
            SortExpression="Size" UniqueName="Size">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Color" AllowFiltering="false" HeaderText="Color" 
            SortExpression="Color" UniqueName="Color">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="CouponCode" HeaderText="CouponCode" 
            SortExpression="CouponCode" UniqueName="CouponCode" Visible="False">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="UserName" HeaderText="UserName" 
            SortExpression="UserName" UniqueName="UserName" Visible="False">
        </telerik:GridBoundColumn>
        <telerik:GridDateTimeColumn DataField="DateCreated" DataFormatString="{0:d}" 
            DataType="System.DateTime" HeaderText="DateCreated" SortExpression="DateCreated" 
            UniqueName="DateCreated">
        </telerik:GridDateTimeColumn>
         <telerik:GridDateTimeColumn DataField="DateShipped" DataFormatString="{0:d}" 
            DataType="System.DateTime" HeaderText="DateShipped" SortExpression="DateShipped" 
            UniqueName="DateShipped">
        </telerik:GridDateTimeColumn>
       
    </Columns>
    
</MasterTableView>

    <ClientSettings AllowDragToGroup="True">
        <Selecting AllowRowSelect="True" />
    </ClientSettings>

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
</telerik:RadGrid>
<asp:LinqDataSource ID="LinqDataSource1" runat="server" 
    ContextTypeName="LinqCommerceDataContext" TableName="lc_OrderDetails" 
    Where="UserName == @UserName" onselecting="LinqDataSource1_Selecting">
    <WhereParameters>
        <asp:ProfileParameter Name="UserName" PropertyName="UserName" Type="String" />
    </WhereParameters>
</asp:LinqDataSource>
 <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadGrid1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px" Width="75px" Transparency="25">
            <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>' style="Order:0;" />
        </telerik:RadAjaxLoadingPanel>