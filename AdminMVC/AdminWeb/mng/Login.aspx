<%@ Page Language="C#" AutoEventWireup="true" Inherits="LoginPage" Title="O'Mei - User Login" Codebehind="Login.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>OmeiTravel.net - Login</title>
    <style type="text/css">
    .LoginFont{
	    font-size: 130%;
    }
    #login_div {width:300px; margin:auto; text-align:left;font-size:130%; padding-top:30px;}
    #login_title{border-bottom:5px solid #C8E0C0;font-size:18pt;font-weight:bold;margin-bottom:30px;}
    .login_prompt{width:100px; float:left; height:50px;}
    .login_input{float:left; height:50px}
    .login_button{margin-left:100px;clear:both; margin-bottom:10px;}
    </style>
</head>

<script language="jscript" type="text/jscript">
// To browser top frame
if (top.frames.length!=0) 
    top.location=self.document.location; 
</script>    

<body>
<form id="form1" runat="server">
    <div class="shadowbox">
        <div class="shadowContent">
            <div id="login_div">
                <div id="login_title">User Login</div>
                <div class="login_prompt">Login ID:</div>
                <div class="login_input"><asp:TextBox ID="txtUsername" runat="server" Width="150px" CssClass="LoginFont"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername"
                                                                    SetFocusOnError="True" ErrorMessage="*" CssClass="LoginFont"></asp:RequiredFieldValidator></div>
                <div class="login_prompt">Password:</div>
                <div class="login_input"><asp:TextBox ID="txtPassword" runat="server" Width="150px" TextMode="Password" CssClass="LoginFont"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword"
                                                                    SetFocusOnError="True" ErrorMessage="*" CssClass="LoginFont"></asp:RequiredFieldValidator></div>
                <div class="login_button"><asp:Button ID="btnLogin" OnClick="btnLogin_Click" runat="server" Text="Login" Font-Size="110%" >
                                                                </asp:Button></div>
                
                <asp:Label ID="txtLoginMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>
        
        </div>
    </div>
    
      
</form>
</body>
</html>
