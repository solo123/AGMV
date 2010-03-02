<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="IMDetail" Title="Untitled Page" Codebehind="IMDetail.aspx.cs" %>

<%@ Register Src="../Controls/PubControls/CtlLb_EmployeeName.ascx" TagName="CtlLb_EmployeeName"
    TagPrefix="uc3" %>

<%@ Register Src="../Controls/PubControls/CtlLst_AgentOrders.ascx" TagName="CtlLst_AgentOrders"
    TagPrefix="uc2" %>

<%@ Register Src="../Controls/PubControls/CtlLb_AgentName.ascx" TagName="CtlLb_AgentName"
    TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



    <asp:FormView ID="fvInvoice" runat="server" DataSourceID="InvoiceDataset" Width="100%" DataKeyNames="matchID" >
        <ItemTemplate>
            <table cellpadding="4" cellspacing="0" class="detail_view">
                <tr>
                    <td class="prompt">Match#</td>
                    <td class="content"><asp:Label ID="lbMatchID" runat="server" Text='<%# Eval("matchID") %>' />
                        (agent inv:<asp:TextBox ID="lbAgentInv" runat="server" Width="80px" Text='<%# Eval("agentInv") %>' />
                        <asp:Button ID="btnUpdateAgentInv" runat="server" Text="Update" OnClick="btnUpdateAgentInv_Click" />) 
                         &nbsp;-&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel Invoice Match" OnClick="btnCancel_Click" 
                        OnClientClick="javascript:return confirm('取消此單后需重新Match此單上的所有Invoice，并需要重新統計此單所在月份的業務提成。\n\n確認嗎？');"
                        CausesValidation="false" />
                       <%# MatchInvoiceStatus(Eval("status")) %>
                    </td>
                </tr>
                <tr>
                    <td class="prompt">Agent:</td>
                    <td class="content">
                    <uc1:CtlLb_AgentName id="CtlLb_AgentName1" runat="server" agentID='<%# Eval("agentID") %>'>
    </uc1:CtlLb_AgentName>
                    </td>
                </tr>
                <tr>
                    <td class="prompt">Cost:</td>
                    <td class="content"><asp:Label ID="lbCost" runat="server" Text='<%# Eval("cost") %>' /></td>
                </tr>
                <tr>
                    <td class="prompt">Tax:</td>
                    <td class="content"><asp:Label ID="lbTax" runat="server" Text='<%# Eval("tax") %>' /></td>
                </tr>
                <tr>
                    <td class="prompt">Match amount:</td>
                    <td class="content"><asp:Label ID="lbMatchAmount" runat="server" Text='<%# Eval("matchAmount") %>' /></td>
                </tr>
                <tr>
                    <td class="prompt">Profit:</td>
                    <td class="content"><asp:Label ID="lbProfit" runat="server" Text='<%# Eval("profit") %>' /></td>
                </tr>
                <tr>
                    <td class="prompt">Match date:</td>
                    <td class="content"><asp:Label ID="lbMatchDate" runat="server" Text='<%# Eval("matchDate", "{0:d}") %>' /></td>
                </tr>
                <tr>
                    <td class="prompt">Operator:</td>
                    <td class="content">
                    <uc3:CtlLb_EmployeeName id="CtlLb_EmployeeName1" runat="server" EmployeeID='<%# Eval("opEmployee") %>'>
    </uc3:CtlLb_EmployeeName></td>
                </tr>
                <tr>
                    <td class="prompt">Notes:</td>
                    <td class="content"><asp:Label ID="lbOrders" runat="server" Text='<%# Eval("notes") %>' /></td>
                </tr>
            </table>
            <uc2:CtlLst_AgentOrders ID="CtlLst_AgentOrders1" runat="server" MatchID='<%# Eval("matchID") %>' />
        </ItemTemplate>
    </asp:FormView>
    
    
    
    <asp:ObjectDataSource ID="InvoiceDataset" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetInvoiceDetail" TypeName="com.Omei.BLL.Admin.IMMatchBiz">
        <SelectParameters>
            <asp:QueryStringParameter Name="matchID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    
    <asp:Label ID="lbResult" runat="server" EnableViewState="false" />



</asp:Content>

