<%@ Page Language="C#" Theme="BalloonShopDefault" MasterPageFile="~/App_Master/Admin.master" AutoEventWireup="true" CodeFile="OrdersAdmin.aspx.cs"
  Inherits="OrdersAdmin" Title="Orders Admin" %>
  <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
<%--<telerik:RadAjaxPanel LoadingPanelID="RadAjaxLoadingPanel1" ID="RadAjaxPanel1" runat="server">
--%>    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Vista">
   </telerik:RadAjaxLoadingPanel>
<asp:PlaceHolder ID="adminPlaceHolder" runat="server"></asp:PlaceHolder>
<%--    </telerik:RadAjaxPanel>
--%></asp:Content>
