<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="OmeiMVC.Models" %>
<% if (Session["UserInfo"] != null)
   {
       OmeiWebModel.UserInfo ui = (OmeiWebModel.UserInfo)Session["UserInfo"]; %>
    Welcome <% Response.Write(ui.firstName); %>! | <a href="MyOrder.aspx">My account</a>
    <a href="#"><img src="../../Content/images/main/icon_key.gif" alt=""/> Logout</a>    
<% }
   else
   { %>
    <a href="/Account/Login"><img src="../../Content/images/main/icon_key.gif" alt=""/> Login</a>
<% } %>