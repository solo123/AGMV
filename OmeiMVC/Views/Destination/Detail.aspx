<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<OmeiWebModel.Destination>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
O'Mei Travel - <%= Html.Encode(Model.DestinationName) %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="main_lightGreen" style="padding:20px;">
    <div id="relate_tours">
        <h2>Related Tours : </h2>
        <%
            System.Data.Objects.ObjectQuery o =  ViewData["relate"] as System.Data.Objects.ObjectQuery;
            

            
         %>
        <a id="A2" href="TourDetail.aspx?id=818">Hawall Package  7 Day 6 Night</a><br />
        <a id="A1" href="TourDetail.aspx?id=88">Hawall Package  7 Day 6 Night</a><br />
    </div>

    <div id="destination_detail">
        <div class="head">
            <h2><%= Html.Encode(Model.DestinationName) %></h2>
            <div><%= Html.Encode(Model.city) %>, <%= Html.Encode(Model.state) %>, <%= Html.Encode(Model.country) %>
            </div>
        </div>

        
        <img src="../../Content/images/main/about.jpg" width="100" height="75" />
        <%= Html.Encode(Model.Description) %>
    </div>
    <div id="photo_gallary"></div>

    <p>
        <%=Html.ActionLink("Back to List", "Index") %>
    </p>
</div>
</asp:Content>

<asp:Content ID="content3" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        $(function() {
            $("#main_navigate_menu > li:eq(2)").addClass("mainmenu_actived");
        });
    </script>
</asp:Content>


