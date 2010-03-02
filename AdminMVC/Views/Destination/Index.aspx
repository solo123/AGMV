<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<OmeiEDM.EDM_Destination>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<title>Index</title>
	<script type="text/javascript" src="../../Scripts/jquery.galleriffic.min.js"></script>
	<script type="text/javascript" src="../../Scripts/jquery.form.js"></script> 
	<script type="text/javascript">
	    // http://www.twospy.com/galleriffic/index.html

	    $(function() {

	        $('#DetailWin').dialog({
	            autoOpen: false,
	            closeOnEscape: true,
	            draggable: true,
	            show: 'fast',
	            title: 'Destination Detail',
	            width: 550
	        });
	        
	    });

			function OpenDetailView(id) {
			    var url = "/Destination/Details/" + id;
			    $('#EditWin').html("Loading ...").load(url, function() { $("#tabs").tabs();});
			    $('#DetailWin').dialog('open');
			}

			function EditDest(id) {
			    var url = "/Destination/Edit/" + id;
			    alert(url);
			    $('#EditWin').html("Loading ...").load(url, function() { $("#tabs").tabs(); });
			    $('#DetailWin').dialog('open');
			}

			function EditSave() {
			    var f = $('#myForm1');
			    if(!f) { alert('form not found!'); return; }
			    
	            var options = {
                    //target: '#output1',   // target element(s) to be updated with server response 
                    beforeSubmit: showRequest,  // pre-submit callback 
                    success: showResponse,  // post-submit callback 

                    // other available options: 
                    //url:   "TestPost_001"         // override for form's 'action' attribute 
                    //type:      type        // 'get' or 'post', override for form's 'method' attribute 
                    //dataType:  null        // 'xml', 'script', or 'json' (expected server response type) 
                    //clearForm: true        // clear all form fields after successful submit 
                    //resetForm: true        // reset the form after successful submit 

                    // $.ajax options can be used here too, for example: 
                    //timeout:   3000 
                };

                // bind form using 'ajaxForm' 
                f.ajaxForm(options);	
                
                f.ajaxSubmit(options);		    
			}
			
			        // pre-submit callback 
        function showRequest(formData, jqForm, options) {
            // formData is an array; here we use $.param to convert it to a string to display it 
            // but the form plugin does this for you automatically when it submits the data 
            var queryString = $.param(formData);

            // jqForm is a jQuery object encapsulating the form element.  To access the 
            // DOM element for the form do this: 
            // var formElement = jqForm[0]; 

            alert('About to submit: \n\n' + queryString);

            // here we could return false to prevent the form from being submitted;
            // returning anything other than false will allow the form submit to continue

            return true;
        }

        // post-submit callback 
        function showResponse(responseText, statusText) {
            // for normal html responses, the first argument to the success callback 
            // is the XMLHttpRequest object's responseText property 

            // if the ajaxForm method was passed an Options Object with the dataType 
            // property set to 'xml' then the first argument to the success callback 
            // is the XMLHttpRequest object's responseXML property 

            // if the ajaxForm method was passed an Options Object with the dataType 
            // property set to 'json' then the first argument to the success callback 
            // is the json data object returned by the server 

            alert('status: ' + statusText + '\n\nresponseText: \n' + responseText +
        '\n\nThe output div should have already been updated with the responseText.');
        } 
        
    </script>
	
	<style type="text/css">
ul#destination_list > li{display:block;}
ul#destination_list > li > h2 {clear:both; float:none; border-bottom: solid 2px darkRed; color: darkRed;}
ul.thumbs {
	clear: both;
	margin: 0;
	padding: 0;
}
ul.thumbs li {
	float: left;
	padding: 4px;
	margin: 5px 10px 5px 0;
	width:150px;
	height: 150px;
	overflow: hidden;
	list-style: none;
	list-style-image: none;
}
ul.thumbs li .group
{
	clear:both;
	float:none;
	font-size: 130%;
	font-weight:bold;
	color: darkRed;
}
a.thumb {
	padding: 2px;
	display: block;
	white-space:nowrap;
	overflow : hidden;
}
ul.thumbs li.selected a.thumb {
	background: #000;
}
a.thumb:focus {
	outline: none;
}
a.thumb:hover
{
	background-color: #ffffe0;
}
a.thumb > .small {font-size: 70%; font-weight:bold;}
ul.thumbs img {
	border: none;
	display: block;
	text-align:center;
	padding:2px;
	border:solid 1px #ccc;
}	
	</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Index</h2>
    
    <div id="DetailWin" class="ui-dialog ui-widget ui-widget-content ui-corner-all undefined ui-draggable ui-resizable">
        <div id="EditWin"></div>
    </div>

          
    
   <ul id="destination_list"> 
        <%  string c = null;
            foreach (var item in Model)
           {
               if (c != item.country)
               {
                   
                   %>
                   
                   <% if (c != null)
                      { %> </ul></li> <% } %>
                   <li>
                   <h2><%= item.country %></h2>
                   <ul class="thumbs">    
                   <%
                   c = item.country;
               }
               %>
        <li>
            <a class="thumb" 
                onclick="OpenDetailView('<%= item.DestinationID %>')" tagID='<%= item.DestinationID %>'
                title='<%= item.DestinationName %>'>
                <img src='http://www.omeitravel.com/images/upload/destinationPics/DestTn_<%= item.titlePic %>.jpg' 
                    alt='<%= item.DestinationName %>' width="100" height="75" />
                <%= item.DestinationName %><br />
                <%= item.DestinationName_cn  %><br />
                <span class="small">(<%= item.city %>, <%= item.state %>)</span>
            </a>
        </li>
        <% } %>
        </ul></li>
    </ul>

    <div style="clear:both;"></div>


    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

