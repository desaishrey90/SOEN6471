<%@ Page Language="C#" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Theme="BalloonShopDefault" Inherits="Product" Title="Products" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="LINQControls/ControlTemplates/LinqProductDetails.ascx" tagname="ProductDetails" tagprefix="uc2" %>
<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc2:ProductDetails ID="ProductDetails1" runat="server" />
</asp:Content>

