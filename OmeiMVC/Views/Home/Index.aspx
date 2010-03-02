<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
O'Mei Travel
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="main_lightBlue">
    <div class="omei_promotion"><%= Html.Encode(ViewData["PromotionMessage"]) %></div>
    <img src="../../Content/images/main/content_home.jpg" width="729" height="269" />
</div>    
</asp:Content>

<asp:Content ID="headContent" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        $(function() {
            $("#main_navigate_menu > li:first").addClass("mainmenu_actived");
        });
    </script>
</asp:Content>
