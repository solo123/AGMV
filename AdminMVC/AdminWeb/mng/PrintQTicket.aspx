<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="PrintMaster.master" Title="Print Ticket" 
    Inherits="PrintQTicket" Theme="themePrint" Codebehind="PrintQTicket.aspx.cs" %>

<%@ Register Src="../Controls/PaymentBriefList.ascx" TagName="PaymentBriefList" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 

    <asp:ObjectDataSource ID="OrderDetailDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetTicketDetail" TypeName="com.Omei.BLL.Admin.AdminOrderBiz">
        <SelectParameters>
            <asp:Parameter Name="orderId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:FormView ID="fvOrder" runat="server" DataSourceID="OrderDetailDataset" DataKeyNames="orderId" HorizontalAlign="Left" Width="100%" OnDataBound="fvOrder_DataBound">
        <ItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" width="680">
                <tr>
                    <td height="125" valign="top">
                        <table style="width: 100%">
                            <tr>
                                <td width="530">
                                </td>
                                <td nowrap="nowrap" align="right">
                                    <br />
                                    Order ID:
                                    <asp:Label ID="orderIdLabel" runat="server" Text='<%# Eval("orderId") %>'></asp:Label><br />
                                    Company ID:<asp:Label ID="lbAgentId" runat="server" Text='<%# Eval("agentId") %>'></asp:Label><br />
                                    <br />
                                    <asp:Label ID="lbPrintTime" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="90">
                                </td>
                                <td height="29" width="330">
                                    <asp:Label ID="firstNameLabel" runat="server" Text='<%# Bind("firstName") %>'></asp:Label>.<asp:Label
                                        ID="lastNameLabel" runat="server" Text='<%# Bind("lastName") %>'></asp:Label></td>
                                <td width="130">
                                    <table width="128" border="0">
                                        <tr>
                                            <td align="right" width="50%">
                                                <asp:Label ID="priceAdultLabel" runat="server" Text='<%# Bind("priceAdult") %>'></asp:Label></td>
                                            <td align="right">
                                                <asp:Label ID="numberAdultLabel" runat="server" Text='<%# Bind("numberAdult") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" nowrap="noWrap">
                                    $<asp:Label ID="lbAdult" runat="server" Text='<%# Eval("fareAdult") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <asp:Label ID="contactPhoneLabel" runat="server" Text='<%# Bind("contactPhone") %>'></asp:Label></td>
                                <td>
                                    <table width="128" border="0">
                                        <tr>
                                            <td align="right" width="50%">
                                                <asp:Label ID="priceChildLabel" runat="server" Text='<%# Bind("priceChild") %>'></asp:Label></td>
                                            <td align="right">
                                                <asp:Label ID="numberChildLabel" runat="server" Text='<%# Bind("numberChild") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" nowrap="noWrap">
                                    $<asp:Label ID="lbChild" runat="server" Text='<%# Eval("fareChild") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <asp:Label ID="TourNameLabel" runat="server" Text='<%# Bind("listTitle") %>'></asp:Label>
                                    </td>
                                <td>
                                </td>
                                <td align="right" nowrap="noWrap">
                                    $<asp:Label ID="suggestAmountLabel" runat="server" Text='<%# Bind("suggestAmount") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <asp:Label ID="startDateLabel" runat="server" Text='<%# Eval("departureDate", "{0:d}") %>'></asp:Label></td>
                                <td>
                                </td>
                                <td align="right" nowrap="noWrap">
                                    $<asp:Label ID="actualAmountLabel" runat="server" Text='<%# Bind("actualAmount") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <asp:Label ID="lbSeatNumber" runat="server"></asp:Label></td>
                                <td colspan="2" rowspan="3" valign="top" style="padding:6px;">
                                    <table cellpadding="2" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Include SerCharge: $<asp:Label ID="lbSerCharge" runat="server" Text='<%# Eval("serviceFee") %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Total paid: $<asp:Label ID="lbPaid" runat="server" Text='<%# Eval("pay") %>'></asp:Label>
                                                <uc1:PaymentBriefList ID="PaymentBriefList1" runat="server" OrderID='<%# Eval("orderID") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Total balance: $<asp:Label ID="lbBalance" runat="server" Text='<%# Eval("balance") %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td height="30" valign=middle>Sales ID:
                                                <asp:Label ID="lbSalesID" runat="server" Text='<%# Eval("empId") %>'></asp:Label>
                                                &nbsp; Opt. ID:
                                                <asp:Label ID="lbOpt" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td class="textBlock">Notes:<asp:Label ID="lbNotes" runat=server Text='<%# Eval("notes") %>' /></td>
                                        </tr>       
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="150" align="left">
                                                <asp:Label ID="scheduleIdLabel" runat="server" Text='<%# Bind("scheduleId") %>'></asp:Label></td>
                                            <td width="50"><asp:Label ID="bookRoomsLabel" runat="server" Text='<%# Bind("bookRooms") %>'></asp:Label>
                                            </td>
                                            <td align="left" width="130"><asp:Label ID="pickupLabel" runat="server" Text='<%# Bind("pickup") %>'></asp:Label>
                                                </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height=215>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            
            <br />
            
            <table border="0" cellpadding="0" cellspacing="0" width="680">
                <tr>
                    <td height="125" valign="top">
                        <table style="width: 100%">
                            <tr>
                                <td width="530">
                                </td>
                                <td nowrap="nowrap" align="right">
                                    <br />
                                    Order ID:
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("orderId") %>'></asp:Label><br />
                                    Company ID:<asp:Label ID="Label2" runat="server" Text='<%# Eval("agentId") %>'></asp:Label><br />
                                    <br />
                                    <asp:Label ID="lbPrintTime1" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="90">
                                </td>
                                <td height="29" width="330">
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("firstName") %>'></asp:Label>.<asp:Label
                                        ID="Label5" runat="server" Text='<%# Bind("lastName") %>'></asp:Label></td>
                                <td width="130">
                                    <table width="128" border="0">
                                        <tr>
                                            <td align="right" width="50%">
                                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("priceAdult") %>'></asp:Label></td>
                                            <td align="right">
                                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("numberAdult") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" nowrap="noWrap">
                                    $<asp:Label ID="Label8" runat="server" Text='<%# Eval("fareAdult") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("contactPhone") %>'></asp:Label></td>
                                <td>
                                    <table width="128" border="0">
                                        <tr>
                                            <td align="right" width="50%">
                                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("priceChild") %>'></asp:Label></td>
                                            <td align="right">
                                                <asp:Label ID="Label11" runat="server" Text='<%# Bind("numberChild") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" nowrap="noWrap">
                                    $<asp:Label ID="Label12" runat="server" Text='<%# Eval("fareChild") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <asp:Label ID="Label13" runat="server" Text='<%# Bind("listTitle") %>'></asp:Label>
                                    </td>
                                <td>
                                </td>
                                <td align="right" nowrap="noWrap">
                                    $<asp:Label ID="Label15" runat="server" Text='<%# Bind("suggestAmount") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <asp:Label ID="Label16" runat="server" Text='<%# Eval("departureDate", "{0:d}") %>'></asp:Label></td>
                                <td>
                                </td>
                                <td align="right" nowrap="noWrap">
                                    $<asp:Label ID="Label17" runat="server" Text='<%# Bind("actualAmount") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <asp:Label ID="lbSeatNumber1" runat="server"></asp:Label></td>
                                <td colspan="2" rowspan="3" valign="top" style="padding:6px;">
                                    <table cellpadding="2" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Include SerCharge: $<asp:Label ID="Label20" runat="server" Text='<%# Eval("serviceFee") %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Total paid: $<asp:Label ID="Label21" runat="server" Text='<%# Eval("pay") %>'></asp:Label>
                                                <uc1:PaymentBriefList ID="PaymentBriefList2" runat="server" OrderID='<%# Eval("orderID") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Total balance: $<asp:Label ID="Label22" runat="server" Text='<%# Eval("balance") %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td height="30" valign=middle>Sales ID:
                                                <asp:Label ID="Label23" runat="server" Text='<%# Eval("empId") %>'></asp:Label>
                                                &nbsp; Opt. ID:
                                                <asp:Label ID="lbOpt1" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td class="textBlock">Notes:<asp:Label ID="Label25" runat=server Text='<%# Eval("notes") %>' /></td>
                                        </tr>       
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="29">
                                    <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="150" align="left">
                                                <asp:Label ID="Label26" runat="server" Text='<%# Bind("scheduleId") %>'></asp:Label></td>
                                            <td width="50"><asp:Label ID="Label27" runat="server" Text='<%# Bind("bookRooms") %>'></asp:Label>
                                            </td>
                                            <td align="left" width="130"><asp:Label ID="Label28" runat="server" Text='<%# Bind("pickup") %>'></asp:Label>
                                                </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height=100>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>

</asp:Content>
