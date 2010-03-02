<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="OrderDetail" Title="歐美旅遊-訂單信息" Codebehind="OrderDetail.aspx.cs" %>

<%@ Register Src="../WebParts/OplogList.ascx" TagName="OplogList" TagPrefix="uc2" %>
<%@ Register Src="../WebParts/OrderInfoCtl.ascx" TagName="OrderInfoCtl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li>
                <asp:HyperLink ID="lnkBusSeats" runat="server" Enabled='<%# PageLogic.CheckActionAuth("ASP.schedulelist_aspx") %>'>座位表</asp:HyperLink></li><li>
                    <a href="OrderActive.aspx" visible='<%# PageLogic.CheckActionAuth("ASP.orderlist_aspx") %>'>
                        订单列表</a></li><li>
                <asp:HyperLink ID="lnkOrderEdit" runat="server" NavigateUrl="OrderEdit.aspx">修改订单</asp:HyperLink>
            </li><li>|</li><li>
                <asp:HyperLink ID="lnkPayment" runat="server" NavigateUrl="OrderPayment.aspx" 
                    Enabled='<%# PageLogic.CheckActionAuth("ASP.orderpayment_aspx") %>'>Payment</asp:HyperLink>
                </li>&nbsp;
                <li>
                <asp:HyperLink ID="lnkRefund" runat="server" NavigateUrl="~/Refund.aspx" Enabled='<%# PageLogic.CheckActionAuth("ASP.refund_aspx") %>'>Refund</asp:HyperLink>
            </li><li>|</li><li>
                <asp:HyperLink ID="lnkPrint" runat="server" Target="_blank">Print ticket</asp:HyperLink></li><li>
                <asp:Label ID="txtToolMessage" runat="server" ForeColor="Red"></asp:Label></li></ul>
            <div style="clear:both"></div>
    <div style="clear:both"></div></div>

    <div>
    
        <div>
            <uc1:OrderInfoCtl ID="OrderInfoCtl1" runat="server" />
        </div>
        
        <div style="border:solid 1px white;padding:4px;background-color:#C8E0C0;">
            Credit Card:&nbsp;
            <asp:Repeater ID="lstOrdersCCList" runat="server" DataSourceID="OrdersCCListDataset">
                <ItemTemplate>
                    <asp:Literal ID="Literal1" runat="server" Text='<%# PayCreditCardText(Eval("paymentId"), Eval("crId"), Eval("cardNumber"), Eval("totalAmount")) %>'></asp:Literal>
                    &nbsp;
                </ItemTemplate>
            </asp:Repeater>
            <asp:ObjectDataSource ID="OrdersCCListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetOrdersCCList" TypeName="com.Omei.DLL.DS_CreditCardsTableAdapters.CCListTableAdapter">
                <SelectParameters>
                    <asp:Parameter Name="orderId" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            
            
            <asp:Repeater ID="lstVoucher" runat="server" DataSourceID="VoucherDataset">
                <HeaderTemplate>Credit Voucher:</HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbVid" runat=server Text='<%# Eval("voucherID") %>'></asp:Label># $<asp:Label ID="lbAmount" runat="server" Text='<%# Eval("amount") %>' />
                    <asp:HyperLink ID="lnkPrintVoucher" runat="server" Text="(Print)" Visible='<%# (byte)Eval("status")==1 %>' NavigateUrl='<%# Eval("voucherID","PrintVoucher.aspx?id={0}") %>' />
                    ,&nbsp;
                </ItemTemplate>
            </asp:Repeater>
            <asp:ObjectDataSource ID="VoucherDataset" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetOrderVoucherList" TypeName="com.Omei.BLL.Admin.VoucherBiz">
                <SelectParameters>
                    <asp:Parameter Name="orderID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            
        </div>
        
        <uc2:OplogList ID="OplogList1" runat="server" />
    
    </div>

</asp:Content>

