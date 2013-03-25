<%@ Page Language="C#" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="PasswordPage.aspx.cs" Inherits="PasswordPage" Title="Change or Recover your Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="float: left; padding: 10px; width: 290px;">
<asp:PasswordRecovery ID="PasswordRecovery1" runat="server">
    </asp:PasswordRecovery>
    </div>
<div style="float: right; width: 540px; padding: 10px;" >
<asp:ChangePassword ID="ChangePassword1" runat="server" 
        CreateUserText="Create a New User" CreateUserUrl="~/login.aspx" 
        DisplayUserName="True" EditProfileText="Edit your Profile" 
        EditProfileUrl="~/EditBillingShipping.aspx">
    </asp:ChangePassword>
    </div>
</asp:Content>

