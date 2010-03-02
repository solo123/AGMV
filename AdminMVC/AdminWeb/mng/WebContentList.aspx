<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="WebContentList" Title="Untitled Page" Codebehind="WebContentList.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Button ID="btnAdd" runat="server" Text="Add..." />
    <asp:GridView ID="lstContent" runat="server" DataSourceID="ContentDataset" SkinID="DataList" Width="100%" AutoGenerateColumns="False" OnRowDataBound="lstContent_RowDataBound">
        <Columns>
            <asp:BoundField DataField="contentID" HeaderText="ID" />
            <asp:BoundField DataField="contentKey" HeaderText="Key" />
            <asp:BoundField DataField="lastUpdate" HeaderText="Last update" />
            <asp:BoundField DataField="employeeName" HeaderText="Employee" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ContentDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetContentList" TypeName="com.Omei.BLL.Admin.WebContentBiz"></asp:ObjectDataSource>


</asp:Content>

