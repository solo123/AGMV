<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="EmployeeRoleEdit" Title="Untitled Page" Codebehind="EmployeeRoleEdit.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <b>Employee:<asp:Label ID="lbEmployeeName" runat="server"></asp:Label></b><br />
    <table width="100%" cellpadding=4>
        <tr>
            <td width="50%" valign=top><h1>Roles</h1>
    <asp:GridView ID="lstRoles" runat="server" AutoGenerateColumns="False" DataKeyNames="tid" DataSourceID="RoleDataset" Width="300px" OnRowDataBound="lstRoles_RowDataBound" ShowHeader="False">
        <Columns>
            <asp:TemplateField HeaderText="权限" SortExpression="listTitle">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Bind("listTitle") %>' />
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("listValue") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    
    <asp:Button ID="btnSaveRole" runat="server" Text="Save" OnClick="btnSaveRole_Click" Enabled='<%# PageLogic.CheckActionAuth("auth_EmployeeChgRole") %>' />
            </td>
            <td width="50%" valign=top><h1>Positions</h1>
    <asp:GridView ID="lstPositions" runat="server" AutoGenerateColumns="False" DataKeyNames="tid" DataSourceID="PostionDataset" Width="300px" OnRowDataBound="lstPositions_RowDataBound" ShowHeader="False">
        <Columns>
            <asp:TemplateField HeaderText="权限" SortExpression="listTitle">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Bind("listTitle") %>' />
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("listValue") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Button ID="btnSavePos" runat="server" Text="Save" OnClick="btnSavePos_Click" Enabled='<%# PageLogic.CheckActionAuth("auth_EmployeeChgPos") %>' /></td>
        </tr>
    </table>
    
    <asp:ObjectDataSource ID="RoleDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="Role" Name="listClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
<asp:ObjectDataSource ID="PostionDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="Position" Name="listClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

