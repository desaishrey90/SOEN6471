<%@ Page Language="C#" Theme="BalloonShopDefault" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="UserProfile_login" Title="My Account" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="float: left; padding: 10px;  width: 290px;">
    <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/Catalog.aspx" 
        PasswordRecoveryText="Forgot your password?" 
        PasswordRecoveryUrl="~/PasswordPage.aspx">
    </asp:Login>
</div>
<div style="float: right; padding: 10px; width: 540px;">
    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 
        oncontinuebuttonclick="CreateUserWizard1_ContinueButtonClick" 
        oncreateduser="CreateUserWizard1_CreatedUser">
        <WizardSteps>
            <asp:CreateUserWizardStep runat="server" />
            <asp:CompleteWizardStep runat="server" />
        </WizardSteps>
    </asp:CreateUserWizard>
</div>
</asp:Content>

