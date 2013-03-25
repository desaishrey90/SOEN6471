<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WishList.ascx.cs" Inherits="LINQControls_ControlTemplates_WishList" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<h1><asp:Label ID="WishListLabel" runat="server"></asp:Label></h1>
<h3><asp:Label ID="ErrorLabel" runat="server" Visible="false" ForeColor="Red"></asp:Label></h3>
<telerik:RadGrid ID="list" 
            AllowPaging="True" runat="server" AllowSorting="True" Skin="Vista" 
    GridLines="None" PageSize="5" AutoGenerateColumns="False" Width="75%" 
    ondeletecommand="list_DeleteCommand" onitemcommand="list_ItemCommand" 
    >
            <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" />
            <MasterTableView TableLayout="Fixed">
                <ItemTemplate>
  <table cellPadding="0" align="left">
      <tr height="105">
        <td align="center" width="110">
          <a href='Product.aspx?ProductID=<%# Eval("ProductID")%>'>
          <img width="100" src='ProductImages/<%# Eval("Image1FileName") %>' blc_Order="0"/>
        </a>
        </td>
        <td vAlign="top" width="250">
          <a class="ProductName" href='Product.aspx?ProductID=<%# Eval("ProductID")%>'>
            <%# Eval("Name") %>
          </a>
          <br />
          <span class="ProductPrice">Price:
            <%# Eval("Price", "{0:c}") %>
          </span>
          <br />Date Added:
          <%# Eval("DateAdded", "{0:D}") %>
            <br />            
            Color:
          <%# Eval("Color") %>
            <br />
            Size:
          <%# Eval("Size") %>
<br />
          <asp:LinkButton id="SelectButton" 
                 Text="Add to Cart" 
                 CommandName="Insert"
                 CommandArgument='<%# Eval("ProductID") %>'
                 runat="server"/>
                 <br />
                 <asp:LinkButton id="DeleteButton" 
                 Text="Remove from WishList" 
                 CommandName="Delete"
                 CommandArgument='<%# Eval("ProductID") %>'
                 runat="server"/>
                 <br />
</td>
      </tr>
    </table>
  
                </ItemTemplate>
                <%--<GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldName="Price" />
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="Name" />
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>--%><RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
                <Columns>
                    <telerik:GridBoundColumn DataField="Name" HeaderText="Sort by Name" UniqueName="Name">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Price" DataType="System.Decimal" 
                        HeaderText="Sort by Price" UniqueName="column1">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>

<FilterMenu Skin="Vista" EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
        </telerik:RadGrid>
        <%--  <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="list">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="list" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px" Width="75px" Transparency="25">
            <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>' style="blc_Order:0;" />
        </telerik:RadAjaxLoadingPanel>--%>
