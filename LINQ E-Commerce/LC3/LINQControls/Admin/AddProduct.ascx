<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddProduct.ascx.cs" Inherits="LINQControls_Admin_AddProduct" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
</style>
<asp:Panel ID="Panel1" runat="server" GroupingText="Add Product">
<table class="style1">
    <tr>
        <td>
            Name:</td>
        <td>
            <telerik:RadTextBox ID="NameRadTextBox" Width="200px" Runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" ControlToValidate="NameRadTextBox" runat="server" ErrorMessage="Required Field" ToolTip="Please enter a name." Text="Please enter a name."></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td>
            Description:</td>
        <td>
            <telerik:RadEditor ID="DescriptionRadEditor" Runat="server">
            </telerik:RadEditor>
                        <asp:RequiredFieldValidator ID="DescriptionRequiredFieldValidator" ControlToValidate="DescriptionRadEditor" runat="server" ErrorMessage="Required Field" ToolTip="Please enter a description." Text="Please enter a description."></asp:RequiredFieldValidator>

        </td>
    </tr>
    <tr>
        <td>
            Price:</td>
        <td>
            <telerik:RadNumericTextBox ID="PriceRadNumericTextBox" MinValue="0" Runat="server">
            </telerik:RadNumericTextBox>
        <asp:RequiredFieldValidator ID="PriceRequiredFieldValidator" ControlToValidate="PriceRadNumericTextBox" runat="server" ErrorMessage="Required Field" ToolTip="Please enter a price." Text="Please enter a price."></asp:RequiredFieldValidator>

        </td>
    </tr>
    <tr>
        <td>
            On Dept Promotion:</td>
        <td>
            <asp:CheckBox ID="OnDeptCheckBox" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            On Catalog Promotion:</td>
        <td>
            <asp:CheckBox ID="OnCatCheckBox" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            Sizeable</td>
        <td>
            <asp:CheckBox ID="SizeCheckBox" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            Colorable</td>
        <td>
            <asp:CheckBox ID="ColorCheckBox" runat="server" />
        </td>
    </tr>
</table>
<p>
    &nbsp;</p>
    <asp:Label ID="MessageLabel" runat="server"></asp:Label>
    <p></p>
<asp:Button ID="Button1" runat="server" Text="Submit" />
<p></p>
    <asp:Button ID="Button2" CausesValidation="false" runat="server" Text="Cancel and Go Back" />
</asp:Panel>