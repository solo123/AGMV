<%@ Page Language="C#" AutoEventWireup="true" Inherits="ApplicationError" Codebehind="ApplicationError.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>歐美旅遊-應用程序錯誤</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><br /><br />
        <table style="width: 400px" border="5" align="center">
            <tr>
                <td style="height: 169px">
                    <table style="width: 100%" cellpadding="4" cellspacing="2">
                        <tr>
                            <td width="110" style="height: 148px">
                                <img hspace="10" src="Images/master/error.gif" vspace="10" /></td>
                            <td valign="top" style="height: 148px">
                                <span class="head01">
                                    <br />
                                    對不起，</span>您訪問的網頁産生暸一個錯誤。此錯誤已經被記錄並發送給繫統管理員<a href="mailto:jimmy@omeitravel.com">jimmy@omeitravel.com</a>，我們將盡快改正。<br />
                                <br />
                                出錯頁面:<asp:Label ID="txtErrorPage" runat="server"></asp:Label><br />
                                <br />
                                <asp:Label ID="txtErrorMessage" runat="server" ForeColor="Red"></asp:Label><br />
                                <br />
                                
                                <input id="btnBack" type="button" value="返囬" onclick="location='default.aspx'" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
