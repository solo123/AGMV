<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<OmeiEDM.EDM_Destination>" %>
<div id="tabs">
    <ul>
        <li><a href="#fragment-1"><span>English</span></a></li>
        <li><a href="#fragment-2"><span> ÖĞÎÄ </span></a></li>
    </ul>
    <div id="fragment-1" class='dest_view'>
        <img width='100' height='75' class="title_pic1" src='http://www.omeitravel.com/images/upload/destinationPics/DestTn_<%= Model.titlePic %>.jpg' />
        <div class='text1'>
        <span class='title1'> <%= Html.Encode(Model.DestinationName) %></span>
        <span class='subtitle1'>
            <%= Html.Encode(Model.city) %>, <%= Html.Encode(Model.state) %>, <%= Html.Encode(Model.country) %>
        </span>
        <p>
            <%= Html.Encode(Model.Description) %>
        </p>
        </div>
        <div style="clear:both;"></div>
        <p>
            Status: <%= Html.Encode(Model.Status) %>
        </p>
    </div>
    <div id="fragment-2" class='dest_view'>
        <img width='100' height='75' class="title_pic1" src='http://www.omeitravel.com/images/upload/destinationPics/DestTn_<%= Model.titlePic %>.jpg' />
        <div class='text1'>
        <span class='title1'> <%= Html.Encode(Model.DestinationName_cn) %></span>
        <span class='subtitle1'>
            <%= Html.Encode(Model.city) %>, <%= Html.Encode(Model.state) %>, <%= Html.Encode(Model.country) %>
        </span>
        <p>
            <%= Html.Encode(Model.Description_cn) %>
        </p>
        </div>
        <div style="clear:both;"></div>
        <p>
            Status: <%= Html.Encode(Model.Status) %>
        </p>
    </div>
</div>

    <p>
        <input type="button" onclick="EditDest(<%= Model.DestinationID %>);" value="Edit" />
        <%=Html.ActionLink("Back to List", "Index") %>
    </p>


