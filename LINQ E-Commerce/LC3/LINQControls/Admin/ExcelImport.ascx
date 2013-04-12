<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ExcelImport.ascx.cs" Inherits="LINQControls_Admin_ExcelImport" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
 <table class="style1">
            <tr>
            <tr>
            <td>
            <h2>Insert MS Excel data into the Products Table</h2>
            </td>
            </tr>
                <td class="style2">
                    Excel&nbsp; File:</td>
                <td>
                  <telerik:RadUpload ID="RadUpload1" Skin="Web20" AllowedFileExtensions=".xls, .xlsx" InitialFileInputsCount="1" MaxFileInputsCount="1"  
                    runat="server"></telerik:RadUpload>
                    <%--<asp:FileUpload ID="FileUpload1" runat="server" />--%>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Name:</td>
                <td>
                    <asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Price:</td>
                <td>
                    <asp:TextBox ID="PriceTextBox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Description:</td>
                <td>
                    <asp:TextBox ID="DescriptionTextBox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    <br />
                    <asp:Button ID="btnInsert" runat="server" onclick="btnInsert_Click" 
                        Text="Insert Excel File" />
                </td>
                <td>
                   <b><asp:Label ID="ErrorLabel" runat="server" ForeColor="Blue"></asp:Label></b>
                </td>
            </tr>
        </table>
        <br />
<asp:Panel ID="Panel1" runat="server">
Instructions:
    <br />
    <br />
    Upload a valid Excel File using the form above. Name the form on the bottom, 
    where it says sheet1, sheet2, and etc., Products. For the column names on your 
    Excel sheet, put the name of the product column in the name column in the form 
    above. For the price column in your spreasheet, put the price name in the texbox 
    above and etc.<br />
</asp:Panel>
