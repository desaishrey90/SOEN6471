<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserInfo.ascx.cs" Inherits="UserInfo" %>
 <asp:LoginView ID="LoginView1" runat="server">
  <LoggedInTemplate>
       <center>
      Welcome, 
      <asp:LoginName ID="LoginName1" runat="server" />! <br />
     <asp:LoginStatus ID="LoginStatus3" runat="server" LogoutAction="RedirectToLoginPage"   />
     <br />
     <br />
     <asp:HyperLink ID="BillShipLink" runat="server" NavigateUrl="~/EditBillingShipping.aspx" Text="Update your Billing and Shipping Info"></asp:HyperLink>
  <br />
  <br />
      <asp:HyperLink ID="MyProfileLink" runat="server" NavigateUrl="~/EditMyProfile.aspx" Text="Update My Profile"></asp:HyperLink>

  <br />
  <br />
       <asp:HyperLink ID="lc_OrdersLink" runat="server" NavigateUrl="~/OrderHistory.aspx" Text="View your Order history"></asp:HyperLink>
  <br />
  <br />
  <asp:HyperLink ID="WishListLink" runat="server" Text="View your Wish List" NavigateUrl="~/WishList.aspx"></asp:HyperLink>
<br />
<br />
  <asp:HyperLink ID="PassLink" runat="server" Text="Change or Recover your Password" NavigateUrl="~/PasswordPage.aspx"></asp:HyperLink>
  </center>
  </LoggedInTemplate>
    <AnonymousTemplate>
     <asp:LoginStatus ID="LoginStatus1" LoginText="My Account" LogoutAction="RedirectToLoginPage" LogoutText="Log Out of My Account" runat="server"/>
    </AnonymousTemplate>
    <RoleGroups>
      <asp:RoleGroup Roles="Administrators">
        <ContentTemplate>
              <asp:LoginName ID="LoginName2" runat="server" FormatString="You are logged in as <b>{0}</b>. "
                />
            <br />
                <asp:LoginStatus ID="LoginStatus2" runat="server" />
              <br />
              <asp:HyperLink ID="AdminLink" runat="server" NavigateUrl="~/LINQControls/Admin/CatalogAdmin.aspx" Text="Administer this site"></asp:HyperLink>
        </ContentTemplate>
      </asp:RoleGroup>
    </RoleGroups>
  </asp:LoginView>