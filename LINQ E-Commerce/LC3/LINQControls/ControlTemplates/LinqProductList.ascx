<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinqProductList.ascx.cs" Inherits="LINQControls_LinqProductList" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
<h2><asp:Label ID="TitleLabel" runat="server"></asp:Label></h2>
<i><asp:Label ID="DescriptionLabel" runat="server"></asp:Label></i>
<telerik:RadGrid ID="list" 
            AllowPaging="True" runat="server" AllowSorting="True" Skin="Vista" 
    GridLines="None" PageSize="5" AutoGenerateColumns="False" Width="75%" 
    >
            <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" />
            <MasterTableView TableLayout="Fixed">
                <ItemTemplate>
  <table cellPadding="0" align="left">
      <tr height="105">
        <td align="center" width="110">
          <a href='Product.aspx?ProductID=<%# Eval("ProductID")%>'>
            <img width="100" src='ProductImages/<%# Eval("Image1FileName") %>' border="0"/>
          </a>
        </td>
        <td vAlign="top" width="250">
          <a class="ProductName" href='Product.aspx?ProductID=<%# Eval("ProductID")%>'>
            <%# Eval("Name") %>
          </a>
          <br/>
          <span class="ProductDescription">
            <%# Eval("Description") %>
            <br/><br/>
            Price: 
          </span>
          <span class="ProductPrice">
            <%# Eval("Price", "{0:c}") %>
          </span>
          <br />
          <asp:Button ID="addToCartButton" runat="server" Text="Add to Cart" Visible="false" CommandArgument='<%# Eval("ProductID") %>' CssClass="SmallButtonText"/>
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

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Web20" runat="server" Height="75px" Width="75px" Transparency="25">
        </telerik:RadAjaxLoadingPanel>
        </telerik:RadAjaxPanel>
