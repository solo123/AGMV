<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<OmeiEDM.EDM_OmeiDocument>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Create</h2>

    <%= Html.ValidationSummary("Create was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm("Create", "OmeiDocs", FormMethod.Post)) {%>

        <fieldset>
            <legend>Fields</legend>
            <p>
                <label for="docName">docName:</label>
                <%= Html.TextBox("docName") %>
                <%= Html.ValidationMessage("docName", "*") %>
            </p>
            <p>
                <label for="docNotes">docNotes:</label>
                <%= Html.TextBox("docNotes") %>
                <%= Html.ValidationMessage("docNotes", "*") %>
            </p>
            <p>
                <label for="docTitle">docTitle:</label>
                <%= Html.TextBox("docTitle") %>
                <%= Html.ValidationMessage("docTitle", "*") %>
            </p>
            <p>
                <label for="docContent">docContent:</label>
                <%= Html.TextBox("docContent") %>
                <%= Html.ValidationMessage("docContent", "*") %>
            </p>
            <p>
                <input type="submit" value="Create" />
                <%= ViewData["Test"] %> | 
                <%= ViewData["ErrorMessage"] %>
            </p>
            
        </fieldset>

    <% } %>

    Error: <%= ViewData["ErrorMessage"] %>
    <div>
        <%=Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

