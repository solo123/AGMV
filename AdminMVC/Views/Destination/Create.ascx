<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<com.Omei.OmeiModel.DestinationService>" %>

    <%= Html.ValidationSummary() %>

    <% using (Html.BeginForm("Create", "Destination", FormMethod.Post)) {%>

        <fieldset>
            <legend>Fields</legend>
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%=Html.ActionLink("Back to List", "Index") %>
    </div>


