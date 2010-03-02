<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_OrderInfoCtl" Codebehind="OrderInfoCtl.ascx.cs" %>
<%@ Register Src="ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc2" %>
<%@ Register Src="PaymentListCtl.ascx" TagName="PaymentListCtl" TagPrefix="uc4" %>

<asp:FormView ID="fvOrderDetail" runat="server" DataSourceID="OrderDetailDataset" Width="100%" >
    <ItemTemplate>
    
    <div>
       <table cellpadding="6" cellspacing="0" width="100%">
        <tr>
            <td bgcolor="darkgreen" colspan="2" height="1">
            </td>
        </tr>
        <tr>
            <td bgcolor="darkgreen" nowrap="nowrap" style="color: white" align="center">
                訂單號<br />
                <asp:Label ID="lbOrderId" runat="server" Font-Bold="True" Text='<%# Eval("orderId") %>' Font-Size="14pt" ></asp:Label></td>
            <td width="100%" align="center">
                <uc2:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" ScheduleId='<%# Eval("scheduleID") %>' />
                <asp:Label ID="lbTourName" CssClass="schedule_title" runat="server" Text='<%# GetTicketName(Eval("orderType"), Eval("departureDate")) %>' Visible="true" />
            </td>
        </tr>
        <tr>
            <td bgcolor="darkgreen" colspan="2" height="1">
            </td>
        </tr>
        </table>
        <uc4:PaymentListCtl ID="PaymentListCtl1" runat="server" OrderId='<%# Eval("orderID") %>' />
    </div>    
    
    <table width="100%" cellpadding=2 cellspacing=0 border=0>
        <tr>
            <td colspan=2>
                Status:<asp:Label ID="lbStatus" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("OrderStatus",Eval("status"),"en") %>' Font-Bold="true" Font-Size="140%"></asp:Label>
                &nbsp;&nbsp;
                (Create by:
                <asp:Label ID="lbOpEmployee" runat="server" Text='<%# Eval("nickname") %>'></asp:Label>
                &nbsp;
                <asp:Label ID="lbCreateDate" runat="server" Text='<%# Eval("orderDate") %>'></asp:Label>)
            
            </td>
        </tr>
        <tr>
            <td width="50%"><fieldset style="height:120px;">
                <table width="100%" class="detail_view">
                    <tr>
                        <td class=prompt nowrap width="10%">Name:</td>
                        <td class="prompt" width="90%">
                            
                            <a onclick='viewUserInfo(<%# Eval("memberId") %>)'>
                            <asp:Literal ID="lbFirstName" runat="server" Text='<%# Eval("firstName") %>' ></asp:Literal>.<asp:Literal
                                ID="lbLastName" runat="server" Text='<%# Eval("lastName") %>' ></asp:Literal>&nbsp;
                            (Tel:<asp:Literal ID="lbTel" runat="server" Text='<%# Eval("contactPhone") %>' ></asp:Literal>)</a>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td class=prompt>Pickup:</td>
                        <td class="prompt">
                            <asp:Label ID="pickupLabel" runat="server" Text='<%# Bind("pickup") %>' CssClass="content"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class=prompt>人数:</td>
                        <td><asp:Label ID="numberAdultLabel" runat="server" Text='<%# Bind("numberAdult") %>' CssClass="content"></asp:Label>Adult, 
                            <asp:Label ID="numberChildLabel" runat="server" Text='<%# Bind("numberChild") %>' CssClass="content"></asp:Label>Child, 
                            <asp:Label ID="numberFreeLabel" runat="server" Text='<%# Bind("numberFree") %>' CssClass="content"></asp:Label>Free &nbsp;
                            <asp:Label ID="bookRoomsLabel" runat="server" Text='<%# Bind("bookRooms") %>' CssClass="content"></asp:Label>Room/
                            <asp:Label ID="roomShareLabel" runat=server Text='<%# Eval("roomShare") %>' CssClass="content" />
                        </td>
                    </tr>
                    <tr>
                        <td class=prompt>Seats:</td>
                        <td class="prompt">
                            <asp:Label ID="lbSeatList" runat="server" Text='<%# GetSeatList(Eval("orderId")) %>' CssClass="content"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class=prompt>Invoice:</td>
                        <td class=prompt>
                            <asp:Label ID="lbAgentInv" runat="server" Text='<%# Eval("agentInv") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class=prompt>Price:</td>
                        <td>$<asp:Label ID="lbPriceAdult" runat="server" Text='<%# Eval("priceAdult") %>' />/Adult, 
                $<asp:Label ID="lbPriceChild" runat="server" Text='<%# Eval("priceChild") %>' />/Child
                    </td>
                    </tr>
                </table>
            </fieldset></td>
            <td width="50%"><fieldset style="height:120px;">
                <table cellpadding="2" cellspacing="2" class="detail_view">
                    <tr>
                        <td align="right" class="prompt" nowrap="nowrap" width="80">
                            Subtotal $</td>
                        <td class="content" width="120">
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("fare") %>'></asp:Label></td>
                        <td align="right" class="prompt" nowrap="nowrap" width="80">
                            Actual $</td>
                        <td class="content" width="120">
                            <asp:Label ID="actualAmountLabel" runat="server" Text='<%# Bind("actualAmount") %>'>
                            </asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right" width="80" class="prompt" nowrap="noWrap">
                            Misc charge $</td>
                        <td class="content" width="120">
                            <asp:Label ID="miscChargeLabel" runat="server" Text='<%# Bind("miscCharge") %>'>
                            </asp:Label></td>
                        <td class="content" width="80">
                        </td>
                        <td class="content" width="120">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="prompt" nowrap="noWrap">
                            Discount %</td>
                        <td class="content" width="120">
                            <asp:Label ID="discountLabel" runat="server" Text='<%# Bind("discount") %>'></asp:Label></td>
                        <td class="prompt" align="right" nowrap="noWrap">
                            Pay $</td>
                        <td class="content">
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("pay") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="darkgreen" class="prompt" colspan="2" height="1">
                        </td>
                        <td align="right" bgcolor="darkgreen" class="prompt" colspan="2" height="1">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="prompt" nowrap="noWrap">
                            Suggest $</td>
                        <td class="content">
                            <asp:Label ID="suggestAmountLabel" runat="server" Text='<%# Bind("suggestAmount") %>'>
                            </asp:Label></td>
                        <td class="prompt" align="right" nowrap="noWrap">
                            Balance $</td>
                        <td class="content">
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("balance") %>'></asp:Label></td>
                    </tr>
                </table>
            </fieldset></td>
        </tr>
        <tr>
            <td colspan="2">
                Agent Receive: <asp:Label ID="Label5" runat="server" CssClass="content" Text='<%# Eval("fromAgent") %>'></asp:Label>
                <a href="OrderRecvAgent.aspx">&lt;Change&gt;</a>
                &nbsp;|&nbsp;
                Agent Transfor:<asp:Label ID="Label6" runat="server" CssClass="content" Text='<%# Eval("toAgent") %>'></asp:Label>
                <a href="OrderTransforAgent.aspx">&lt;Change&gt;</a>
            </td>
        </tr>
        <tr>
            <td>
            <fieldset style="height:40px;">
                <legend>Remark</legend>
                <asp:Label ID="lbRemark" CssClass="content" runat="server" Text='<%# Bind("remark") %>'></asp:Label>
            </fieldset></td>
            <td>
            <fieldset style="height:40px;">
                <legend>Notes(Print on ticket)</legend>
                <asp:Label ID="lbNotes" CssClass="content" runat="server" Text='<%# Bind("notes") %>'></asp:Label>
            </fieldset></td>
        </tr>
    </table>
    </ItemTemplate>
</asp:FormView>

<asp:ObjectDataSource ID="OrderDetailDataset" runat="server" 
    OldValuesParameterFormatString="original_{0}" 
    SelectMethod="GetOrderDetail"
    TypeName="com.Omei.BLL.Admin.AdminOrderBiz" >
    <SelectParameters>
        <asp:Parameter Name="orderId" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>