<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="EmployeeRoles" Title="Untitled Page" Codebehind="EmployeeRoles.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:GridView ID="lstEmployee" runat="server" AutoGenerateColumns="False" DataKeyNames="employeeID" DataSourceID="EmployeeNameDataset" OnRowDataBound="lstEmployee_RowDataBound" SkinID="DataList" Width="100%">
        <Columns>
            <asp:BoundField DataField="employeeID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="employeeID" />
            <asp:BoundField DataField="loginName" HeaderText="Login name" SortExpression="loginName" />
            <asp:BoundField DataField="userName" HeaderText="User name" ReadOnly="True" SortExpression="userName" />
            <asp:TemplateField HeaderText="Roles">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# ShowRoles(Eval("employeeID")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Positions">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# ShowPositions(Eval("employeeID")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="EmployeeNameDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetEmployeeNameList" TypeName="com.Omei.DLL.DS_EmployeeTableAdapters.EmployeeNameListTableAdapter">
    </asp:ObjectDataSource>

</asp:Content>

