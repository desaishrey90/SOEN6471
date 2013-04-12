<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="WishList.aspx.cs" Inherits="WishList" %>

<%@ Register src="LINQControls/ControlTemplates/WishList.ascx" tagname="WishList" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:WishList ID="WishList1" runat="server" />
</asp:Content>

