<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Bookmark" Title="Untitled Page" Codebehind="Bookmark.aspx.cs" %>

<%@ Register Src="../Controls/TypeSelectorCtl.ascx" TagName="TypeSelectorCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
    <asp:GridView ID="lstBookmark" runat="server" DataSourceID="BookmarkDataset" AutoGenerateColumns="False" 
    AutoGenerateEditButton="True" DataKeyNames="bookmarkID" SkinID="DataList">
        <Columns>
            <asp:BoundField DataField="bookmarkID" HeaderText="ID" SortExpression="bookmarkID" ReadOnly="true" />
            <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
            <asp:BoundField DataField="url" HeaderText="Url" SortExpression="url" />
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <EditItemTemplate>
                    <uc1:TypeSelectorCtl ID="TypeSelectorCtl1" runat="server" TypeName="bookmarkStatus" SelectedValue='<%# Bind("status") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("bookmarkStatus",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            請添加常用鏈接。
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:ObjectDataSource ID="BookmarkDataset" runat="server" 
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetBookmark" TypeName="com.Omei.BLL.Admin.BookmarkBiz" 
        UpdateMethod="UpdateBookmark"
        InsertMethod="AddBookmark">
        <UpdateParameters>
            <asp:Parameter Name="original_bookmarkID" Type="Int32" />
            <asp:Parameter Name="title" Type="String" />
            <asp:Parameter Name="url" Type="String" />
            <asp:Parameter Name="status" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="status" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    

</asp:Content>

