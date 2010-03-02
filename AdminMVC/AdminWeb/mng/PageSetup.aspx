<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminPopup.master" AutoEventWireup="true" Inherits="PageSetup" Title="Untitled Page" Codebehind="PageSetup.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:SiteMapPath ID="SiteMapPath1" runat="server">
</asp:SiteMapPath>

<hr />

    <asp:Button ID="btnLoad" runat="server" Text="re-Load Sitemap" OnClick="btnLoad_Click" />
</asp:Content>

