<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_CommissionList" Title="歐美旅遊-傭金管理" Codebehind="CommissionList.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    <ul>
        <li><asp:LinkButton ID="btnAdd" runat="server" OnClick="btnAdd_Click">Add New</asp:LinkButton></li></ul>
    <div style="clear:both"></div>
</div>    
    
<div class="contentbox">

    <asp:GridView ID="lstCommission" runat="server" AutoGenerateColumns="False" DataKeyNames="id"
        DataSourceID="CommissionDataset" SkinID="DataList" OnRowUpdating="lstCommission_RowUpdating">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="amountFrom" HeaderText="Amount From" SortExpression="amountFrom" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="amountTo" HeaderText="Amount To" SortExpression="amountTo" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="commissionRate" HeaderText="Commission Rate" SortExpression="commissionRate" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="createDate" HeaderText="Create Date" SortExpression="createDate" ReadOnly="True" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="lastUpdate" HeaderText="Last Updated" SortExpression="lastUpdate" ReadOnly="True" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
            <asp:BoundField DataField="employee" HeaderText="Employee" SortExpression="employee" ReadOnly="True" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
        <EmptyDataTemplate>
         <hr />
            尚未配置Commission Rate，請點擊“Add New”按鈕進行配置。
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:ObjectDataSource ID="CommissionDataset" runat="server" SelectMethod="GetCommissionConfig"
        TypeName="com.Omei.BLL.Admin.CommissionBiz" OldValuesParameterFormatString="original_{0}" UpdateMethod="UpdateCommission" DeleteMethod="DeleteCommission">
    <UpdateParameters>
        <asp:Parameter Name="original_id" Type="Int32" />
        <asp:Parameter Name="amountFrom" Type="Decimal" />
        <asp:Parameter Name="amountTo" Type="Decimal" />
        <asp:Parameter Name="commissionRate" Type="Decimal" />
        <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull="false" />
        <asp:Parameter Name="ui" Type="Object" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="original_id" Type="Int32" />
    </DeleteParameters>
</asp:ObjectDataSource>   
</div>
</asp:Content>

