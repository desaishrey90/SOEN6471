<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinqOrderSummary.ascx.cs" Inherits="LINQControls_ControlTemplates_Linqlc_OrderSummary" %>
<h2>lc_Order Summary</h2>
<br />
Items: <asp:Label ID="ItemsLabel" runat="server"></asp:Label>
<br />
Shipping: <asp:Label ID="ShippingAmountLabel" runat="server"></asp:Label>
<br />
Tax: <asp:Label ID="TaxLabel" runat="server"></asp:Label>
<br />
-------------
<br />
Total amount:
<b><asp:Label ID="totalAmountLabel" runat="server" Text="Label"  /></b>