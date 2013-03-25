<%@ Control Language="C#" AutoEventWireup="true" CodeFile="XMLImport.ascx.cs" Inherits="LINQControls_Admin_XMLImport" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<h2>Insert XML into the Products Table</h2>
        <br />
        <table class="style1">
            <tr>
                <td class="style2">
                    XML File:</td>
                <td>
                    <telerik:RadUpload ID="RadUpload1" Skin="Web20" AllowedFileExtensions=".xml" InitialFileInputsCount="1" MaxFileInputsCount="1"  
                    runat="server"></telerik:RadUpload>
                    <%--<asp:FileUpload ID="FileUpload1" runat="server" />--%>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Descendents Tag:</td>
                <td>
                    <asp:TextBox ID="DescendentsTextBox" runat="server"></asp:TextBox>
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
                        Text="Insert XML" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        <br />
        <b><asp:Label ID="ErrorLabel" runat="server" ForeColor="Blue"></asp:Label></b>
        <br />
        <br />
<p>
        <h3>Instructions</h3></p>
<p>
    Consider the following XML File:  
  
    <p>
        <br />
        &lt;Products&gt;</p>
    <p>
        &lt;Product&gt;</p>
    <p>
        &lt;Name&gt;Pen&lt;/Name&gt;</p>
    <p>
        &lt;Price&gt;10&lt;/Price&gt;</p>
    <p>
        &lt;Description&gt;This is a pen&lt;/Description&gt;</p>
    <p>
        &lt;/Product&gt;</p>
    <p>
        &lt;Product&gt;</p>
    <p>
        ...</p>
    <p>
        &lt;/Product&gt;</p>
    <p>
        &lt;/Products&gt;</p>
    <p>
        The descendents tag is Product because that is the tag that repeats and contains 
        each product. Then, the name tag matches to the name tag here. The price tag 
        matches to the price tag here and etc. The tags in your XML file can be anything 
        that you want, but this one is used as an example.</p>
   