<%@ Page Language="C#" Theme="BalloonShopDefault" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="InsertReview.aspx.cs" Inherits="InsertReview" Title="Insert a Review" %>

<%@ Register src="LINQControls/ControlTemplates/RecommendationsForm.ascx" tagname="RecommendationsForm" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div style="float: right; width: 900px;">
    <uc1:RecommendationsForm ID="RecommendationsForm2" runat="server" />
</div>
</asp:Content>

