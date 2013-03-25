<%@ Page Title="Edit my Profile" Theme="BalloonShopDefault" Language="C#" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="EditMyProfile.aspx.cs" Inherits="EditMyProfile" %>

<%@ Register src="UserControls/Login/MyProfile.ascx" tagname="MyProfile" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:MyProfile ID="MyProfile1" runat="server" />
</asp:Content>

