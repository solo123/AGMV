<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_PaymentListCtl" Codebehind="PaymentListCtl.ascx.cs" %>

<asp:ObjectDataSource ID="PaymentListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetPaymentList" TypeName="com.Omei.BLL.Admin.AdminPaymentBiz" >
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="orderId" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:GridView ID="lstPayment" runat="server" AutoGenerateColumns="False" DataKeyNames="paymentId"
    DataSourceID="PaymentListDataset" CellPadding="2" SkinID="NormalDataList" Width="100%">
    <Columns>
        <asp:TemplateField HeaderText="Date" SortExpression="payDate">
            <ItemStyle Wrap="False" />
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("payDate") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="opEmpName" HeaderText="Operator" ReadOnly="True" SortExpression="employeeName">
            <ItemStyle Wrap="False" />
        </asp:BoundField>
        <asp:BoundField DataField="employeeName" HeaderText="Pay for" ReadOnly="True" SortExpression="employeeName">
            <ItemStyle Wrap="False" />
        </asp:BoundField>
        <asp:BoundField DataField="amount" HeaderText="Pay" SortExpression="amount">
            <ItemStyle HorizontalAlign="Right" Wrap="False" />
        </asp:BoundField>
        <asp:BoundField DataField="afterPay" HeaderText="total paid" SortExpression="afterPay">
            <ItemStyle HorizontalAlign="Right" Wrap="False" />
            <HeaderStyle Wrap="False" />
        </asp:BoundField>
        <asp:TemplateField HeaderText="Method" SortExpression="method" >
            <ItemStyle HorizontalAlign="Center" Wrap="False" />
            <ItemTemplate>
                <asp:Literal ID="Label2" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("PaymentMethod",Eval("method"),"en") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="remark" HeaderText="Remark" SortExpression="remark" HtmlEncode="False">
            <ItemStyle HorizontalAlign="Left" Wrap="False" />
        </asp:BoundField>
    </Columns>
</asp:GridView>