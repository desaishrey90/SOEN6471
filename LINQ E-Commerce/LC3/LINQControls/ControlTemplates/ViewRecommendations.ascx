<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewRecommendations.ascx.cs" Inherits="LINQControls_ControlTemplates_ViewRecommendations" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<style type="text/css">
    .style1
    {
        font-size: small;
    }
    .style2
    {
        font-size: medium;
    }
    .style3
    {
        font-size: small;
        font-family: Verdana;
    }
    .style4
    {
        font-family: Verdana;
    }
</style>
<asp:Button ID="ReviewFormbtn" runat="server" Text="Review this Product!" 
            onclick="ReviewFormbtn_Click" />
            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Back to Product" />
            <br />
<telerik:RadGrid ID="list" 
            AllowPaging="True" runat="server" AllowSorting="True" Skin="Vista" 
    GridLines="None" PageSize="5" AutoGenerateColumns="False" Width="75%">
            <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" />
            <MasterTableView TableLayout="Fixed">
                <ItemTemplate>
  <span class="style1"><span class="style2"><span class="style4">
        <span class="style1">
        <telerik:RadSlider ID="Rating1" runat="server" Value='<%# Eval("Points") %>'
                            Enabled="false"
                            Length="190"                            
                            SlideStep="1"
                            MinimumValue="1"
                            MaximumValue="5"
                            ShowDecreaseHandle="false"
                            ShowIncreaseHandle="false"
                            Skin="Vista"
                            /> <asp:Label ID="SliderValue" runat="server" Text='<%# "( " + Eval("Points") + " ) out of 5" %>'></asp:Label>
        <br />
        <asp:Label ID="TitleLabel" runat="server" 
            style="font-family: Verdana; font-size: small; font-weight: 700; color: #990000;" 
            Text='<%# Eval("Title") %>' />
        </span></span></span></span><span class="style1"><span class="style4">, Posted on 
        <asp:Label ID="DateInsertedLabel" runat="server" 
            style="font-style: italic; color: #006600;" 
            Text='<%# Eval("DateInserted", "{0:D}") %>' />
        </span></span>
        <br class="style3" />
        <span class="style1"><span class="style4">by
        <asp:Label ID="UserNameLabel" runat="server" style="color: #003366" 
            Text='<%# Eval("UserName") %>' />
        </span></span>
        <br class="style3" />
        <br class="style3" />
        <span class="style3">
        <asp:Label ID="DescriptionLabel" runat="server" 
            Text='<%# Eval("Description") %>' />
        </span>
        <br class="style3" />
<br />
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
                    <telerik:GridBoundColumn DataField="Points" DataType="System.Int16" HeaderText="Sort by Points" UniqueName="Points">
                    </telerik:GridBoundColumn>
                     <telerik:GridDateTimeColumn DataField="DateInserted" HeaderText="Sort by Date" UniqueName="DateInserted"
                     PickerType="DateTimePicker" />
                    
                    
                </Columns>
            </MasterTableView>
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>

<FilterMenu Skin="Vista" EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>
        </telerik:RadGrid>
          <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="DataList1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="DataList1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px" Width="75px" Transparency="25">
            <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>' style="blc_Order:0;" />
        </telerik:RadAjaxLoadingPanel>