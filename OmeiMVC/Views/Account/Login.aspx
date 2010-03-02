<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	O'Mei Travel - Login / Create account
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="main_lightBlue">
    
    <div class="loginForm">
    <% using (Html.BeginForm())
       { %>

        <h2>Log in / Create account</h2>
        
        <p>Don't have an account? <%= Html.ActionLink("Create one", "SignUp") %>.</p>
        
        <label class="prompt" for="UserName">Email:</label>
        <br />
        <%= Html.TextBox("email") %>
        
        <br /><br />
            
        <label class="prompt" for="Password">Password:</label>
        <br />
        <%= Html.Password("password") %>
        
        <br /><br />

        <input type="submit" value="Log in" />
        &nbsp;&nbsp;
        <input type="button" value="E-mail new password" />
        <br /><br />
        <%= Html.Encode(ViewData["LoginMessage"]) %>        

    <% } %>
    </div>
    
    <div>
        
    </div>
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
<style type="text/css">
.loginForm
{
	border:solid 1px #999;
	padding:8px;
	width: 300px;
}
.loginForm h2 
{
	border-bottom:1px solid #AAAAAA;
color:black;
font-weight:normal;
margin:0;
font-size: 150%;
padding-bottom:0.17em;}
</style>
</asp:Content>
