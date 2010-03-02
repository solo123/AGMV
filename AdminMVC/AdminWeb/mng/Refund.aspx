<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Refund" Title="Untitled Page" Codebehind="Refund.aspx.cs" %>
<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc2" %>
<%@ Register Src="../WebParts/OrderInfoCtl.ascx" TagName="OrderInfoCtl" TagPrefix="uc1" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li><a href="OrderDetail.aspx">&lt;&lt;返回</a></li><li><a href="OrderEdit.aspx">脩改訂單</a></li></ul>
    <div style="clear:both"></div></div>
    <div>
        <uc1:OrderInfoCtl ID="OrderInfoCtl1" runat="server" />
        <hr />
        <table cellpadding="4" cellspacing="2" class="detail_view">
            <tr>
                <td align="right" class="prompt" valign="top">
                    Refund for:</td>
                <td valign="top">
                    <table>
                        <tr>
                            <td>
                                <uc3:DataSelector ID="payEmp" runat="server" DataSourceID="EmployeeDataset" DataTextField="username"
                                    DataValueField="employeeId" DefaultValue="0" NoSelectPrompt="-- Me --" />
                                <asp:ObjectDataSource ID="EmployeeDataset" runat="server" OldValuesParameterFormatString="original_{0}"
                                    SelectMethod="GetEmployeeNameList" TypeName="com.Omei.DLL.DS_EmployeeTableAdapters.EmployeeNameListTableAdapter">
                                </asp:ObjectDataSource>
                            </td>
                            <td>
                                <asp:RadioButtonList ID="chkPayMethod" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True" Value="1">Cash</asp:ListItem>
                                    <asp:ListItem Value="3">Check</asp:ListItem>
                                    <asp:ListItem Value="2">Credit Card</asp:ListItem>
                                    <asp:ListItem Value="5">Credit Voucher</asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                    </table>
                    
                </td>
            </tr>
            <tr>
                <td align="right" class="prompt" valign="top">
                    Amount$</td>
                <td nowrap="nowrap" valign="top">
                    <asp:TextBox ID="txtRefund" runat="server" Text="0"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="prompt" valign="top">
                    Remark:</td>
                <td nowrap="nowrap" valign="top">
                    <asp:TextBox ID="txtRemark" runat="server" Rows="4" Width="400" TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRemark"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td align="right" class="prompt" valign="top">
                </td>
                <td nowrap="nowrap" valign="top">
                    <asp:Button ID="btnDelOrder" runat="server" Text="订单作废" CausesValidation="False"
                        OnClick="btnDelOrder_Click" 
                        OnClientClick="javascript:return confirm('訂單作廢后無法進行退款操作，\n您確認要作廢嗎？');" />
                    &nbsp;|&nbsp;
                    <asp:Button ID="btnRefund" runat="server" OnClick="btnRefund_Click" OnClientClick="javascript:return confirm('您正準備進行退款操作。\n\n如此單是Full Paid的Agent訂單，請通知財務重新打印Agent應收付賬單。\n\n確認嗎？')" Text="Refund" />
                    <p>
                    <br />
                    <asp:Label ID="lbMsg" runat="server" CssClass="error_message"></asp:Label>                        
                    </p>    
                        </td>
            </tr>
        </table>
    </div>
    
</asp:Content>

