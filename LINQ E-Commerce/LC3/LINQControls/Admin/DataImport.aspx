<%@ Page Language="C#" MasterPageFile="~/App_Master/Admin.master" Title="Import Data" AutoEventWireup="true" CodeFile="DataImport.aspx.cs" Inherits="LINQControls_Admin_DataImport" %>

<%@ Register src="XMLImport.ascx" tagname="XMLImport" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<div id="Div1" style="z-index: 1; left: 5px; top: 50px; width: 1000px; 
height: 1200px;
background-color:white; layer-background-color:#003366; visibility: visible">
        <asp:PlaceHolder id="adminPlaceHolder" runat="server"></asp:PlaceHolder>
        </div>
</asp:Content>
