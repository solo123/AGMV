<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<OmeiWebModel.Destination>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
OmeiTravel.com - Destinations
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="destination_list">
        <% foreach (var item in Model) { %>
            <div>. <%= Html.ActionLink(item.DestinationName, "Detail", new { id=item.DestinationID })%></div>
        <% } %>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        $(function() {
            $("#main_navigate_menu > li:eq(2)").addClass("mainmenu_actived");
        });
    </script>
</asp:Content>

