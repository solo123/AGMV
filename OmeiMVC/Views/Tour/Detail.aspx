<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<OmeiWebModel.Tour>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	O'Mei Travel - Tour Detail
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="main_lightGreen" style="padding:20px;">

    <div>
        <div class="head">
            <h2><%= Html.Encode(Model.TourName) %></h2>
        </div>

        <%= Html.Encode(Model.Description) %>
    </div>
    <div>
        <% Html.RenderPartial("TourDestinations", ViewData["TourDestinations"]); %>
    </div>

    <p>
        <%=Html.ActionLink("Back to List", "Index") %>
    </p>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

