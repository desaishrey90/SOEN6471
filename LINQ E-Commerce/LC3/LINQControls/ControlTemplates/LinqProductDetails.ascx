<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinqProductDetails.ascx.cs" Inherits="LINQControls_ProductDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register src="LinqDigitalProductDetails.ascx" tagname="LinqDigitalProductDetails" tagprefix="uc1" %>

<asp:Panel ID="pnlProductDetails" runat="server" CssClass="lcProductContainer">
<!-- Product Image -->
<div class="lcProductImages">
    <telerik:RadAjaxManager ID="ProductImageRadAjaxManager" runat="server" OnAjaxRequest="ProductImageRadAjaxManager_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ProductImageRadAjaxManager">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pictureImage" LoadingPanelID="LoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
        
    <asp:Image ID="pictureImage" runat="server" Visible="true" />
    <asp:Repeater ID="rpProductImages" runat="server" Visible="false">
        <ItemTemplate>
            <div>
                <div style="float: left" id="smallImage" runat="server">
                    <div class="smallAltImage" onclick="return InitiateAsyncRequest('<%# Eval("ProductImageID")%>');" 
                        style="border: 1px solid #999999; margin: 5px 5px 5px 4px;
                        width: 45px; height: 45px; background-position: center; background-repeat: no-repeat; 
                        background-image: url('<%#ResolveClientUrl(productImagesPath)%><%# String.Format("{0}", DataBinder.Eval(Container.DataItem, "ImageName")) %>');">
                    </div>
                    <asp:Label ID="lblImageName" runat="server" Visible="false"><%# Eval("ImageName")%></asp:Label>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
      
    <telerik:RadAjaxLoadingPanel ID="LoadingPanel1" runat="server" />
        
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function InitiateAsyncRequest(argument) {
                var ajaxManager = <%= ProductImageRadAjaxManager.ClientID %>;
                ajaxManager.ajaxRequest(argument);
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
</div>
    
    <!-- Product Details -->
    <div class="lcProductDetails">
        <h1><asp:Label ID="titleLabel" runat="server" Text="Label"></asp:Label></h1>
        <h3><asp:Label ID="priceLabel" runat="server" Text="Label" ForeColor="Red"></asp:Label></h3>
        <div class="lcProductText"><asp:Label ID="descriptionLabel" runat="server"></asp:Label></div>
        <asp:Panel ID="pnlOutOfStock" runat="server" Visible="false" CssClass="warning">Item currently out of stock!</asp:Panel>
        
        <!-- Quantity To Add -->
        <asp:Panel ID="QuantityPanel" runat="server" CssClass="lcProductQuantity">
            <asp:Label ID="QuantityLabel" runat="server" Text="Quantity to Add:" />
            <telerik:RadNumericTextBox ID="QuantityTextBox" Runat="server" Width="30" DataType="Int" Skin="Vista" Value="1" Type="Number" NumberFormat-DecimalDigits="0" MinValue="1" MaxValue="1000"></telerik:RadNumericTextBox>
        </asp:Panel>
        
        <!-- Size Variants -->
        <asp:Panel ID="SizePanel" runat="server">
            <asp:Label ID="SizeLabel" runat="server" Text="Choose a size:"></asp:Label>
            <telerik:RadComboBox runat="server" ID="SizeRadComboBox" Skin="Vista" Width="110px"
                DataSourceID="SizeDataSource" DataTextField="Size" DataValueField="SizeID">
                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
            </telerik:RadComboBox>
        </asp:Panel>
        
        <!-- Color Variants -->
        <asp:Panel ID="ColorPanel" runat="server">
            <asp:Label ID="ColorLabel" runat="server" Text="Choose a color:"></asp:Label>
            <telerik:RadComboBox runat="server" ID="ColorRadComboBox" Skin="Vista" Width="110px"
                DataSourceID="ColorDataSource" DataTextField="Color" DataValueField="ColorID">
                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
            </telerik:RadComboBox>
        </asp:Panel>
        <!-- Variant Messages -->
        <asp:Label ID="ComboLabel" runat="server" Text="Label" Visible="false"></asp:Label>
        
        <!-- Buttons -->
        <asp:Button ID="addToCartButton" runat="server" Text="Add to Cart" OnClick="addToCartButton_Click" />
        <asp:Button ID="continueShoppingButton" runat="server" Text="Continue Shopping" OnClick="continueShoppingButton_Click" />
        <asp:Button ID="addToWishListButton" runat="server" Text="Add to Wish List" OnClick="addToWishListButton_Click" Visible="false" />
        
        <!-- Info/Success/Error Messages -->
        <asp:Label ID="FeedbackLabel" runat="server" CssClass="error" Visible="false"></asp:Label>
        
        <!-- Product Rating/Reviews -->
        <asp:Panel ID="pnlProductReviews" runat="server" Visible="false" CssClass="lcProductReviewsContainer">
            <telerik:RadSlider ID="Rating1" runat="server" Enabled="false" Length="160" SlideStep="1" 
                MinimumValue="1" MaximumValue="5" ShowDecreaseHandle="false" ShowIncreaseHandle="false" ShowDragHandle="false"
                Skin="Vista" />
            <em><asp:Label ID="ValueLabel" runat="server"></asp:Label></em>
            <div><strong><asp:HyperLink ID="ReviewHyperLink" runat="server" Text="See Reviews for this Product"></asp:HyperLink></strong></div>
        </asp:Panel>
        <asp:Panel ID="pnlDigital" runat="server" Visible="false">
    <uc1:LinqDigitalProductDetails ID="digital" runat="server" />
</asp:Panel>

    </div>
</asp:Panel>

<asp:Panel ID="pnlRecommendedProducts" runat="server" CssClass="lcProductRecommendations" Visible="false">
    <h2><asp:Label ID="recommendationsHeader" runat="server" Text="Customers who bought this product also purchased:"></asp:Label></h2>
    <asp:DataList ID="RecommendationsDataList" runat="server" CellPadding="4" 
        CellSpacing="4" RepeatColumns="2" Height="487px">
        <ItemTemplate>
            <img width="100" src='ProductImages/<%# Eval("Image1FileName") %>' border="0" />
            <br />
            <a class="RecommendationLink" href='Product.aspx?ProductID=<%# Eval("ProductID") %>'>
                <%# Eval("Name") %>
            </a>
            <br />
            Price:
            <%# Eval("Price", "{0:c}") %>
        </ItemTemplate>
    </asp:DataList>
</asp:Panel>
<asp:Panel ID="pnlErrorMessage" runat="server" CssClass="error" Visible="false">
    <strong>No records exist.</strong><br />
    Please note that you can't navigate to this page directly. You must have a ProductID.
    <div><asp:Label ID="lblErrorMessage" runat="server" /></div>
</asp:Panel>


<asp:LinqDataSource ID="SizeDataSource" runat="server" ContextTypeName="LinqCommerceDataContext"
    TableName="lc_SizeTables" OrderBy="SizeID">
</asp:LinqDataSource>

<asp:LinqDataSource ID="ColorDataSource" runat="server" ContextTypeName="LinqCommerceDataContext"
    TableName="lc_ColorTables" OrderBy="ColorID">
</asp:LinqDataSource>