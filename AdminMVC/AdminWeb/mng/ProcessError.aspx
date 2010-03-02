<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminPopup.master" AutoEventWireup="true" Inherits="ProcessError" Title="Untitled Page" Codebehind="ProcessError.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div align=center>
<table width="70%">
    <tr>
        <td height=130>&nbsp;</td>
    </tr>
    <tr>
        <td><asp:Label ID="lbMsg" runat="server" CssClass="head01" ></asp:Label>
            <br />&nbsp;
        </td>
    </tr>
    <tr>
        <td><div class="toolbox listButtons"><ul><li><asp:HyperLink ID="lnkBack"
        runat="server">&lt;&lt;Go back</asp:HyperLink></li></ul><div style="clear:both"></div></div></td>
    </tr>
</table>
</div>

</asp:Content>

