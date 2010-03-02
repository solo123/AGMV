<%@ Page Language="C#" MasterPageFile="../public/AdminContent.master" AutoEventWireup="true" Inherits="MenuEdit" Title="Untitled Page" Codebehind="MenuEdit.aspx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc3" %>
<%@ Register Src="../AuthorizationCtl/ActionEditCtl.ascx" TagName="ActionEditCtl" TagPrefix="uc2" %>
<%@ Register Src="../AuthorizationCtl/MenuItemEditCtl.ascx" TagName="MenuItemEditCtl" TagPrefix="uc1" %>
<%@ MasterType virtualpath="~/AdminWeb/public/AdminContent.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="100%" height="400" class="ContentBox">
    <tr>
        <td width="50%" valign=top><div style="overflow-y:scroll; overflow-x:auto; height:400px; ">
                   
<asp:TreeView ID="tvMenu" runat="server" ShowLines="True" 
    OnSelectedNodeChanged="tvMenu_SelectedNodeChanged" ExpandDepth="2" >
</asp:TreeView>
</div>
        </td>
        <td width="50%" valign=top><div style="overflow:auto; ">
    <uc1:MenuItemEditCtl ID="MenuItemEditCtl1" runat="server" Visible=false OnChanged="OnChanged" />
    <uc2:ActionEditCtl ID="ActionEditCtl1" runat="server" Visible=false OnChanged="OnChanged" />
</div>
        </td>
    </tr>
</table>
<table width="100%">
    <tr>
        <td align="right">
            <asp:LinkButton ID="btnReload" runat="server" Text="Reload Sitemap" OnClick="btnReload_Click" /></td>
    </tr></table>

</asp:Content>

