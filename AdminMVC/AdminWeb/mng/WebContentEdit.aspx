<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="WebContentEdit" Title="Untitled Page" Codebehind="WebContentEdit.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:FormView ID="fvContent" runat="server" DataSourceID="ContentDataset">
    </asp:FormView>
    <asp:ObjectDataSource ID="ContentDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetContentDetail" TypeName="com.Omei.BLL.Admin.WebContentBiz" UpdateMethod="UpdateContent">
        <UpdateParameters>
            <asp:Parameter Name="loginUserAccount" Type="Object" />
            <asp:Parameter Name="original_contentID" Type="Int32" />
            <asp:Parameter Name="contentKey" Type="String" />
            <asp:Parameter Name="contentDetail" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:Parameter Name="contentID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
</asp:Content>

