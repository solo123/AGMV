<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<OmeiEDM.EDM_Destination>" %>

<% using (Html.BeginForm("Edit", "Destination", FormMethod.Post,new {id="myForm1"})) {%>
<div id="tabs">
    <ul>
        <li><a href="#fragment-1"><span>English</span></a></li>
        <li><a href="#fragment-2"><span> ÖÐÎÄ </span></a></li>
    </ul>
    <div id="fragment-1">
            <p>
                DestinationID:<strong>
            </p>
            <p>
                <label for="DestinationName">DestinationName:</label>
                <%= Html.TextBox("DestinationName") %>
                <%= Html.ValidationMessage("DestinationName", "*") %>
            </p>
            <p>
                <label for="Description">Description:</label>
                <%= Html.TextArea("Description", new { rows="10", cols="70" })%>
                <%= Html.ValidationMessage("Description", "*") %>
            </p>
    </div>
    <div id="fragment-2">
            <p>
                DestinationID:<strong>
            </p>
            <p>
                <label for="DestinationName_cn">DestinationName_cn:</label>
                <%= Html.TextBox("DestinationName_cn") %>
                <%= Html.ValidationMessage("DestinationName_cn", "*") %>
            </p>
            <p>
                <label for="Description_cn">Description_cn:</label>
                <%= Html.TextArea("Description_cn", new { rows = "10", cols = "70" })%>
                <%= Html.ValidationMessage("Description_cn", "*") %>
            </p>
    </div>
</div>
            <p>
                <label for="city">city:</label>
                <%= Html.TextBox("city") %>
                <%= Html.ValidationMessage("city", "*") %>
            </p>
            <p>
                <label for="state">state:</label>
                <%= Html.TextBox("state") %>
                <%= Html.ValidationMessage("state", "*") %>
            </p>
            <p>
                <label for="country">country:</label>
                <%= Html.TextBox("country") %>
                <%= Html.ValidationMessage("country", "*") %>
            </p>

            <p>
                <label for="Status">Status:</label>
                <%= Html.TextBox("Status") %>
                <%= Html.ValidationMessage("Status", "*") %>
            </p>

            <p>
                <input type="submit" value="Save" onclick="EditSave111();" />
            </p>

    <p>
    <%= Html.ValidationSummary() %>
    </p>

    <% } %>

 


