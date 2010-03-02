<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Drivers" Title="司机维护" Codebehind="Drivers.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp;<asp:ObjectDataSource ID="DriverDataset" runat="server" InsertMethod="InsertQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="com.Omei.DLL.DS_UserInfoTableAdapters.DriversTableAdapter"
        UpdateMethod="UpdateQuery" >
        <UpdateParameters>
            <asp:Parameter Name="firstName" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="homePhone" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="cellPhone" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="walkyPhone" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="original_userId" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:LinkButton ID="btnNewDriver" runat="server" OnClick="btnNewDriver_Click">New driver</asp:LinkButton>
    <asp:GridView ID="lstDriver" runat="server" AutoGenerateColumns="False" DataKeyNames="userId"
        DataSourceID="DriverDataset" AllowSorting="True" SkinID="NormalDataList" Width="100%" OnRowCommand="lstDriver_RowCommand">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="DelDriver"
                        Text="删除" OnClientClick="javascript:return confirm('您确认要删除此司机吗?');" 
                        CommandArgument='<%# Eval("userId") %>' ></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True" >
                <ItemStyle Wrap="False" />
            </asp:CommandField>
            <asp:BoundField DataField="userId" HeaderText="userId" InsertVisible="False" ReadOnly="True"
                SortExpression="userId" />
            <asp:BoundField DataField="firstName" HeaderText="firstName" SortExpression="firstName" ConvertEmptyStringToNull="False" />
            <asp:BoundField DataField="homePhone" HeaderText="homePhone" SortExpression="homePhone" ConvertEmptyStringToNull="False" />
            <asp:BoundField DataField="cellPhone" HeaderText="cellPhone" SortExpression="cellPhone" ConvertEmptyStringToNull="False" />
            <asp:BoundField DataField="walkyPhone" HeaderText="walkyPhone" SortExpression="walkyPhone" ConvertEmptyStringToNull="False" />
        </Columns>
    </asp:GridView>



</asp:Content>

