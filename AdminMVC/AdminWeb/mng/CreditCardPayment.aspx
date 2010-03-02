<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="CreditCardPayment" Title="Untitled Page" Codebehind="CreditCardPayment.aspx.cs" %>

<%@ Register Src="../Controls/CountrySelector.ascx" TagName="CountrySelector" TagPrefix="uc3" %>
<%@ Register Src="../Controls/OmeiTypeSelectorCtl.ascx" TagName="OmeiTypeSelectorCtl" TagPrefix="uc5" %>
<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc2" %>
<%@ Register Src="../WebParts/OrderInfoCtl.ascx" TagName="OrderInfoCtl" TagPrefix="uc1" %>
<%@ Register Src="../WebParts/PaymentListCtl.ascx" TagName="PaymentListCtl" TagPrefix="uc4" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:ObjectDataSource ID="CreditCardDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetCreditDetail" TypeName="com.Omei.BLL.Admin.CreditCardBiz" 
    InsertMethod="CreditCardPayment" OnInserted="CreditCardDataset_Inserted">
    <SelectParameters>
        <asp:Parameter Name="crId" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:SessionParameter SessionField="LoginUserInfo" Name="loginUserInfo" Type="Object" />
        <asp:QueryStringParameter QueryStringField="orderID" Name="orderID" Type="Int32" />    
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
        <asp:Parameter Name="totalAmount" Type="Decimal" />
        <asp:Parameter Name="profCode" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="notes" Type="String" ConvertEmptyStringToNull=false />
    </InsertParameters>
</asp:ObjectDataSource>

<uc1:OrderInfoCtl ID="OrderInfoCtl1" runat="server" />

<div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="btnInsert" runat="server" CausesValidation="True"
            Text="Pay" OnClick="btnInsert_Click"></asp:LinkButton></li><li><a href="OrderDetail.aspx">Cancel</a></li><li><asp:Label ID="lbMsg" runat="server" ForeColor="Red" /></li></ul>
        <div style="clear:both"></div></div>    
<asp:FormView ID="fvCreditCard" runat="server" DataKeyNames="crId" 
    DataSourceID="CreditCardDataset" Width="100%" DefaultMode="Insert">
    <InsertItemTemplate>
        <table class="detail_view" border="1" cellpadding="2" cellspacing="0">
            <tr>
                <td colspan=2 class="header">Customer Information (required) &nbsp;&nbsp;<asp:LinkButton ID="btnFillCustomerInfo" runat="server" OnClick="btnFillCustomerInfo_Click" CausesValidation="False">Auto Fill</asp:LinkButton></td>
            </tr>
            <tr>
                <td nowrap class="prompt">Customer name:</td>
                <td nowrap class="content">
                    first name:
        <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="firstNameTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    last name:<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="lastNameTextBox" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
        <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="prompt">
                    Address:</td>
                <td class="content">
        <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' Width="90%"></asp:TextBox><br />
                    City:<asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' Width="60px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cityTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    State:<asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' Width="60px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="stateTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    ZIP:<asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>' Width="60px"></asp:TextBox></td>
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
        <uc5:OmeiTypeSelectorCtl
            ID="TypeSelectorCtl1" runat="server" TypeName='CreditCard' SelectedValue='<%# Bind("cardType") %>' />
                </td>
            </tr>
            <tr>
                <td class="prompt">
                    Card Number:</td>
                <td class="content">
        <asp:TextBox ID="cardNumberTextBox" runat="server" Text='<%# Bind("cardNumber") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cardNumberTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="prompt">
                    CSC:</td>
                <td class="content">
        <asp:TextBox ID="cscTextBox" runat="server" Text='<%# Bind("csc") %>' Width="60px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="cscTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>&nbsp;
                    Expiry Date:<asp:TextBox ID="validDateTextBox" runat="server" Text='<%# Bind("validDate") %>' Width="60px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="validDateTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td colspan="2" class="header">
                    Payment Details (required)</td>
            </tr>
            <tr>
                <td class="prompt">
                    Amount:</td>
                <td class="content">
        <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("amount") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtAmount"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="txtAmount"
                        Display="Dynamic" ErrorMessage="need amount" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Double"></asp:CompareValidator>
                    &nbsp;&nbsp; Service Fee:<asp:TextBox ID="txtServiceFee" runat="server" Text='<%# Bind("serviceFee") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtServiceFee"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:CompareValidator
                            ID="CompareValidator3" runat="server" ControlToValidate="txtServiceFee" Display="Dynamic"
                            ErrorMessage="need service fee" Operator="DataTypeCheck" SetFocusOnError="True"
                            Type="Double"></asp:CompareValidator>
                    &nbsp; Total Amount:<asp:TextBox ID="txtTotalAmount" runat="server" Text='<%# Bind("totalAmount") %>'></asp:TextBox>
                    <asp:CompareValidator ID="CompareValidator1" runat="server"
                        Display="Dynamic" ErrorMessage="Total amount cann't bigger than balance." Operator="LessThanEqual"
                        SetFocusOnError="True" Type="Double" ControlToValidate="txtTotalAmount" ></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtTotalAmount"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="txtTotalAmount"
                        Display="Dynamic" ErrorMessage="need total amount" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Double"></asp:CompareValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtTotalAmount"
                        Display="Dynamic" ErrorMessage="not equal to amount plus service fee" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                        
                        
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
        <asp:TextBox ID="profCodeTextBox" runat="server" Text='<%# Bind("profCode") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="profCodeTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="prompt">
                    Notes:</td>
                <td class="content">
                    <asp:TextBox ID="TextBox1" runat="server" Rows="5" TextMode="MultiLine" Width="90%" Text='<%# Bind("notes") %>'></asp:TextBox></td>
            </tr>
        </table>
        
    </InsertItemTemplate>
</asp:FormView>

<div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True"
            Text="Pay" OnClick="btnInsert_Click"></asp:LinkButton></li><li><a href="OrderDetail.aspx">Cancel</a></li><li><asp:Label ID="lbMsg1" runat="server" ForeColor="Red" /></li></ul>
        <div style="clear:both"></div></div>

</asp:Content>

