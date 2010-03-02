<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="CreditVouchers" Title="Untitled Page" Codebehind="CreditVouchers.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <asp:GridView ID="lstVoucher" runat="server" DataSourceID="voucherDataset" SkinID="NormalDataList">
    </asp:GridView>
    <asp:ObjectDataSource ID="voucherDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetVoucherList" TypeName="com.Omei.BLL.Admin.VoucherBiz"></asp:ObjectDataSource>



</asp:Content>

