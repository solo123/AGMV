<%@ Register Assembly="Infragistics2.WebUI.UltraWebTab.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebTab" TagPrefix="igtab" %>
<%@ Register Src="../Controls/NewCreditCardPaymentCtl.ascx" TagName="NewCreditCardPaymentCtl"
    TagPrefix="uc2" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>

<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_PaymentControl" Codebehind="PaymentCtl.ascx.cs" %>
<asp:ObjectDataSource ID="EmployeeDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetEmployeeNameList" TypeName="com.Omei.DLL.DS_EmployeeTableAdapters.EmployeeNameListTableAdapter">
</asp:ObjectDataSource>
<div style="padding: 8px;">
    <table>
        <tr>
            <td>
                Received by:</td>
            <td>
                <uc1:DataSelector ID="payEmp" runat="server" DataSourceID="EmployeeDataset" DataTextField="username"
                    DataValueField="employeeId" DefaultValue="0" NoSelectPrompt="-- Me --" />
            </td>
            <td style="width: 100px" align="right">
                Balance $</td>
            <td style="width: 100px">
                <asp:Label ID="lbBalance" runat="server" CssClass="StrongNumber"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <igtab:UltraWebTab ID="tabsPayment" runat="server" BorderColor="#949878" BorderStyle="Solid"
        BorderWidth="1px" ThreeDEffect="False" SelectedTab="2">
        <Tabs>
            <igtab:Tab Key="Cash" Text="Cash">
                <ContentTemplate>
                    <h2>
                        Pay by Cash</h2>
                    <table>
                        <tr>
                            <td>
                                Pay$</td>
                            <td>
                                <asp:TextBox ID="txtCashAmount" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator2" runat="server" ValidationGroup="PaymentCashGroup" ErrorMessage="* 請輸入金額！" ControlToValidate="txtCashAmount" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:CompareValidator
                                        ID="CompareValidator1" runat="server" ErrorMessage="金額必須為數值。" ValidationGroup="PaymentCashGroup" ControlToValidate="txtCashAmount" Display="Dynamic" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
                                </td>
                            <td>
                                <asp:Button ID="btnPayCash" runat="server" Text="Pay Cash" ValidationGroup="PaymentCashGroup" OnClick="btnPayCash_Click" /></td>
                        </tr>
                    </table>
                </ContentTemplate>
            </igtab:Tab>
            <igtab:Tab Key="Check" Text="Check">
                <ContentTemplate>
                    <h2>
                        Pay by Check</h2>
                    <table>
                        <tr>
                            <td>
                                Check number:</td>
                            <td colspan="2">
                                <asp:TextBox ID="txtCheckNumber" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCheckNumber"
                                    ErrorMessage="* 請輸入支票編號" SetFocusOnError="True" ValidationGroup="CheckPaymentGroup" Display="Dynamic"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                Pay$</td>
                            <td>
                                <asp:TextBox ID="txtCheckAmount" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="CheckPaymentGroup" ErrorMessage="* 請輸入金額！" ControlToValidate="txtCheckAmount" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:CompareValidator
                                    ID="CompareValidator2" runat="server" ValidationGroup="CheckPaymentGroup" ErrorMessage="金額必須為數值。" ControlToValidate="txtCheckAmount" Display="Dynamic" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
                                </td>
                            <td>
                                <asp:Button ID="btnPayCheck" runat="server" Text="Pay Check" OnClick="btnPayCheck_Click" ValidationGroup="CheckPaymentGroup" /></td>
                        </tr>
                    </table>
                </ContentTemplate>
            </igtab:Tab>
            <igtab:Tab Key="CreditCard" Text="Credit Card">
                <ContentTemplate>
                    <h2>
                        Pay by Credit Card</h2>
                        
                    <uc2:NewCreditCardPaymentCtl ID="CreditCardPaymentCtl1" runat="server" />
                    <asp:Button ID="btnPayCC" runat="server" Text="Pay by Credit Card" ValidationGroup="CreditCardPaymentGroup" OnClick="btnPayCC_Click" />   
                        
                </ContentTemplate>
            </igtab:Tab>
            <igtab:Tab Key="CreditVoucher" Text="Credit Voucher">
                <ContentTemplate>
                    <h2>
                        Pay by Credit Voucher</h2>
                    <table>
                        <tr>
                            <td>
                                ID#</td>
                            <td>
                                <asp:TextBox ID="txtVoucherID" runat="server"></asp:TextBox>
                                <asp:Button ID="bntVoucher" runat="server" Text="Voucher validate" OnClick="bntVoucher_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Pay$</td>
                            <td>
                                <asp:TextBox ID="txtVoucherAmount" runat="server" Enabled="false"></asp:TextBox>
                                Credit:<asp:Label ID="lbVoucherAmount" runat="server" CssClass="StrongNumber" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lbVoucherDetail" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnPayVoucher" runat="server" Text="Pay by Voucher" OnClick="btnPayVoucher_Click" Enabled="false" /></td>
                        </tr>
                    </table>
                </ContentTemplate>
            </igtab:Tab>
            <igtab:Tab Key="Agent" Text="Agent">
                <ContentTemplate>
                    <h2>Pay Balance By Agent:<asp:Label ID="lbAgentName" runat="server" /></h2>
                    <p style="width:600px;line-height:24px;">
                    注：Agent的訂單可以用Agent Credit來Pay Balance。Agent Credit將在財務部匯總。
                    </p>
                    <table>
                        <tr>
                            <td>
                                Pay$</td>
                            <td>
                                <asp:Label ID="lbAgentAmount" runat="server" CssClass="StrongNumber" /></td>
                            <td>
                                <asp:Button ID="btnPayAgent" runat="server" Text="Pay Balance by Agent" OnClick="btnPayAgent_Click" /></td>
                        </tr>
                    </table>
                </ContentTemplate>
            </igtab:Tab>
        </Tabs>
        <RoundedImage FillStyle="LeftMergedWithCenter" HoverImage="[ig_tab_winXP2.gif]" LeftSideWidth="7"
            NormalImage="[ig_tab_winXP3.gif]" RightSideWidth="6" SelectedImage="[ig_tab_winXP1.gif]"
            ShiftOfImages="2" />
        <SelectedTabStyle BackColor="#E4EEE0">
            <Padding Bottom="2px" />
        </SelectedTabStyle>
        <DefaultTabStyle BackColor="#FEFCFD" Font-Names="Microsoft Sans Serif" Font-Size="8pt"
            ForeColor="Black" Height="22px">
            <Padding Top="2px" />
        </DefaultTabStyle>
    </igtab:UltraWebTab>
    &nbsp;&nbsp;<br />
    <asp:Label ID="lbMsg" runat="server" EnableViewState="false" CssClass="error_message" /><br />
    <br />
</div>
