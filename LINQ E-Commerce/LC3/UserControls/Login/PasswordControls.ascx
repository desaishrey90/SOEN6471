<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PasswordControls.ascx.cs" Inherits="UserControls_Login_PasswordControls" %>
<div style="float: left; padding: 10px; width: 290px;">
<asp:PasswordRecovery ID="PasswordRecovery1" runat="server">
    </asp:PasswordRecovery>
    </div>
<div style="float: right; width: 540px; padding: 10px;" >
<asp:ChangePassword ID="ChangePassword1" runat="server" 
        CreateUserText="Create a New User" CreateUserUrl="~/loginpage.aspx" 
        DisplayUserName="True" EditProfileText="Edit your Profile" 
        EditProfileUrl="~/EditBillingShipping.aspx">
    </asp:ChangePassword>
    </div>