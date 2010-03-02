<%@ Control Language="C#" AutoEventWireup="true"
    Inherits="Controls_NewCreditCardPaymentCtl" Codebehind="NewCreditCardPaymentCtl.ascx.cs" %>
<%@ Register Src="../Controls/CountrySelector.ascx" TagName="CountrySelector" TagPrefix="uc3" %>
<%@ Register Src="../Controls/OmeiTypeSelectorCtl.ascx" TagName="OmeiTypeSelectorCtl"
    TagPrefix="uc5" %>
<asp:ObjectDataSource ID="CreditCardDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetCreditDetail" TypeName="com.Omei.BLL.Admin.CreditCardBiz" InsertMethod="AddCreditCard"
    OnInserted="CreditCardDataset_Inserted" UpdateMethod="UpdateCreditDetail">
    <SelectParameters>
        <asp:Parameter Name="crId" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:SessionParameter SessionField="LoginUserInfo" Name="loginUserInfo" Type="Object" />
        <asp:Parameter Name="orderID" Type="Int32" />
        <asp:Parameter Name="paymentId" Type="Int32" />
        <asp:Parameter Name="firstname" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="lastname" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="address" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="zip" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="cardType" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="cardNumber" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="csc" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="validDate" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="amount" Type="Decimal" />
        <asp:Parameter Name="serviceFee" Type="Decimal" />
        <asp:Parameter Name="totalAmount" Type="Decimal" />
        <asp:Parameter Name="profCode" Type="String" ConvertEmptyStringToNull="False" />
        <asp:Parameter Name="notes" Type="String" ConvertEmptyStringToNull="False" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="original_crId" Type="Int32" />
        <asp:Parameter Name="firstname" Type="String" />
        <asp:Parameter Name="lastname" Type="String" />
        <asp:Parameter Name="address" Type="String" />
        <asp:Parameter Name="city" Type="String" />
        <asp:Parameter Name="state" Type="String" />
        <asp:Parameter Name="zip" Type="String" />
        <asp:Parameter Name="country" Type="String" />
        <asp:Parameter Name="cardType" Type="String" />
        <asp:Parameter Name="cardNumber" Type="String" />
        <asp:Parameter Name="csc" Type="String" />
        <asp:Parameter Name="validDate" Type="String" />
        <asp:Parameter Name="amount" Type="Decimal" />
        <asp:Parameter Name="serviceFee" Type="Decimal" />
        <asp:Parameter Name="totalAmount" Type="Decimal" />
        <asp:Parameter Name="profCode" Type="String" />
        <asp:Parameter Name="notes" Type="String" />
    </UpdateParameters>
</asp:ObjectDataSource>
<asp:FormView ID="fvCreditCard" runat="server" DataKeyNames="crId" DataSourceID="CreditCardDataset"
    Width="100%" DefaultMode="Insert">
    <InsertItemTemplate>
        <table class="detail_view" border="1" cellpadding="2" cellspacing="0">
            <tr>
                <td colspan="2" class="header">
                    Customer Information (required) &nbsp;&nbsp;<asp:LinkButton ID="btnFillCustomerInfo"
                        runat="server" OnClick="btnFillCustomerInfo_Click" CausesValidation="False">Auto Fill</asp:LinkButton></td>
            </tr>
            <tr>
                <td nowrap class="prompt">
                    Customer name:</td>
                <td nowrap class="content">
                    first name:
                    <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'
                        ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="firstNameTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="CreditCardPaymentGroup" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    last name:<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="lastNameTextBox" Display="Dynamic" ErrorMessage="*" ValidationGroup="CreditCardPaymentGroup"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>' ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="prompt">
                    Address:</td>
                <td class="content">
                    <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' Width="90%"
                        ValidationGroup="CreditCardPaymentGroup"></asp:TextBox><br />
                    City:<asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' Width="60px"
                        ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cityTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="CreditCardPaymentGroup" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    State:<asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' Width="60px"
                        ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="stateTextBox"
                        ValidationGroup="CreditCardPaymentGroup" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    ZIP:<asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>' Width="60px"
                        ValidationGroup="CreditCardPaymentGroup"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="prompt">
                    Country:</td>
                <td class="content">
                    <uc3:CountrySelector ID="CountrySelector1" runat="server" CountryCode='<%# Bind("country") %>' />
                </td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Credit Card Information (required)</td>
            </tr>
            <tr>
                <td class="prompt">
                    Card Type:</td>
                <td class="content">
                    <uc5:OmeiTypeSelectorCtl ID="seleCardType" runat="server" TypeName='CreditCard'
                        SelectedValue='<%# Bind("cardType") %>' />
                </td>
            </tr>
            <tr>
                <td class="prompt">
                    Card Number:</td>
                <td class="content">
                    <asp:TextBox ID="cardNumberTextBox" runat="server" Text='<%# Bind("cardNumber") %>'
                        ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cardNumberTextBox"
                        ValidationGroup="CreditCardPaymentGroup" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="prompt">
                    CSC:</td>
                <td class="content">
                    <asp:TextBox ID="cscTextBox" runat="server" Text='<%# Bind("csc") %>' Width="60px"
                        ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="cscTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="CreditCardPaymentGroup"></asp:RequiredFieldValidator>&nbsp;
                    Expiry Date:<asp:TextBox ID="validDateTextBox" runat="server" Text='<%# Bind("validDate") %>'
                        Width="60px" ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="validDateTextBox"
                        ValidationGroup="CreditCardPaymentGroup" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Payment Details (required)</td>
            </tr>
            <tr>
                <td class="prompt">
                    Amount:</td>
                <td class="content">
                    <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("amount") %>' ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtAmount"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="CreditCardPaymentGroup"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="txtAmount"
                        Display="Dynamic" ErrorMessage="need amount" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Double" ValidationGroup="CreditCardPaymentGroup"></asp:CompareValidator>
                    &nbsp;&nbsp; Service Fee:<asp:TextBox ID="txtServiceFee" runat="server" Text='<%# Bind("serviceFee") %>'
                        ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtServiceFee"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="CreditCardPaymentGroup"></asp:RequiredFieldValidator><asp:CompareValidator
                            ID="CompareValidator3" runat="server" ControlToValidate="txtServiceFee" Display="Dynamic"
                            ErrorMessage="need service fee" Operator="DataTypeCheck" SetFocusOnError="True"
                            Type="Double" ValidationGroup="CreditCardPaymentGroup"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Other Information:</td>
            </tr>
            <tr>
                <td class="prompt">
                    Prof Code:</td>
                <td class="content">
                    <asp:TextBox ID="profCodeTextBox" runat="server" Text='<%# Bind("profCode") %>' ValidationGroup="CreditCardPaymentGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="profCodeTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="CreditCardPaymentGroup"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="prompt">
                    Notes:</td>
                <td class="content">
                    <asp:TextBox ID="TextBox1" runat="server" Rows="5" TextMode="MultiLine" Width="90%"
                        Text='<%# Bind("notes") %>'></asp:TextBox></td>
            </tr>
        </table>
    </InsertItemTemplate>
</asp:FormView>

<asp:Label ID="lbMsg" runat="server" EnableViewState="false" Visible="false" CssClass="error_message" />