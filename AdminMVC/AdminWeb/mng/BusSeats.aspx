<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="BusSeats" Title="Untitled Page" Codebehind="BusSeats.aspx.cs" %>

<%@ Register Src="../Controls/HotelListCtl.ascx" TagName="HotelListCtl" TagPrefix="uc5" %>
<%@ Register Src="../WebParts/TourFeeCtl.ascx" TagName="TourFeeCtl" TagPrefix="uc4" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc3" %>
<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc2" %>
<%@ Register Src="../WebParts/BusSeatCtl.ascx" TagName="BusSeatCtl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<script language="javascript" type="text/javascript">
<!--
var msg_notSelect = 'Please select some seats for any action.';
var msg_release = 'Only seats on hold (yellow) can do release.';
var msg_neworder = 'Only open seats (green) can be used to open ticket.';
var msg_continue = 'Only seats on hold (yellow) can do continue.';
var msg_payBalance = 'Only seats with partial paid (pink) can do pay balance.';
var msg_refund = 'Only seat paid in partial (pink) or full (red) can do refund.';
var msg_changeSeat = 'Only seat paid in partial (pink) or full (red) can do change seat.';
var msg_printTicket = 'Only seat paid in partial (pink) or full (red) can do re-print ticket.';
var msg_hold = 'Only open seats (green) can do hold.';
var msg_addSeat = 'Only open seats (green) can be used to add.';
var msg_delSeat = "Open seats cannot do release.";

function CheckSeats(errMsg, ptn)
{
    var s = GetSelectedSeats(ptn);
    var result = false;
    
    if ( s == "" )
    {
        alert(msg_notSelect);
        result = false;
    } else if ( s=="ERR:0" )
    {
        alert(errMsg);
        result = false;
    }
    else
    {
        //alert(s);
        document.all.ctl00$ContentPlaceHolder1$hdSeatList.value = s;
        if ( errMsg==msg_hold)
        {
            var pmt = "Input notes here...";
            var notes = prompt("Please input hold seats notes:", pmt);
            if ( notes==null || notes=="" || notes==pmt)
            {
                alert("Please input Hold seats notes");
                result = false;
            } else {
                document.all.ctl00$ContentPlaceHolder1$hdRemark.value = notes;
                result = true;
            }
        } else
            result = true;
    }
    
    if(result==false) window.event.returnValue = false;  // cancel event bubble
    return result;
}

function PrintSeats(scheduleId)
{
    window.open("BusSeats_Prn.aspx?scheduleId="+scheduleId, "PrintSeats", "alwaysRaised=yes, dependent=yes, height=500, width=800, toolbar=no, menubar=yes, scrollbars=yes, resizable=yes, location=no, status=no");
}

function ShowFee(displayMode){
    var fw = document.getElementById("dhtmlgoodies_floating_window0");
    if (fw!=null) fw.style.display = displayMode;
}

// -->
</script>

<div>
    <uc2:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" />
    <hr />
</div>

<asp:ObjectDataSource ID="NewOrderDataset" runat="server" SelectMethod="GetNotSeatedOrders" 
    TypeName="com.Omei.DLL.DS_OrdersTableAdapters.NotSeatsOrdersTableAdapter" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:QueryStringParameter Name="scheduleId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
</asp:ObjectDataSource>

<div>
    <asp:GridView ID="lstOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="orderId" 
        DataSourceID="NewOrderDataset" SkinID="NormalDataList" Width="100%" OnRowCommand="lstOrders_RowCommand">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="orderId" DataNavigateUrlFormatString="OrderDetail.aspx?id={0}"
                DataTextField="orderId" HeaderText="Order#" >
                <ItemStyle HorizontalAlign="Center" Font-Bold="True" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="username" HeaderText="Name" ReadOnly="True" SortExpression="username" />
            <asp:BoundField DataField="contactPhone" HeaderText="Tel" SortExpression="contactPhone" />
            <asp:TemplateField HeaderText="# Ad/Ch/Fr" SortExpression="numberAdult">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("numberAdult") %>'></asp:Label>/
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("numberChild") %>'></asp:Label>/
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("numberFree") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return CheckSeats(msg_neworder, '0')"
                        ID="LinkButton1" runat="server" CommandName="AddSeats" CommandArgument='<%# Eval("orderId") %>'>Add Seats</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>    
    
<div>
    <table width="100%">
        <tr>
            <td>
            <div class=listButtons>
            <ul>
        <li><asp:Button ID="btnHold" runat="server" Text="Hold" 
            OnClick="btnHold_Click" 
            OnClientClick="return CheckSeats(msg_hold, '0')" /></li><li><asp:Button ID="btnOrder" runat="server" Text="Order" 
            OnClick="btnOrder_Click" 
            OnClientClick="return CheckSeats(msg_neworder, '0')" /></li><li><asp:Button ID="btnRelease" runat="server" Text="Release" 
            OnClick="btnRelease_Click"
            OnClientClick="return CheckSeats(msg_release, '123')" /></li><li><asp:Literal ID="lbPrintSeats" runat="server"></asp:Literal></li>
                <li><a onclick="ShowFee('')">Fee</a></li>
            
            </ul>
            </div>
            </td>
            <td align="right">
                <table width="380" border="0" cellpadding="4" cellspacing="0" style="border: solid 1px darkgreen;">
                  <tr>
                    <td align="center" nowrap="nowrap" class="edit_en">圖示:(<a href="ScheduleOrders.aspx">相关订单</a>)</td>
                    <td align="center" nowrap="nowrap" class="edit_en"><span class="diagramExp" style="color:#339966;">g</span> Avilible</td>
                    <td align="center" nowrap="nowrap" class="edit_en"><span class="diagramExp" style="color:#ffff80;">g</span> Hold</td>
                    <td align="center" nowrap="nowrap" class="edit_en"><span class="diagramExp" style="color:#ff99cc;">g</span> Sold balance</td>
                    <td align="center" nowrap="nowrap" class="edit_en"><span class="diagramExp" style="color:#ffcc99;">g</span> Full pay</td>
                  </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:HiddenField ID="hdSeatList" runat="server" />
                <asp:HiddenField ID="hdRemark" runat="server" />
                <uc1:BusSeatCtl id="BusSeatCtl1" runat="server"></uc1:BusSeatCtl>
            </td>
        </tr>
    </table>
    
    <uc5:HotelListCtl ID="HotelListCtl1" runat="server" />
</div>


<div id="window1">
	<div class="floatingWindowContent">
	    <uc4:TourFeeCtl id="TourFeeCtl1" runat="server" />
	</div>
</div>
<script type="text/javascript" language="javascript">
initFloatingWindowWithTabs('window1',Array('Tour Fee'), false,440,500,100, true,false,true,false,true);
ShowFee("none");
</script>
</asp:Content>
