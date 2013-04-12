<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/AdminLogin.master" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="LINQControls_Admin_AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
        <table>
            <tr>
                <td>
                    <b>Admin Login</b>
                </td>
            </tr>
            <tr>
            <td>
                <asp:Label ID="lblusername" runat="server" Text="User Name">
                
                </asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox id="txtusername" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="rqv" runat="server" ControlToValidate="txtusername" ErrorMessage="User Name is required."></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
            <td>
                <asp:Label ID="lblpassword" runat="server" Text="Password">
                
                </asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox id="txtpassword" runat="server" TextMode="Password"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtpassword" ErrorMessage="Password is required."></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnlogin" runat="server" Text="Login" 
                        onclick="btnlogin_Click" />
                </td>
            </tr>
        </table>
    </div>

</asp:Content>

