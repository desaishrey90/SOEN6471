<%@ Page Language="C#" Theme="BalloonShopDefault" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="OrderHistory.aspx.cs" Inherits="OrderHistory" Title="lc_Order History" %>

<%@ Register src="UserControls/Login/OrderHistory.ascx" tagname="OrderHistory" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:OrderHistory ID="OrderHistory2" runat="server" />
</asp:Content>

