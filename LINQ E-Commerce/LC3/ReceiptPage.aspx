<%@ Page Title="" Theme="BalloonShopDefault" Language="C#" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="ReceiptPage.aspx.cs" Inherits="ReceiptPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Label ID="lc_OrderIDLabel" runat="server"></asp:Label>
<p>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Back to Store" />
    </p>

</asp:Content>

