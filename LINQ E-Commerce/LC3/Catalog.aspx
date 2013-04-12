<%@ Page Language="C#" Theme="BalloonShopDefault" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="Catalog.aspx.cs" Inherits="Catalog" Title="Balloon Shop Catalog" %>

<%@ Register src="LINQControls/ControlTemplates/LinqProductList.ascx" tagname="LinqProductList" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc2:LinqProductList ID="LinqProductList1" runat="server" />
</asp:Content>

