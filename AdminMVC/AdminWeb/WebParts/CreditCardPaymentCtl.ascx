<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_CreditCardPaymentCtl" Codebehind="CreditCardPaymentCtl.ascx.cs" %>
<asp:FormView ID="fvCreditCard" runat="server" DataKeyNames="crId" DataSourceID="CreditCardDataset">
    <EditItemTemplate>
    <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
            Text="Update"></asp:LinkButton></li>
                <li><asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
            Text="Cancel"></asp:LinkButton></li>
            </ul>
        <div style="clear:both"></div></div>
        
        ID:
        <asp:Label ID="crIdLabel1" runat="server" Text='<%# Eval("crId") %>'></asp:Label>
        Status:<asp:Label ID="lbStatus" runat="server" Text='<%# Eval("status") %>'></asp:Label>
        <br />
        Customer ID:<asp:HyperLink ID="lnkCustomer" runat="server" Text='<%# Eval("customerId") %>'></asp:HyperLink> &nbsp;
        Order ID:<asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("orderId") %>'></asp:HyperLink> &nbsp;
        Payment ID:<asp:Label ID="Label1" runat="server" Text='<%# Eval("paymentId") %>'></asp:Label> &nbsp;
        <asp:Label ID="Label2" runat="server" Text="(Web Order)" Visible='<%# Eval("IsWebOrder") %>'></asp:Label>
        <br />
        <table>
            <tr>
                <td colspan=2>Customer Information (required)</td>
            </tr>
            <tr>
                <td nowrap>Customer name:</td>
                <td nowrap>
                    first name:
        <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'></asp:TextBox>
                    last name:
        <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Address:</td>
                <td>
        <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' Width="90%"></asp:TextBox><br />
                    City:<asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' Width="60px"></asp:TextBox>
                    State:<asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' Width="60px"></asp:TextBox>
                    ZIP:<asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>' Width="60px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Country:</td>
                <td>
        <asp:TextBox ID="countryTextBox" runat="server" Text='<%# Bind("country") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2">
                    Credit Card Information (required)</td>
            </tr>
            <tr>
                <td>
                    Card Type:</td>
                <td>
        <asp:TextBox ID="cardTypeTextBox" runat="server" Text='<%# Bind("cardType") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Card Number:</td>
                <td>
        <asp:TextBox ID="cardNumberTextBox" runat="server" Text='<%# Bind("cardNumber") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    CSC:</td>
                <td>
        <asp:TextBox ID="cscTextBox" runat="server" Text='<%# Bind("csc") %>' Width="60px"></asp:TextBox>&nbsp;
                    Expiry Date:<asp:TextBox ID="validDateTextBox" runat="server" Text='<%# Bind("validDate") %>' Width="60px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2">
                    Payment Details (required)</td>
            </tr>
            <tr>
                <td>
                    Amount:</td>
                <td>
        <asp:TextBox ID="amountTextBox" runat="server" Text='<%# Bind("amount") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Service fee:</td>
                <td>
        <asp:TextBox ID="serviceFeeTextBox" runat="server" Text='<%# Bind("serviceFee") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Total Amount:</td>
                <td>
        <asp:TextBox ID="totalAmountTextBox" runat="server" Text='<%# Bind("totalAmount") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2">
                    Other Information:</td>
            </tr>
            <tr>
                <td>
                    Order Date:</td>
                <td>
        <asp:Label ID="orderDateTextBox" runat="server" Text='<%# Eval("orderDate") %>'/></td>
            </tr>
            <tr>
                <td>
                    Paid Date:</td>
                <td>
        <asp:Label ID="payDateTextBox" runat="server" Text='<%# Eval("payDate") %>'/></td>
            </tr>
            <tr>
                <td>
                    Prof Code:</td>
                <td>
        <asp:TextBox ID="profCodeTextBox" runat="server" Text='<%# Bind("profCode") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Notes:</td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" Rows="5" TextMode="MultiLine" Width="90%" Text='<%# Bind("notes") %>'></asp:TextBox></td>
            </tr>
        </table>
        
        <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
            Text="Update"></asp:LinkButton></li>
                <li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
            Text="Cancel"></asp:LinkButton></li>
            </ul>
        <div style="clear:both"></div></div>
    </EditItemTemplate>
    <ItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li>
                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton></li>
                <li>
                    <asp:LinkButton ID="btnPay" runat="server" >Pay NOW!</asp:LinkButton></li>
            </ul>
        <div style="clear:both"></div></div>

ID:
        <asp:Label ID="crIdLabel1" runat="server" Text='<%# Eval("crId") %>'></asp:Label>
        Status:<asp:Label ID="lbStatus" runat="server" Text='<%# Eval("status") %>'></asp:Label>
        <br />
        Customer ID:<asp:HyperLink ID="lnkCustomer" runat="server" Text='<%# Eval("customerId") %>'></asp:HyperLink> &nbsp;
        Order ID:<asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("orderId") %>'></asp:HyperLink> &nbsp;
        Payment ID:<asp:Label ID="Label1" runat="server" Text='<%# Eval("paymentId") %>'></asp:Label> &nbsp;
        <asp:Label ID="Label2" runat="server" Text="(Web Order)" Visible='<%# Eval("IsWebOrder") %>'></asp:Label>
        <br />
        <table>
            <tr>
                <td colspan=2>Customer Information (required)</td>
            </tr>
            <tr>
                <td nowrap>Customer name:</td>
                <td nowrap>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("firstName") %>'></asp:Label>.
                    <asp:Label ID="Label4"
                        runat="server" Text='<%# Eval("lastName") %>'></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Address:</td>
                <td>
                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("address") %>'></asp:Label><br />
                    City:<asp:Label ID="cityTextBox" runat="server" Text='<%# Eval("city") %>' />
                    State:<asp:Label ID="stateTextBox" runat="server" Text='<%# Eval("state") %>' />
                    ZIP:<asp:Label ID="zipTextBox" runat="server" Text='<%# Eval("zip") %>' /></td>
            </tr>
            <tr>
                <td>
                    Country:</td>
                <td>
        <asp:Label ID="countryTextBox" runat="server" Text='<%# Eval("country") %>'/></td>
            </tr>
            <tr>
                <td colspan="2">
                    Credit Card Information (required)</td>
            </tr>
            <tr>
                <td>
                    Card Type:</td>
                <td>
        <asp:Label ID="cardTypeTextBox" runat="server" Text='<%# Eval("cardType") %>'/></td>
            </tr>
            <tr>
                <td>
                    Card Number:</td>
                <td>
        <asp:Label ID="cardNumberTextBox" runat="server" Text='<%# Eval("cardNumber") %>'/></td>
            </tr>
            <tr>
                <td>
                    CSC:</td>
                <td>
        <asp:Label ID="cscTextBox" runat="server" Text='<%# Eval("csc") %>' />&nbsp;
                    Expiry Date:<asp:Label ID="validDateTextBox" runat="server" Text='<%# Eval("validDate") %>' /></td>
            </tr>
            <tr>
                <td colspan="2">
                    Payment Details (required)</td>
            </tr>
            <tr>
                <td>
                    Amount:</td>
                <td>
        <asp:Label ID="amountTextBox" runat="server" Text='<%# Eval("amount") %>'/></td>
            </tr>
            <tr>
                <td>
                    Service fee:</td>
                <td>
        <asp:Label ID="serviceFeeTextBox" runat="server" Text='<%# Eval("serviceFee") %>'/></td>
            </tr>
            <tr>
                <td>
                    Total Amount:</td>
                <td>
        <asp:Label ID="totalAmountTextBox" runat="server" Text='<%# Eval("totalAmount") %>'/></td>
            </tr>
            <tr>
                <td colspan="2">
                    Other Information:</td>
            </tr>
            <tr>
                <td>
                    Order Date:</td>
                <td>
        <asp:Label ID="orderDateTextBox" runat="server" Text='<%# Eval("orderDate") %>'/></td>
            </tr>
            <tr>
                <td>
                    Paid Date:</td>
                <td>
        <asp:Label ID="payDateTextBox" runat="server" Text='<%# Eval("payDate") %>'/></td>
            </tr>
            <tr>
                <td>
                    Prof Code:</td>
                <td>
        <asp:Label ID="profCodeTextBox" runat="server" Text='<%# Eval("profCode") %>'/></td>
            </tr>
            <tr>
                <td>
                    Notes:</td>
                <td>
                    <asp:Label ID="TextBox1" runat="server" Text='<%# Eval("notes") %>' /></td>
            </tr>
        </table>
    </ItemTemplate>
</asp:FormView>
<asp:ObjectDataSource ID="CreditCardDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetCreditDetail" TypeName="com.Omei.BLL.Admin.CreditCardBiz">
    <SelectParameters>
        <asp:Parameter Name="crId" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
