<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LINQDepartCatList.ascx.cs" Inherits="LINQControls_ControlTemplates_LINQDepartCatList" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/UserControls/Login/UserInfo.ascx" TagName="UserInfo" TagPrefix="uc3" %>
<telerik:RadGrid ID="list" runat="server" AutoGenerateColumns="False" 
    GridLines="None" Skin="Vista">
<MasterTableView>
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridTemplateColumn HeaderText="<center>Choose a Department</center>" 
            UniqueName="TemplateColumn">
            <ItemTemplate>
            <center>
            &nbsp;&raquo;
    <asp:HyperLink 
      ID="HyperLink1" 
      Runat="server" 
      NavigateUrl='<%# "~/Catalog.aspx?DepartmentID=" + Eval("DepartmentID")%>'
      Text='<%# Eval("Name") %>'
      ToolTip='<%# Eval("Description") %>'
      CssClass='<%# Eval("DepartmentID").ToString() == Request.QueryString["DepartmentID"] ? "DepartmentSelected" : "DepartmentUnselected" %>'
     >
    </asp:HyperLink>
    &nbsp;&laquo;
    </center>
            </ItemTemplate>
        </telerik:GridTemplateColumn>
    </Columns>
</MasterTableView>

    <ClientSettings EnableRowHoverStyle="True">
        <Selecting AllowRowSelect="True" />
    </ClientSettings>

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
</telerik:RadGrid>
<telerik:RadGrid ID="list2" runat="server" AutoGenerateColumns="False" 
    GridLines="None" Skin="Vista">
<MasterTableView>
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridTemplateColumn HeaderText="&lt;center&gt;Select a Category&lt;/center&gt;" 
            UniqueName="TemplateColumn">
            <ItemTemplate>
            <center>
            &nbsp;&raquo;
    <asp:HyperLink 
      ID="HyperLink1" 
      Runat="server" 
      NavigateUrl='<%# "~/Catalog.aspx?DepartmentID=" + Request.QueryString["DepartmentID"] + "&CategoryID=" + Eval("CategoryID")  %>'
      Text='<%# Eval("Name") %>' 
      ToolTip='<%# Eval("Description") %>' 
      CssClass='<%# Eval("CategoryID").ToString() == Request.QueryString["CategoryID"] ? "CategorySelected" : "CategoryUnselected" %>'>>
    </asp:HyperLink>
    &nbsp;&laquo;
    </center>
    </ItemTemplate>
        </telerik:GridTemplateColumn>
    </Columns>
</MasterTableView>

    <ClientSettings EnableRowHoverStyle="True">
        <Selecting AllowRowSelect="True" />
    </ClientSettings>

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
</telerik:RadGrid>
<asp:Label ID="brLabel" runat="server" Text="" />
<br />
<center>
<br />
    <asp:HyperLink ID="NewProductsLink" runat="server" NavigateUrl="~/Catalog.aspx?NewestProducts=true"
        ToolTip="View Newest Products">View Newest Products</asp:HyperLink>
<br />
<br />
<asp:HyperLink ID="CartLink" runat="server" Text="View Cart" NavigateUrl="~/ShoppingCart.aspx"></asp:HyperLink>
<br />
<br />
    <uc3:UserInfo ID="UserInfo1" runat="server" />
    </center>
