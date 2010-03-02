<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="TicketEdit" Title="" Codebehind="TicketEdit.aspx.cs" %>

<%@ Register Src="../Controls/OmeiTypeSelectorCtl.ascx" TagName="OmeiTypeSelectorCtl"
    TagPrefix="uc1" %>
<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc2" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" language="javascript">

    </script>

    <div style="top: 24px; left: 400px; position: absolute; border: none;">
        <asp:Label ID="lbMsg" runat="server" ForeColor="Red" Text="" EnableViewState="false"></asp:Label>
    </div>
    <asp:ObjectDataSource ID="TicketDetailDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        TypeName="com.Omei.BLL.Admin.TicketBiz" InsertMethod="AddTicket" OnInserted="OrderDetailDataset_Inserted"
        SelectMethod="GetTicketById" UpdateMethod="UpdateTicket" OnUpdated="TicketDetailDataset_Updated">
        <InsertParameters>
            <asp:SessionParameter Name="loginUserInfo" Type="Object" SessionField="LoginUserInfo" />
            <asp:Parameter Name="orderType" Type="Int32" />
            <asp:Parameter Name="memberId" Type="Int32" />
            <asp:Parameter Name="firstName" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="lastName" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="contactPhone" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="email" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="customers" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="pickup" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="numberAdult" Type="Int32" />
            <asp:Parameter Name="numberChild" Type="Int32" />
            <asp:Parameter Name="numberFree" Type="Int32" />
            <asp:Parameter Name="roomShare" Type="Char" />
            <asp:Parameter Name="bookRooms" Type="Decimal" />
            <asp:Parameter Name="priceAdult" Type="Decimal" />
            <asp:Parameter Name="priceChild" Type="Decimal" />
            <asp:Parameter Name="suggestAmount" Type="Decimal" />
            <asp:Parameter Name="actualAmount" Type="Decimal" />
            <asp:Parameter Name="miscCharge" Type="Decimal" />
            <asp:Parameter Name="discount" Type="Decimal" />
            <asp:Parameter Name="fare" Type="Decimal" />
            <asp:Parameter Name="remark" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="notes" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="agentInv" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="departureDate" Type="DateTime" ConvertEmptyStringToNull="False" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="original_orderId" Type="Int32" />
            <asp:SessionParameter Name="loginUserInfo" Type="Object" SessionField="LoginUserInfo" />
            <asp:Parameter Name="orderType" Type="Int32" />
            <asp:Parameter Name="memberId" Type="Int32" />
            <asp:Parameter Name="firstName" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="lastName" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="customers" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="contactPhone" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="email" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="pickup" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="numberAdult" Type="Int32" />
            <asp:Parameter Name="numberChild" Type="Int32" />
            <asp:Parameter Name="numberFree" Type="Int32" />
            <asp:Parameter Name="roomShare" Type="Char" />
            <asp:Parameter Name="bookRooms" Type="Decimal" />
            <asp:Parameter Name="priceAdult" Type="Decimal" />
            <asp:Parameter Name="priceChild" Type="Decimal" />
            <asp:Parameter Name="suggestAmount" Type="Decimal" />
            <asp:Parameter Name="actualAmount" Type="Decimal" />
            <asp:Parameter Name="miscCharge" Type="Decimal" />
            <asp:Parameter Name="discount" Type="Decimal" />
            <asp:Parameter Name="fare" Type="Decimal" />
            <asp:Parameter Name="remark" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="notes" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="agentInv" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="departureDate" Type="DateTime" ConvertEmptyStringToNull="False" />
        </UpdateParameters>
        <SelectParameters>
            <asp:Parameter Name="orderId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="PickupDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="PickUp" Name="listClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="DiscountDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="Discount" Name="listClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="CompanyDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCompanyNameList" TypeName="com.Omei.DLL.DS_CompanysTableAdapters.CompanyNameListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="companyType" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="fvOrderDetail" runat="server" DataKeyNames="orderId" DataSourceID="TicketDetailDataset"
        DefaultMode="Edit" OnDataBound="fvOrderDetail_DataBound" Width="100%">
        <InsertItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>
                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="Save" /></li>
                    <li><a href="MyOrders.aspx">Cancel</a></li></ul>
            <div style="clear:both"></div></div>
            <div class="schedule_info">
                <div class="schedule_orderid">
                    <br />
                    訂單號:<br />
                    <span style="font-size: 14px; font-weight: bold;">&lt;新订单&gt;</span>
                </div>
                <div class="schedule_title">
                    <div style="margin-top:8px;">
                    Ticket Title:
                    <uc1:OmeiTypeSelectorCtl ID="OmeiTypeSelectorCtl1" runat="server" TypeName="TicketType" DefaultValue="nodefault"
                        SelectedValue='<%# Bind("orderType") %>' />
                    </div>
                    <div style="margin-top: 12px;">
                    Departure date:
                    <uc2:DateInputCtl ID="DateInputCtl1" runat="server" DateValue='<%# Bind("departureDate") %>' />
                    </div>
                </div>
            </div>
            <div>
                <table cellpadding="2" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td valign="top" width="50%">
                            <fieldset style="height: 140px;">
                                <legend>Customer Info</legend>
                                <div style="float: left; width: 50%;">
                                    <table cellpadding="2" cellspacing="2" border="0" class="detail_view">
                                        <tr>
                                            <td colspan="2" nowrap="nowrap">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="80" nowrap="noWrap">
                                                付款人 ID:</td>
                                            <td>
                                                <asp:Label ID="lbMemberID" runat="server" Text="" CssClass="content" />
                                                <asp:HiddenField ID="txtMemberId" runat="server" Value='<%# Bind("memberId") %>' />
                                                &nbsp; <span class="ClickLabel" onclick="ShowSearchCustomer('')">&lt;&lt;Change</span>
                                        </tr>
                                        <tr>
                                            <td align="right" width="80" nowrap="noWrap">
                                                First name:</td>
                                            <td>
                                                <asp:HiddenField ID="txtFirstname" runat="server" Value='<%# Bind("firstName") %>' />
                                                <asp:Label ID="lbFirstname" runat="server" Text='<%# Eval("firstName") %>' /></td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Last name:</td>
                                            <td>
                                                <asp:HiddenField ID="txtLastname" runat="server" Value='<%# Bind("lastName") %>' />
                                                <asp:Label ID="lbLastname" runat="server" Text='<%# Eval("lastName") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Phone:
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="txtContactPhone" runat="server" Value='<%# Bind("contactPhone") %>' />
                                                <asp:Label ID="lbContactPhone" runat="server" Text='<%# Eval("contactPhone") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Email:
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="txtEmail" runat="server" Value='<%# Bind("email") %>' />
                                                <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("email") %>' />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="float: left;">
                                    參團人:（多人用,分隔）
                                    <br />
                                    <asp:TextBox ID="txtCustomers" runat="server" Text='<%# Bind("customers") %>' TextMode="MultiLine"
                                        Rows="4" Width="200px" />
                                </div>
                            </fieldset>
                        </td>
                        <td valign="top" width="50%">
                            <fieldset style="height: 140px;">
                                <legend>Order Info</legend>
                                <table cellpadding="2" cellspacing="2" class="detail_view">
                                    <tr>
                                        <td align="right" nowrap="noWrap" width="80">
                                            Pickup:</td>
                                        <td>
                                            <uc4:DataSelector ID="lstPickup" runat="server" DataSourceID="PickupDataset" DataTextField="listTitle"
                                                DataValueField="listValue" DefaultValue="" SelectedValue='<%# Bind("pickup") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" nowrap="noWrap">
                                            # Adult:
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:TextBox ID="numberAdultTextBox" runat="server" Text='<%# Bind("numberAdult") %>'
                                                Width="35px"></asp:TextBox>
                                            #Child:<asp:TextBox ID="numberChildTextBox" runat="server" Text='<%# Bind("numberChild") %>'
                                                Width="35px"></asp:TextBox>
                                            #Free:<asp:TextBox ID="numberFreeTextBox" runat="server" Text='<%# Bind("numberFree") %>'
                                                Width="35px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" nowrap="noWrap">
                                            # Room:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="bookRoomsTextBox" runat="server" Text='<%# Bind("bookRooms") %>'
                                                Width="50px"></asp:TextBox>
                                            Share with:<asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("roomShare") %>'>
                                                <asp:ListItem Value=" ">未定</asp:ListItem>
                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Price:</td>
                                        <td>
                                            <asp:TextBox ID="txtPriceAdult" runat="server" Text='<%# Bind("priceAdult") %>' Width="80" />/Adult
                                            &nbsp;&nbsp;<asp:TextBox ID="txtPriceChild" runat="server" Text='<%# Bind("priceChild") %>'
                                                Width="80" />/Child
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" nowrap="noWrap" class="prompt">
                                            座位:
                                        </td>
                                        <td class="content" colspan="1">
                                            <asp:Label ID="lbSeatList" runat="server" Text=''></asp:Label></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <fieldset style="height: 185px;">
                                <legend>Others</legend>
                                <table cellpadding="2" cellspacing="2" class="detail_view" width="100%">
                                    <tr>
                                        <td>
                                            Agent inv#:</td>
                                        <td>
                                            <asp:TextBox ID="txtAgentInv" runat="server" Width="200px" Text='<%# Bind("agentInv") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Remark:</td>
                                        <td>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("remark") %>' Width="95%"
                                                Rows="3" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Notes:</td>
                                        <td>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("notes") %>' Width="95%"
                                                Rows="3" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td valign="top">
                            <fieldset style="height: 185px;">
                                <legend>Amount</legend>
                                <table cellpadding="2" cellspacing="2" class="detail_view" width="100%">
                                    <tr>
                                        <td align="right" width="80">
                                            Subtotal $</td>
                                        <td>
                                            <asp:Label ID="lbSubtotal" runat="server" Text='' CssClass="StrongNumber"></asp:Label>
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Discount %</td>
                                        <td>
                                            <uc1:OmeiTypeSelectorCtl ID="lstDiscount" TypeName="Discount" runat="server" SelectedValue='<%# Bind("discount") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="80">
                                            Misc charge $</td>
                                        <td>
                                            <asp:TextBox ID="miscChargeTextBox" runat="server" Text='<%# Bind("miscCharge") %>'
                                                Width="100px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Suggest $&nbsp;</td>
                                        <td>
                                            <asp:Label ID="lbSuggestAmount" runat="server" Text='' CssClass="StrongNumber"></asp:Label>
                                            &nbsp;
                                            <asp:Label ID="lbRecal" runat="server" CssClass="ClickLabel" Text="<<重算"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Actual $</td>
                                        <td>
                                            <asp:TextBox ID="actualAmountTextBox" runat="server" Text='<%# Bind("actualAmount") %>'
                                                Width="100px"></asp:TextBox>
                                            <asp:HiddenField ID="hdSubTotal" runat="server" Value='<%# Bind("fare") %>' />
                                            <asp:HiddenField ID="hdSuggest" runat="server" Value='<%# Bind("suggestAmount") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="toolbox listButtons">
                <ul>
                    <li>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="Save" /></li>
                    <li><a href="MyOrders.aspx">Cancel</a></li></ul>
            <div style="clear:both"></div></div>
            <div id="window1">
                <div class="floatingWindowContent">
                    <iframe id="frmCustomer" width="100%" height="460" frameborder="0" src='SearchCustomer_pop.aspx'>
                    </iframe>
                </div>
            </div>
        </InsertItemTemplate>
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>
                        <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Save" /></li>
                    <li><a href="MyOrders.aspx">Cancel</a></li></ul>
            <div style="clear:both"></div></div>
            <div class="schedule_info">
                <div class="schedule_orderid">
                    <br />
                    訂單號:<br />
                    <span style="font-size: 14px; font-weight: bold;">
                        <%# Eval("orderID") %>
                    </span>
                </div>
                <div class="schedule_title">
                    <div style="margin-top:8px;">
                    Ticket Title:
                    <uc1:OmeiTypeSelectorCtl ID="seleTicketType" runat="server" TypeName="TicketType" DefaultValue="nodefault"
                        SelectedValue='<%# Bind("orderType") %>' />
                    </div>
                    <div style="margin-top: 12px;">
                    Departure date:
                    <uc2:DateInputCtl ID="dateStart" runat="server" DateValue='<%# Bind("departureDate") %>' />
                    </div>
                </div>
            </div>
            <div>
                <table cellpadding="2" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td valign="top" width="50%">
                            <fieldset style="height: 140px;">
                                <legend>Customer Info</legend>
                                <div style="float: left; width: 50%;">
                                    <table cellpadding="2" cellspacing="2" border="0" class="detail_view">
                                        <tr>
                                            <td colspan="2" nowrap="nowrap">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="80" nowrap="noWrap">
                                                付款人 ID:</td>
                                            <td>
                                                <asp:Label ID="lbMemberID" runat="server" Text="" CssClass="content" />
                                                <asp:HiddenField ID="txtMemberId" runat="server" Value='<%# Bind("memberId") %>' />
                                                &nbsp; <span class="ClickLabel" onclick="ShowSearchCustomer('')">&lt;&lt;Change</span>
                                        </tr>
                                        <tr>
                                            <td align="right" width="80" nowrap="noWrap">
                                                First name:</td>
                                            <td>
                                                <asp:HiddenField ID="txtFirstname" runat="server" Value='<%# Bind("firstName") %>' />
                                                <asp:Label ID="lbFirstname" runat="server" Text='<%# Eval("firstName") %>' /></td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Last name:</td>
                                            <td>
                                                <asp:HiddenField ID="txtLastname" runat="server" Value='<%# Bind("lastName") %>' />
                                                <asp:Label ID="lbLastname" runat="server" Text='<%# Eval("lastName") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Phone:
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="txtContactPhone" runat="server" Value='<%# Bind("contactPhone") %>' />
                                                <asp:Label ID="lbContactPhone" runat="server" Text='<%# Eval("contactPhone") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Email:
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="txtEmail" runat="server" Value='<%# Bind("email") %>' />
                                                <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("email") %>' />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="float: left;">
                                    參團人:（多人用,分隔）
                                    <br />
                                    <asp:TextBox ID="txtCustomers" runat="server" Text='<%# Bind("customers") %>' TextMode="MultiLine"
                                        Rows="4" Width="200px" />
                                </div>
                            </fieldset>
                        </td>
                        <td valign="top" width="50%">
                            <fieldset style="height: 140px;">
                                <legend>Order Info</legend>
                                <table cellpadding="2" cellspacing="2" class="detail_view">
                                    <tr>
                                        <td align="right" nowrap="noWrap" width="80">
                                            Pickup:</td>
                                        <td>
                                            <uc1:OmeiTypeSelectorCtl ID="selePickup" TypeName="PickUp" runat="server" SelectedValue='<%# Bind("pickup") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" nowrap="noWrap">
                                            # Adult:
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:TextBox ID="numberAdultTextBox" runat="server" Text='<%# Bind("numberAdult") %>'
                                                Width="35px"></asp:TextBox>
                                            #Child:<asp:TextBox ID="numberChildTextBox" runat="server" Text='<%# Bind("numberChild") %>'
                                                Width="35px"></asp:TextBox>
                                            #Free:<asp:TextBox ID="numberFreeTextBox" runat="server" Text='<%# Bind("numberFree") %>'
                                                Width="35px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" nowrap="noWrap">
                                            # Room:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="bookRoomsTextBox" runat="server" Text='<%# Bind("bookRooms") %>'
                                                Width="50px"></asp:TextBox>
                                            Share with:<asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("roomShare") %>'>
                                                <asp:ListItem Value=" ">未定</asp:ListItem>
                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Price:</td>
                                        <td>
                                            <asp:TextBox ID="txtPriceAdult" runat="server" Text='<%# Bind("priceAdult") %>' Width="80" />/Adult
                                            &nbsp;&nbsp;<asp:TextBox ID="txtPriceChild" runat="server" Text='<%# Bind("priceChild") %>'
                                                Width="80" />/Child
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" nowrap="noWrap" class="prompt">
                                            座位:
                                        </td>
                                        <td class="content" colspan="1">
                                            <asp:Label ID="lbSeatList" runat="server" Text=''></asp:Label></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <fieldset style="height: 185px;">
                                <legend>Others</legend>
                                <table cellpadding="2" cellspacing="2" class="detail_view" width="100%">
                                    <tr>
                                        <td>
                                            Agent inv#:</td>
                                        <td>
                                            <asp:TextBox ID="txtAgentInv" runat="server" Width="200px" Text='<%# Bind("agentInv") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Remark:</td>
                                        <td>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("remark") %>' Width="95%"
                                                Rows="3" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Notes:</td>
                                        <td>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("notes") %>' Width="95%"
                                                Rows="3" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td valign="top">
                            <fieldset style="height: 165px;">
                                <legend>Amount</legend>
                                <table cellpadding="2" cellspacing="2" class="detail_view" width="100%">
                                    <tr>
                                        <td align="right" width="80">
                                            Subtotal $</td>
                                        <td>
                                            <asp:Label ID="lbSubtotal" runat="server" Text='' CssClass="StrongNumber"></asp:Label>
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Discount %</td>
                                        <td>
                                            <uc1:OmeiTypeSelectorCtl ID="lstDiscount" TypeName="Discount" runat="server" SelectedValue='<%# Bind("discount") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="80">
                                            Misc charge $</td>
                                        <td>
                                            <asp:TextBox ID="miscChargeTextBox" runat="server" Text='<%# Bind("miscCharge") %>'
                                                Width="100px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Suggest $&nbsp;</td>
                                        <td>
                                            <asp:Label ID="lbSuggestAmount" runat="server" Text='' CssClass="StrongNumber"></asp:Label>
                                            &nbsp;
                                            <asp:Label ID="lbRecal" runat="server" CssClass="ClickLabel" Text="<<重算"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Actual $</td>
                                        <td>
                                            <asp:TextBox ID="actualAmountTextBox" runat="server" Text='<%# Bind("actualAmount") %>'
                                                Width="100px"></asp:TextBox>
                                            <asp:HiddenField ID="hdSubTotal" runat="server" Value='<%# Bind("fare") %>' />
                                            <asp:HiddenField ID="hdSuggest" runat="server" Value='<%# Bind("suggestAmount") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="toolbox listButtons">
                <ul>
                    <li>
                        <asp:LinkButton ID="btnUpdate1" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Save" /></li>
                    <li><a href="MyOrders.aspx">Cancel</a></li></ul>
            <div style="clear:both"></div></div>
            <div id="window1">
                <div class="floatingWindowContent">
                    <iframe id="frmCustomer" width="100%" height="460" frameborder="0" src='<%# Eval("memberID", "SearchCustomer_pop.aspx?id={0}") %>'>
                    </iframe>
                </div>
            </div>
        </EditItemTemplate>
    </asp:FormView>

    <script type="text/javascript" language="javascript">
initFloatingWindowWithTabs('window1',Array('Select Customer'), 460,700,500,100, true,false,true,false,true);
ShowSearchCustomer("none");
    </script>

</asp:Content>
