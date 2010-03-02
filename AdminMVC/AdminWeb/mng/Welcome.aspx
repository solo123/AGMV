<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Welcome" Title="Untitled Page" Codebehind="Welcome.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="myBookmark">
    <h2>參考網站:</h2>
    <asp:Repeater ID="lstBookmark" runat="server" DataSourceID="BookmarkDataset">
        <ItemTemplate>
            <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank"
                Text='<%# Eval("title") %>' 
                NavigateUrl='<%# Eval("url", "http://{0}") %>' />
        </ItemTemplate>
    </asp:Repeater> 
    <asp:ObjectDataSource ID="BookmarkDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetBookmark" TypeName="com.Omei.BLL.Admin.BookmarkBiz">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="status" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div style="clear:both;" ></div>
</div>
<div>
    <asp:Repeater ID="lstNews" runat="server" DataSourceID="NewsDataset">
        <ItemTemplate>
            <div class="news_block">
            <asp:Label ID="Label1" runat="server" CssClass="head02" Text='<%# Eval("title") %>' />
            <div class="grayText">
            (<asp:Label ID="Label3" runat="server" Text='<%# Eval("lastupdate","{0:d}") %>' /> by 
            <asp:Label ID="Label4" runat="server" Text='<%# Eval("nickname") %>' />)
            </div>
            <asp:Label ID="Label2" runat="server" Text='<%# Eval("description") %>' />
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:ObjectDataSource ID="NewsDataset" runat="server" 
        SelectMethod="GetData"
        TypeName="com.Omei.DLL.DS_WhatsNewTableAdapters.WhatsNewListTableAdapter" 
        OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>
    
</div>


</asp:Content>

