<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_PaymentCtl" Codebehind="PaymentOpCtl.ascx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>

<asp:ObjectDataSource ID="EmployeeDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetEmployeeNameList" TypeName="com.Omei.DLL.DS_EmployeeTableAdapters.EmployeeNameListTableAdapter">
</asp:ObjectDataSource>

        <table cellpadding="4" cellspacing="2" width="100%" class="detail_view">
            <tr>
                <td align="right" class="prompt">
            Received by:</td>
                <td>
                    <uc1:DataSelector ID="payEmp" runat="server"
                        DataSourceID="EmployeeDataset" DataTextField="username" 
                        DataValueField="employeeId" DefaultValue="0" NoSelectPrompt="-- Me --"/>
                </td>
                <td rowspan="3">
                    <input id="chkCash" name="chkMethod" type=radio onclick="setMethod(1)" checked=checked /><label for="chkCash" >Cash</label>&nbsp;
                    <input id="chkCheck" name="chkMethod" type=radio onclick="setMethod(3)" /><label for="chkCheck" >Check</label>&nbsp;
                    <asp:HiddenField ID="txtMethod" runat="server" Value='1' />
                    <asp:HiddenField ID="txtRemark" runat="server" Value='' />
                    <asp:HiddenField ID="txtReason" runat="server" Value='1' />
                    <div id="CheckDiv" style="visibility:hidden;position:relative;left:2px;top:10px">
                        Check number:<asp:TextBox ID="txtCheckNumber" runat="server"></asp:TextBox>
                    </div>                
                </td>
            </tr>
            <tr>
                <td align="right" class="prompt">
            Balance $</td>
                <td nowrap="nowrap">
                    <asp:Label ID="lbBalance" runat="server" CssClass="StrongNumber"></asp:Label>
                    <asp:Label ID="lbMsg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="right" class="prompt">
                    Pay $</td>
                <td nowrap="noWrap">
                    <asp:TextBox ID="txtPay" runat="server" Text='0'></asp:TextBox>
                    <asp:Button ID="btnPay" runat="server" Text="Pay" OnClick="btnPay_Click" OnClientClick="return CheckPayment();" /></td>
            </tr>
        </table>


