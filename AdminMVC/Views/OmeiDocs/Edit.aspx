<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<OmeiEDM.EDM_OmeiDocument>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Edit</h2>

    <%= Html.ValidationSummary("Edit was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm()) {%>

        <fieldset>
            <legend>Fields</legend>
            <p>
                Name: <%= Html.Encode(Model.docName) %>
            </p>
            <p>
                <label for="docNotes">docNotes:</label>
                <%= Html.TextBox("docNotes", Model.docNotes) %>
                <%= Html.ValidationMessage("docNotes", "*") %>
            </p>
            <p>
                <label for="docTitle">docTitle:</label>
                <%= Html.TextBox("docTitle", Model.docTitle) %>
                <%= Html.ValidationMessage("docTitle", "*") %>
            </p>
            <p>
                <label for="docContent">docContent:</label>
                <%= Html.TextArea("docContent", Model.docContent, new {width="400px",height="150px"})%>
                <%= Html.ValidationMessage("docContent", "*") %>
            </p>
            <p>
                <input type="submit" value="Save" />
                <span class="error_message"><%= ViewData["ErrorMessage"]  %></span>
            </p>
        </fieldset>

    <% } %>

    <div>
        <%=Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

