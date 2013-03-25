<%@ Page Language="C#" Theme="BalloonShopDefault" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="ShoppingCart.aspx.cs" Inherits="ShoppingCart" Title="Shopping Cart" %>
<%@ Register src="LINQControls/ControlTemplates/LinqShoppingCart.ascx" tagname="LinqShoppingCart" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <uc1:LinqShoppingCart ID="LinqShoppingCart1" runat="server" />

</asp:Content>

