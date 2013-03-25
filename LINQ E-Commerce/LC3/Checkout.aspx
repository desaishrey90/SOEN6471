<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Checkout" %>

<%@ Register src="LINQControls/ControlTemplates/PaymentForm.ascx" tagname="PaymentForm" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:PaymentForm ID="PaymentForm1" runat="server" />
</asp:Content>

