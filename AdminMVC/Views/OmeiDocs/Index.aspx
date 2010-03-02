<%@ Page Title="O'Mei - Documents" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<OmeiEDM.EDM_OmeiDocument>>" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">  
<!--
    $(function() {
        $(".zebra_table tbody tr:even").addClass("alt");
        $('.zebra_table tbody tr').hover(
		    function() { $(this).addClass('over'); },
		    function() { $(this).removeClass('over'); }
	    ).click(
	        function() {
	            a = $(this).find("td:first").text(); //alert("/omeiDocs/Edit/"+ $.trim(a));
	            window.location = "/omeiDocs/Edit?docName=" + $.trim(a);
	        }
	    );
    });   
-->  
</script> 
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>O'Mei Documents</h2>

    <table id="tb1" cellpadding="4" cellspacing="0" border="1" class="zebra_table">
    <thead>
        <tr>
            <th>
                docName
            </th>
            <th>
                docNotes
            </th>
            <th>
                docTitle
            </th>
        </tr>
    </thead>
    <tbody>
    <% foreach (var item in Model) { %>
        <tr>
            <td>
                <%= Html.Encode(item.docName) %>
            </td>
            <td>
                <%= Html.Encode(item.docNotes) %>
            </td>
            <td>
                <%= Html.Encode(item.docTitle) %>
            </td>
        </tr>
    <% } %>
    </tbody>
    </table>

    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>



