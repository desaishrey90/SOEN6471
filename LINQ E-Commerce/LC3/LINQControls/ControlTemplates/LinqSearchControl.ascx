<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinqSearchControl.ascx.cs" Inherits="Sandbox_LinqSearchControl" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<script type="text/javascript">
function OnClientItemsRequesting(sender,e)
{
    if(sender.get_appendItems())
        e.get_context().CustomText="";
    else
        e.get_context().CustomText=sender.get_text();
}
</script>
   <telerik:RadComboBox ID="RadComboBox1" runat="server" Width="250px" Height="200px"
                AllowCustomText="True" ShowToggleImage="False" ShowMoreResultsBox="true"
                    EnableLoadOnDemand="True" MarkFirstMatch="True" 
    OnClientItemsRequesting="OnClientItemsRequesting" 
    OnItemsRequested="RadComboBox1_ItemsRequested" 
    EnableVirtualScrolling="true" Skin="WebBlue" >
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                </telerik:RadComboBox>
                <asp:Button ID="btnSearch" runat="server" 
    onclick="btnSearch_Click" Text="Search Products" 
    ToolTip="Search for products" />
