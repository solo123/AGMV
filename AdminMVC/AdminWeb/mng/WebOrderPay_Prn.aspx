<%@ Page Language="C#" MasterPageFile="~/PrintMaster.master" AutoEventWireup="true" Inherits="WebOrderPay_Prn" Title="Untitled Page" Theme="themePrint"
     Codebehind="WebOrderPay_Prn.aspx.cs" %>

<%@ Register Src="../WebParts/OrderInfoCtl.ascx" TagName="OrderInfoCtl" TagPrefix="uc1" %>
<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc2" %>
<script type="text/C#" runat=server>
    int GetScheduleId(object orderId)
    {
        com.Omei.BLL.Admin.AdminOrderBiz biz = new com.Omei.BLL.Admin.AdminOrderBiz();
        int sid = biz.GetOrderScheduleId((int)orderId);
        return sid;
    }
    bool CanDoPayment(object status)
    {
        return (Convert.ToInt32(status) < 3);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ObjectDataSource ID="CCDetailDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCreditDetail" TypeName="com.Omei.BLL.Admin.CreditCardBiz" UpdateMethod="CreditCardPayment"
        OnUpdated="CCDetailDataset_Updated">
        <SelectParameters>
            <asp:QueryStringParameter Name="crId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="loginUserInfo" SessionField="LoginUserInfo" Type="Object" />
            <asp:Parameter Name="original_crId" Type="Int32" />
            <asp:Parameter Name="orderId" Type="Int32" />
            <asp:Parameter Name="totalAmount" Type="Decimal" />
            <asp:Parameter Name="profCode" Type="String" />
            <asp:Parameter Name="remark" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    
    
        <asp:FormView ID="fvCCDetail" runat="server" DataKeyNames="crId" DataSourceID="CCDetailDataset"
            DefaultMode="Edit">
            <EditItemTemplate>
                <div class=GenericContent>
                    <table cellpadding="6" cellspacing="0" width="100%" border="1" style="border-collapse:collapse;">
                        <tr>
                            <td align="center" nowrap="nowrap">
                                訂單號:<br />
                                <asp:Label ID="lbOrderId" runat="server" Font-Bold="True" Text='<%# Bind("orderId") %>'
                                    Font-Size="14pt"></asp:Label></td>
                            <td width="100%">
                                <uc2:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" ScheduleId='<%# GetScheduleId(Eval("orderId")) %>' />
                            </td>
                        </tr>
                    </table>
                </div>
                
                <div class=GenericContent>
                    <uc1:OrderInfoCtl ID="OrderInfoCtl1" OrderId='<%# Eval("orderId") %>' runat="server" />
                </div>
                
                <div class=GenericContent>
                    <asp:Panel ID="panelPayment" runat="server" CssClass='<%# Eval("status", "statusDiv_{0}") %>'>
                        <asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>'></asp:Label>
                        &nbsp;(<asp:Label ID="crIdLabel" runat="server" Text='<%# Eval("crId") %>'></asp:Label>&nbsp;-
                        <asp:Label ID="paymentIdLabel" runat="server" Text='<%# Eval("paymentId") %>'></asp:Label>)<br />
                        <table cellpadding="2" cellspacing="0" class="detail_view" width="100%">
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
                                <td class="prompt">
                                    ProfCode:
                                </td>
                                <td class="content">
                                    <asp:Label ID="lbProfCode" runat="server" Text='<%# Eval("profCode") %>' />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </EditItemTemplate>
        </asp:FormView>
        <asp:Label ID="lbMsg" runat="server" ForeColor="Red"></asp:Label><br />
</asp:Content>

