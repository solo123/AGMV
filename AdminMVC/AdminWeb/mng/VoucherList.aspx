<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="VoucherList" Title="Untitled Page" Codebehind="VoucherList.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="lstVoucher" runat="server" AutoGenerateColumns="False" DataSourceID="VoucherDataset" AllowSorting="true" SkinID="NormalDataList" Width="100%">
        <Columns>
            <asp:BoundField HeaderText="V#" DataField="voucherID" SortExpression="voucherID" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Order#" SortExpression="refundOrder">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkrefundOrder" runat="server" Text='<%# Eval("refundOrder") %>' NavigateUrl='<%# Eval("refundOrder","OrderDetail.aspx?id={0}") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="Pre V#" DataField="preVoucherID" SortExpression="preVoucherID" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Amount" DataField="amount" SortExpression="amount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Expire Date" DataField="expireDate" DataFormatString="{0:d}" HtmlEncode="False" SortExpression="expireDate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Paid" DataField="payAmount" SortExpression="payAmount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Paid Order" SortExpression="payOrder">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkrefundOrder" runat="server" Text='<%# Eval("payOrder") %>' NavigateUrl='<%# Eval("payOrder","OrderDetail.aspx?id={0}") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="Paid Date" DataField="payDate" DataFormatString="{0:d}" HtmlEncode="False" SortExpression="payDate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("VoucherStatus", Eval("Status"), "en") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="VoucherDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetVoucherList" TypeName="com.Omei.BLL.Admin.VoucherBiz"></asp:ObjectDataSource>
    
</asp:Content>

