<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	O'Mei Travel - Sign up
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="main_lightBlue">
    <% using (Html.BeginForm("SignUp", "Account", FormMethod.Post, new { id = "signupForm" }))
       {%>

    <%= Html.ValidationSummary("Create was unsuccessful. Please correct the errors and try again.") %>
    <%= ViewData["test"] %>
    <%= ViewData["ErrorMessage"] %>

<center>
<h2>OmeiTravel-Sign up</h2>
<table width="730" cellspacing="0" cellpadding="4" border="1" align="center" style="border: 1px solid gray; border-collapse: collapse;">
  <tbody>
    <tr>
      <td align="left" class="message_tit">
          Please fill request info blow:</td>
    </tr>
    <tr>
      <td class="message_win"><table width="100%" cellspacing="4" cellpadding="4" border="0">
          <tbody><tr>
            <td align="right" width="100">
                Email:
            </td>
            <td align="left">
                <%= Html.TextBox("email") %>
                </td>
          </tr>
          <tr>
            <td align="right">
                Password:
            </td>
            <td align="left">
                <%= Html.Password("password", null, new {width="130px"})%>
                </td>
          </tr>
          <tr>
            <td align="right">
                Password again:
            </td>
            <td align="left">
                <input type="password" name="confirm_password" width="130" />
                </td>
          </tr>
          <tr>
          <td> 
          </td>
              <td align="left">
                   <input type="submit" value="Sign up" />
                   <input type="button" value="Cancel" />
              </td>
          </tr>
      </tbody></table></td>
    </tr>
    <tr>
      <td align="left" class="message_tit">
          Please input optional info blow:</td>
    </tr>
    <tr>
      <td class="message_win"><table width="100%" cellspacing="4" cellpadding="4" border="0">
        <tbody><tr>
            <td align="right" width="100">
                First name:
            </td>
            <td align="left">
                <%= Html.TextBox("firstname") %>
                  Last name:
                <%= Html.TextBox("lastname") %>
                </td>
          </tr>
          <tr>
            <td align="right">
                Address:
            </td>
            <td align="left">
                <%= Html.TextBox("address") %>
                </td>
          </tr>
          <tr>
            <td align="right">
                City:
            </td>
            <td align="left">
                <%= Html.TextBox("city") %>
                State:<%= Html.TextBox("state") %>
                ZIP:<%= Html.TextBox("zip") %>
                </td>
          </tr>
          <tr>
            <td align="right">
                Country:</td>
            <td align="left">
                <%= Html.TextBox("country") %>
                </td>
          </tr>
          <tr>
            <td align="right">
                Contact phone:
            </td>
            <td align="left">
                <%= Html.TextBox("contactphone") %>
                </td>
                
          </tr>
          <tr>
            <td align="right">
                Cell phone:</td>
            <td align="left">
                <%= Html.TextBox("mobile") %></td>
          </tr>
          <tr>
            <td valign="top" align="right">
                Join maillist:</td>
            <td align="left">
                <%= Html.CheckBox("joinmaillist",true) %>
                Join OmeiTravel mail list</td>
          </tr>
          <tr>
              <td valign="top" align="right">
              </td>
              <td align="left">
<input type="submit" value="Sign Up" />
<input type="button" value="Cancel" /></td>
          </tr>
      </tbody></table>
          </td>
    </tr>
  </tbody>
</table>
</center>

    <% } %>

<br /><br />
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="../../Scripts/jquery.validate.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $(function() {
        $("#signupForm").validate({
            rules: {
                password: {
                    required: true,
                    minlength: 5
                },
                confirm_password: {
                    required: true,
                    minlength: 5,
                    equalTo: "#password"
                },
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                password: {
                    required: " Please provide a password",
                    minlength: " Your password must be at least 5 characters long"
                },
                confirm_password: {
                    required: " Please provide a password",
                    minlength: " Your password must be at least 5 characters long",
                    equalTo: " Please enter the same password as above"
                },
                email: " Please enter a valid email address"
            }
        });

    });
        
    </script>
</asp:Content>

