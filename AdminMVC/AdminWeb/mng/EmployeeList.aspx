<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="EmployeeList" Title="歐美旅遊-用戶管理" Codebehind="EmployeeList.aspx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    <uc1:DataSelector ID="seleRole" runat="server" AutoPostBack="true" 
        DataSourceID="RoleDataset" DataTextField="listTitle" DataValueField="listValue" 
        DefaultValue="" NoSelectPrompt="All Roles" />
    <uc1:DataSelector ID="selePosition" runat="server" 
        AutoPostBack="true" DataSourceID="PositionDataset" DataTextField="listTitle" 
        DataValueField="listValue" DefaultValue=""
        NoSelectPrompt="All Position" />
    &nbsp;
    Status:
    <asp:DropDownList ID="seleStatus" runat="server" AutoPostBack="True">
        <asp:ListItem Value="3" >--All--</asp:ListItem>
        <asp:ListItem Value="1" Selected=true>Valid</asp:ListItem>
        <asp:ListItem Value="0">Invalid</asp:ListItem>
    </asp:DropDownList>
    &nbsp;
    <a href="AddEmployee.aspx" visible='<%# PageLogic.CheckActionAuth("auth_EmployeeNew") %>'>新增</a>

    <div style="clear:both"></div>
</div>
    
    <asp:ObjectDataSource ID="CompanyNameDataset" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCompanyNameList" TypeName="com.Omei.DLL.DS_CompanysTableAdapters.CompanyNameListTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="RoleDataset" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="Role" Name="listClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="PositionDataset" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="Position" Name="listClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:GridView ID="lstUser" runat="server" AutoGenerateColumns="False"
    SkinID="NormalDataList" Width="100%" PageSize="20" 
    DataSourceID="EmployeeDataset" 
    AllowSorting="True" OnRowDataBound="lstUser_RowDataBound">
        <Columns>
            <asp:BoundField DataField="employeeID" HeaderText="ID" ReadOnly="True" SortExpression="employeeID" />
            <asp:BoundField DataField="loginName" HeaderText="Login name" SortExpression="loginName" />
            <asp:BoundField DataField="userName" HeaderText="name" SortExpression="name" />
            <asp:BoundField DataField="homePhone" HeaderText="phone" SortExpression="phone" />
            <asp:BoundField DataField="cellPhone" HeaderText="cell" SortExpression="cell" />
            <asp:BoundField DataField="walkyPhone" HeaderText="pager" SortExpression="pager" />
            <asp:BoundField DataField="companyName_cn" HeaderText="Company" SortExpression="companyName_cn" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="EmployeeDataset" runat="server" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetEmployeeList" TypeName="com.Omei.BLL.Admin.EmployeeBiz" >
        <SelectParameters>
            <asp:ControlParameter ControlID="seleRole" Name="roleID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="selePosition" Name="positionID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="seleStatus" Name="status" PropertyName="SelectedValue"
                Type="Byte" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

