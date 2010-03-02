<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="OrderRecvAgent" Title="Untitled Page" Codebehind="OrderRecvAgent.aspx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc2" %>
<%@ Register Src="../WebParts/OrderInfoCtl.ascx" TagName="OrderInfoCtl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:OrderInfoCtl ID="OrderInfoCtl1" runat="server" />
    
    <hr />
    
    Change Agent Receive:
    <uc2:DataSelector ID="seleAgent" runat="server" DataSourceID="CompanyDataset"
        DataTextField="companyName" DataValueField="companyId" DefaultValue="0" NoSelectPrompt="--無代理--" />
    <asp:Button ID="btnChange" runat="server" Text="Change Agent" OnClick="btnChange_Click" />
    
    <p>
        <asp:Label ID="lbMsg" runat="server" CssClass="error_message" />
    </p>


    <asp:ObjectDataSource ID="CompanyDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCompanyNameList" TypeName="com.Omei.DLL.DS_CompanysTableAdapters.CompanyNameListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="companyType" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

