<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="LookCard" Title="Untitled Page" Codebehind="LookCard.aspx.cs" %>

<%@ Register Src="../WebParts/OrderInfoCtl.ascx" TagName="OrderInfoCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:ObjectDataSource ID="CreditCardDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetCreditDetail" TypeName="com.Omei.BLL.Admin.CreditCardBiz" UpdateMethod="UpdateCreditDetail">
    <SelectParameters>
        <asp:QueryStringParameter Name="crId" QueryStringField="id" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="original_crId" Type="Int32" />
        <asp:Parameter Name="firstname" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="lastname" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="address" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="zip" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="cardType" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="cardNumber" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="csc" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="validDate" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="amount" Type="Decimal" />
        <asp:Parameter Name="serviceFee" Type="Decimal" />
        <asp:Parameter Name="totalAmount" Type="Decimal" />
        <asp:Parameter Name="profCode" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="notes" Type="String" ConvertEmptyStringToNull=false />
    </UpdateParameters>
</asp:ObjectDataSource>

<asp:FormView ID="fvCreditCard" runat="server" DataKeyNames="crId" DataSourceID="CreditCardDataset" Width="100%">
    <EditItemTemplate>
    <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
            Text="Update"></asp:LinkButton></li><li><asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
            Text="Cancel"></asp:LinkButton></li></ul><div style="clear:both"></div>
        </div>
        
        ID:
        <asp:Label ID="labelCrid" runat="server" Text='<%# Eval("crId") %>'></asp:Label>
        Status:<asp:Label ID="lbStatus" runat="server" Text='<%# Eval("status") %>'></asp:Label>
        <br />
        Customer ID:<asp:HyperLink ID="lnkCustomer" runat="server" Text='<%# Eval("customerId") %>'></asp:HyperLink> &nbsp;
        Order ID:<asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("orderId") %>'></asp:HyperLink> &nbsp;
        Payment ID:<asp:Label ID="Label1" runat="server" Text='<%# Eval("paymentId") %>'></asp:Label> &nbsp;
        <asp:Label ID="Label2" runat="server" Text="(Web Order)" Visible='<%# Eval("IsWebOrder") %>'></asp:Label>
        <br />
        <table class="detail_view" border="1" cellpadding="2" cellspacing="0">
            <tr>
                <td colspan=2 class="header">Customer Information (required)</td>
            </tr>
            <tr>
                <td nowrap class="prompt">Customer name:</td>
                <td nowrap class="content">
                    first name:
        <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'></asp:TextBox>
                    last name:
        <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="prompt">
                    Address:</td>
                <td class="content">
        <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' Width="90%"></asp:TextBox><br />
                    City:<asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' Width="60px"></asp:TextBox>
                    State:<asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' Width="60px"></asp:TextBox>
                    ZIP:<asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>' Width="60px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="prompt">
                    Country:</td>
                <td class="content">
        <asp:TextBox ID="countryTextBox" runat="server" Text='<%# Bind("country") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Credit Card Information (required)</td>
            </tr>
            <tr>
                <td class="prompt">
                    Card Type:</td>
                <td class="content">
        <asp:TextBox ID="cardTypeTextBox" runat="server" Text='<%# Bind("cardType") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td class="prompt">
                    Card Number:</td>
                <td class="content">
        <asp:TextBox ID="cardNumberTextBox" runat="server" Text='<%# Bind("cardNumber") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td class="prompt">
                    CSC:</td>
                <td class="content">
        <asp:TextBox ID="cscTextBox" runat="server" Text='<%# Bind("csc") %>' Width="60px"></asp:TextBox>&nbsp;
                    Expiry Date:<asp:TextBox ID="validDateTextBox" runat="server" Text='<%# Bind("validDate") %>' Width="60px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Payment Details (required)</td>
            </tr>
            <tr>
                <td class="prompt">
                    Amount:</td>
                <td class="content">
        <asp:TextBox ID="amountTextBox" runat="server" Text='<%# Bind("amount") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td class="prompt">
                    Service fee:</td>
                <td class="content">
        <asp:TextBox ID="serviceFeeTextBox" runat="server" Text='<%# Bind("serviceFee") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td class="prompt">
                    Total Amount:</td>
                <td class="content">
        <asp:TextBox ID="totalAmountTextBox" runat="server" Text='<%# Bind("totalAmount") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Other Information:</td>
            </tr>
            <tr>
                <td class="prompt">
                    Order Date:</td>
                <td class="content">
        <asp:Label ID="orderDateTextBox" runat="server" Text='<%# Eval("orderDate") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    Paid Date:</td>
                <td class="content">
        <asp:Label ID="payDateTextBox" runat="server" Text='<%# Eval("payDate") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    Prof Code:</td>
                <td class="content">
        <asp:TextBox ID="profCodeTextBox" runat="server" Text='<%# Bind("profCode") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td class="prompt">
                    Notes:</td>
                <td class="content">
                    <asp:TextBox ID="TextBox1" runat="server" Rows="5" TextMode="MultiLine" Width="90%" Text='<%# Bind("notes") %>'></asp:TextBox></td>
            </tr>
        </table>
        
        <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
            Text="Update"></asp:LinkButton></li><li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
            Text="Cancel"></asp:LinkButton></li></ul><div style="clear:both"></div>
        </div>
    </EditItemTemplate>
    <ItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li>
                    <asp:HyperLink ID="lbBack" runat="server" NavigateUrl='<%# Eval("orderID", "OrderDetail.aspx?id={0}") %>'>&lt;&lt;Back</asp:HyperLink></li><li>
                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton></li><li>
                    <asp:LinkButton ID="btnPay" runat="server" OnClientClick="javascript:return confirm('Are you Look Card successful?')" OnClick="btnPay_Click" >Done</asp:LinkButton></li><li>
                        <asp:Label ID="lbMsg" runat="server" Text="" ForeColor=darkgreen></asp:Label></li></ul>
        <div style="clear:both"></div></div>

ID:
        <asp:Label ID="lbCrid" runat="server" Text='<%# Eval("crId") %>'></asp:Label>
        Status:<asp:Label ID="lbStatus" runat="server" Text='<%# Eval("status") %>'></asp:Label>
        <br />
        Customer ID:<asp:HyperLink ID="lnkCustomer" runat="server" Text='<%# Eval("customerId") %>'></asp:HyperLink> 
        Order ID:<asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("orderId") %>'></asp:HyperLink> 
        Payment ID:<asp:Label ID="Label1" runat="server" Text='<%# Eval("paymentId") %>'></asp:Label> 
        <asp:Label ID="Label2" runat="server" Text="(Web Order)" Visible='<%# Eval("IsWebOrder") %>'></asp:Label>
        <br />
        <table class="detail_view">
            <tr>
                <td colspan=2 class="header">Customer Information</td>
            </tr>
            <tr>
                <td nowrap class="prompt">
                    Name:</td>
                <td nowrap class="content">
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("firstName") %>'></asp:Label>.
                    <asp:Label ID="Label4"
                        runat="server" Text='<%# Eval("lastName") %>'></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="prompt">
                    Address:</td>
                <td class="content">
                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("address") %>'></asp:Label><br />
                    City:<asp:Label ID="cityTextBox" runat="server" Text='<%# Eval("city") %>' />
                    State:<asp:Label ID="stateTextBox" runat="server" Text='<%# Eval("state") %>' />
                    ZIP:<asp:Label ID="zipTextBox" runat="server" Text='<%# Eval("zip") %>' /></td>
            </tr>
            <tr>
                <td class="prompt">
                    Country:</td>
                <td class="content">
        <asp:Label ID="countryTextBox" runat="server" Text='<%# Eval("country") %>'/></td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Credit Card Information</td>
            </tr>
            <tr>
                <td class="prompt">
                    Card Type:</td>
                <td class="content">
        <asp:Label ID="cardTypeTextBox" runat="server" Text='<%# Eval("cardType") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    Card Number:</td>
                <td class="content">
        <asp:Label ID="cardNumberTextBox" runat="server" Text='<%# Eval("cardNumber") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    CSC:</td>
                <td class="content">
        <asp:Label ID="cscTextBox" runat="server" Text='<%# Eval("csc") %>' />
                    Expiry Date:<asp:Label ID="validDateTextBox" runat="server" Text='<%# Eval("validDate") %>' /></td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Payment Details</td>
            </tr>
            <tr>
                <td class="prompt">
                    Amount:</td>
                <td class="content">
        <asp:Label ID="amountTextBox" runat="server" Text='<%# Eval("amount") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    Service fee:</td>
                <td class="content">
        <asp:Label ID="serviceFeeTextBox" runat="server" Text='<%# Eval("serviceFee") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    Total Amount:</td>
                <td class="content">
        <asp:Label ID="totalAmountTextBox" runat="server" Text='<%# Eval("totalAmount") %>'/></td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Other Information:</td>
            </tr>
            <tr>
                <td class="prompt">
                    Order Date:</td>
                <td class="content">
        <asp:Label ID="orderDateTextBox" runat="server" Text='<%# Eval("orderDate") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    Paid Date:</td>
                <td class="content">
        <asp:Label ID="payDateTextBox" runat="server" Text='<%# Eval("payDate") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    Prof Code:</td>
                <td class="content">
        <asp:Label ID="profCodeTextBox" runat="server" Text='<%# Eval("profCode") %>'/></td>
            </tr>
            <tr>
                <td class="prompt">
                    Notes:</td>
                <td class="content">
                    <asp:Label ID="TextBox1" runat="server" Text='<%# Eval("notes") %>' /></td>
            </tr>
        </table>
        <div class="toolbox listButtons">
            <ul>
                <li>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("orderID", "OrderDetail.aspx?id={0}") %>'>Order</asp:HyperLink></li><li>
                    <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Edit">Edit</asp:LinkButton></li><li>
                    <asp:LinkButton ID="LinkButton4" runat="server" OnClientClick="javascript:return confirm('Are you Look Card successful?')" OnClick="btnPay_Click" >Done</asp:LinkButton></li><li>
                        <asp:Label ID="Label6" runat="server" Text="" ForeColor=darkgreen></asp:Label></li></ul>
        <div style="clear:both"></div></div>
    </ItemTemplate>
    <HeaderTemplate>
        <uc1:OrderInfoCtl ID="OrderInfoCtl1" runat="server" OrderId='<%# Eval("orderID") %>' />
    </HeaderTemplate>
</asp:FormView>


</asp:Content>

