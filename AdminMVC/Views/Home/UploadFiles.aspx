<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AdminMVC.Controllers.ViewDataUploadFilesResult>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<title>UploadFiles</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>UploadFiles</h2>

<ul>  
<% foreach (AdminMVC.Controllers.UploadFilesResult v in this.ViewData.Model)  { %>  
       <%=String.Format("<li>Uploaded: {0} totalling {1} bytes.</li>",v.Name,v.Length) %>  
<%   } %>      
</ul>  
</asp:Content>
