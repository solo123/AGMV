<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_RoleList" Title="Untitled Page" Codebehind="RoleList.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table style="width: 100%">
        <tr>
            <td><asp:Button ID="bntAdd" runat="server" Text="新增" />&nbsp;&nbsp;
            
                <asp:Panel ID="panelEdit" runat="server" Visible="false">
                (ID:<asp:Label ID="txtRoleId" runat="server"></asp:Label>)
                角色名:<asp:TextBox ID="txtRole" runat="server"></asp:TextBox>
                <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="btnSave_Click" />
                <asp:Button ID="btnDelete" runat="server" Text="刪除" OnClick="btnDelete_Click" />
                    <asp:Label ID="txtMessage" runat="server"></asp:Label></asp:Panel>
                </td>
        </tr>
    </table>
    <br />

    <asp:ObjectDataSource ID="RolesDataset" runat="server" SelectMethod="GetRoles" TypeName="com.Omei.BLL.Authenticate.UserBiz" OldValuesParameterFormatString="original_{0}">
    </asp:ObjectDataSource>
    <asp:GridView ID="lstRoles" runat="server" AutoGenerateColumns="False" DataKeyNames="roleId" SkinID="DataList" Width="100%" PageSize="20" OnRowDataBound="lstRoles_RowDataBound" DataSourceID="RolesDataset">
        <Columns>
            <asp:BoundField DataField="roleId" HeaderText="roleId" ReadOnly="True" SortExpression="roleId" />
            <asp:BoundField DataField="roleName" HeaderText="roleName" SortExpression="roleName" />
        </Columns>
    </asp:GridView>
    
</asp:Content>

