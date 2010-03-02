<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_CreditCardInfoCtl" Codebehind="CreditCardInfoCtl.ascx.cs" %>
    
<asp:ObjectDataSource ID="CCDetailDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetCreditDetail" TypeName="com.Omei.BLL.Admin.CreditCardBiz" >
    <SelectParameters>
        <asp:Parameter Name="crId" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:FormView ID="fvCCDetail" runat="server" DataKeyNames="crId" DataSourceID="CCDetailDataset">
    <ItemTemplate>
        <asp:Panel ID="panelPayment" runat="server" CssClass='<%# Eval("status", "statusDiv_{0}") %>'>
            <table cellpadding="2" cellspacing="0" class="detail_view" width="100%">
                <tr>
                    <td colspan="2" class=prompt>
                        Status:<asp:Label ID="statusLabel" CssClas=data runat="server" Text='<%# Eval("status") %>'></asp:Label>
                        Credit ID:<asp:Label ID="crIdLabel" CssClass=data runat="server" Text='<%# Eval("crId") %>'></asp:Label>
                        Payment ID:<asp:Label ID="paymentIdLabel" CssClass=data runat="server" Text='<%# Eval("paymentId") %>'></asp:Label>)
                    </td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap" width="100">
                        Customer ID:</td>
                    <td class="content" width="90%">
                        <asp:Label ID="customerIdLabel" runat="server" Text='<%# Eval("customerId") %>' CssClass="data"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Name:</td>
                    <td class="content">
                        <asp:Label ID="firstNameLabel" runat="server" Text='<%# Eval("firstName") %>'></asp:Label>.<asp:Label
                            ID="lastNameLabel" runat="server" Text='<%# Eval("lastName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Address:</td>
                    <td class="content">
                        <asp:Label ID="addressLabel" runat="server" Text='<%# Eval("address") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        City:</td>
                    <td class="content">
                        <asp:Label ID="cityLabel" runat="server" Text='<%# Eval("city") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        State:</td>
                    <td class="content">
                        <asp:Label ID="stateLabel" runat="server" Text='<%# Eval("state") %>'></asp:Label>&nbsp;
                        ZIP:<asp:Label ID="zipLabel" runat="server" Text='<%# Eval("zip") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Country:</td>
                    <td class="content">
                        <asp:Label ID="countryLabel" runat="server" Text='<%# Eval("country") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                    </td>
                    <td class="content">
                    </td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Order date:</td>
                    <td class="content">
                        <asp:Label ID="orderDateLabel" runat="server" Text='<%# Eval("orderDate") %>' CssClass="data"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Pay date:</td>
                    <td class="content">
                        <asp:Label ID="payDateLabel" runat="server" Text='<%# Eval("payDate") %>' CssClass="data"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                    </td>
                    <td class="content">
                    </td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        <asp:Label ID="cardTypeLabel" runat="server" Text='<%# Eval("cardType") %>' CssClass="data"></asp:Label>:</td>
                    <td class="content">
                        <asp:Label ID="cardNumberLabel" runat="server" Text='<%# Eval("cardNumber") %>' CssClass="data"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Valid date:</td>
                    <td class="content">
                        <asp:Label ID="validDateLabel" runat="server" Text='<%# Eval("validDate") %>' CssClass="data"></asp:Label>&nbsp;
                        CSC:<asp:Label ID="cscLabel" runat="server" Text='<%# Eval("csc") %>' CssClass="data"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Amount:</td>
                    <td class="content">
                        <asp:Label ID="amountLabel" runat="server" Text='<%# Eval("amount") %>' CssClass="data"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Service fee:</td>
                    <td class="content">
                        <asp:Label ID="serviceFeeLabel" runat="server" Text='<%# Eval("serviceFee") %>' CssClass="data"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Total amount:</td>
                    <td class="content">
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("totalAmount") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap" width="100">
                        Actual amount:</td>
                    <td class="content" width="90%">
                        <asp:Label ID="TextBox1" runat="server" Text='<%# Eval("totalAmount") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        ProfCode:</td>
                    <td class="content">
                        <asp:Label ID="txtApprovCode" runat="server" Text='<%# Eval("profCode") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Remark:</td>
                    <td class="content">
                        <asp:Label ID="txtRemark" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </ItemTemplate>
</asp:FormView>
