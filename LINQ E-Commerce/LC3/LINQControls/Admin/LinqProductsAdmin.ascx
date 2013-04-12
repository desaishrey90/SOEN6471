<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinqProductsAdmin.ascx.cs" Inherits="UserControls_ProductsAdmin" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" 
    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
    DataSourceID="LinqDataSource1" GridLines="None" Skin="Vista" 
    AllowAutomaticDeletes="True" AllowAutomaticInserts="True" 
    AllowAutomaticUpdates="True" PageSize="5" Width="97%" 
    >
    <PagerStyle Mode="NextPrevAndNumeric" />
<MasterTableView datakeynames="ProductID" datasourceid="LinqDataSource1">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridTemplateColumn HeaderText="Product Image" 
            UniqueName="TemplateColumn" AllowFiltering="false">
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("{0}{1}", ProductImagePath, DataBinder.Eval(Container.DataItem, "Image1FileName")) %>' />
            </ItemTemplate>
        </telerik:GridTemplateColumn>
        <telerik:GridBoundColumn DataField="ProductID" DataType="System.Int32" 
            HeaderText="ProductID" ReadOnly="True" SortExpression="ProductID" 
            UniqueName="ProductID" Visible="False">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Name" HeaderText="Name" 
            SortExpression="Name" UniqueName="Name">
        </telerik:GridBoundColumn>
        <telerik:GridHTMLEditorColumn UniqueName="Description" DataField="Description" HeaderText="Description" />
        <telerik:GridNumericColumn DataField="Price" DataFormatString="{0:C}" 
            HeaderText="Price" NumericType="Currency" UniqueName="Price">
        </telerik:GridNumericColumn>
       <%-- <telerik:GridBoundColumn DataField="Image1FileName" HeaderText="Image1FileName" 
            SortExpression="Image1FileName" UniqueName="Image1FileName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Image2FileName" HeaderText="Image2FileName" 
            SortExpression="Image2FileName" UniqueName="Image2FileName">
        </telerik:GridBoundColumn>--%>
        <telerik:GridCheckBoxColumn DataField="OnCatalogPromotion" 
            DataType="System.Boolean" HeaderText="On<br>CatalogPromotion" 
            SortExpression="OnCatalogPromotion" UniqueName="OnCatalogPromotion">
        </telerik:GridCheckBoxColumn>
        <telerik:GridCheckBoxColumn DataField="OnDepartmentPromotion" 
            DataType="System.Boolean" HeaderText="On<br>DepartmentPromotion" 
            SortExpression="OnDepartmentPromotion" UniqueName="OnDepartmentPromotion">
        </telerik:GridCheckBoxColumn>
         <telerik:GridCheckBoxColumn DataField="Sizeable" 
            DataType="System.Boolean" HeaderText="Sizeable" 
            SortExpression="Sizeable" UniqueName="Sizeable">
        </telerik:GridCheckBoxColumn>
         <telerik:GridCheckBoxColumn DataField="Colorable" 
            DataType="System.Boolean" HeaderText="Colorable" 
            SortExpression="Colorable" UniqueName="Colorable">
        </telerik:GridCheckBoxColumn>
       
<%--        <telerik:GridDateTimeColumn UniqueName="DateAdded" HeaderText="DateAdded"
                        DataField="DateAdded" DataType="System.DateTime" PickerType="None" ReadOnly="True">
                        <ItemStyle Width="120px" />
                    </telerik:GridDateTimeColumn>
--%>        <%--<telerik:GridTemplateColumn UniqueName="SelectColumn" AllowFiltering="false">
        <ItemTemplate>
        <asp:HyperLink runat="server" Text="Select" NavigateUrl='<%# "~/LinqControls/Admin/CatalogAdmin.aspx?DepartmentID=" + Request.QueryString["DepartmentID"] + "&amp;CategoryID=" + Request.QueryString["CategoryID"] + "&amp;ProductID=" + Eval("ProductID") %>' ID="HyperLink1">
        </asp:HyperLink>
      </ItemTemplate>
        </telerik:GridTemplateColumn>--%>
        
        <telerik:GridTemplateColumn UniqueName="Hyperlink2" AllowFiltering="false">
        <ItemTemplate>
      <asp:HyperLink runat="server" Text="Add/Remove Pictures/Categories" NavigateUrl='<%# "~/LinqControls/Admin/CatalogAdmin.aspx?CatalogAdmin=2&ProductID=" + Eval("ProductID") %>' ID="DetailsLink">
        </asp:HyperLink>
      </ItemTemplate>
        </telerik:GridTemplateColumn>
    </Columns>
</MasterTableView>

    <clientsettings>
        <selecting allowrowselect="True" />
    </clientsettings>

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
</telerik:RadGrid>
<asp:LinqDataSource ID="LinqDataSource1" runat="server" 
    ContextTypeName="LinqCommerceDataContext" EnableDelete="True" 
    EnableInsert="True" EnableUpdate="True" OrderBy="Name" 
    TableName="lc_Products" 
    onselecting="LinqDataSource1_Selecting">
</asp:LinqDataSource>
