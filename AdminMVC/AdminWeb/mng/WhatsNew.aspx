<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_WhatsNew" Title="歐美旅遊-最新消息" Codebehind="WhatsNew.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ObjectDataSource ID="WhatsNewDataset" runat="server" SelectMethod="GetData"
        TypeName="com.Omei.DLL.DS_WhatsNewTableAdapters.WhatsNewListTableAdapter" OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>
    
    <div class="toolbox listButtons">
        <ul>
            <li><a href="WhatsNewEdit.aspx?add=1" visible='<%# PageLogic.CheckActionAuth("auth_WhatsNewNew") %>' >New</a></li>
        </ul>
    <div style="clear:both"></div></div>
    
    <asp:GridView ID="lstWhatsNew" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        DataSourceID="WhatsNewDataset" DataKeyNames="newsId" Width="100%" SkinID="DataList" OnRowDataBound="lstWhatsNew_RowDataBound"
          >
        <Columns>
            <asp:BoundField DataField="newsId" HeaderText="ID" ReadOnly="True" SortExpression="newsId" />
            <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
            <asp:BoundField DataField="lastUpdate" HeaderText="Last update" SortExpression="lastUpdate" />
            <asp:BoundField DataField="nickname" HeaderText="modifyer" SortExpression="nickname" />
            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
        </Columns>
        <HeaderStyle Wrap="False" />
    </asp:GridView>
    
</asp:Content>

