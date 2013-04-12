<%@ Page Language="C#" MasterPageFile="~/App_Master/BalloonShop.master" AutoEventWireup="true" CodeFile="ViewRecommendations.aspx.cs" Inherits="ViewRecommendations" Title="View Recommendations" %>

<%@ Register src="LINQControls/ControlTemplates/ViewRecommendations.ascx" tagname="ViewRecommendations" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="float: right; width: 900px;">
<asp:Button ID="ReviewFormbtn" runat="server" Text="Review this Product!" 
            onclick="ReviewFormbtn_Click" />
            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Back to Product" />
    <uc1:ViewRecommendations ID="ViewRecommendations1" runat="server" />
  
    </div>
</asp:Content>

