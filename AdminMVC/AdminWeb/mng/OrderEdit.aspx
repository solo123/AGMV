<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="OrderEdit" Title="客户信息" Codebehind="OrderEdit.aspx.cs" %>

<%@ Register Src="../Controls/OmeiTypeSelectorCtl.ascx" TagName="OmeiTypeSelectorCtl"
    TagPrefix="uc1" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc4" %>
<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="top: 24px; left: 400px; position: absolute; border: none;">
        <asp:Label ID="lbMsg" runat="server" ForeColor="Red" Text="" EnableViewState="false"></asp:Label>
    </div>
    <asp:ObjectDataSource ID="OrderDetailDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetOrderDetail" TypeName="com.Omei.BLL.Admin.AdminOrderBiz" UpdateMethod="OrderUpdate"
        OnUpdated="OrderDetailDataset_Updated">
        <SelectParameters>
            <asp:SessionParameter Name="orderId" SessionField="Current_OrderId" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="original_orderId" Type="Int32" />
            <asp:SessionParameter Name="loginUserInfo" Type="Object" SessionField="LoginUserInfo" />
            <asp:Parameter Name="orderType" Type="Int32" DefaultValue="0" />
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
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="CompanyDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCompanyNameList" TypeName="com.Omei.DLL.DS_CompanysTableAdapters.CompanyNameListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="companyType" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="fvOrderDetail" runat="server" DataKeyNames="orderId" DataSourceID="OrderDetailDataset"
        DefaultMode="Edit" OnDataBound="fvOrderDetail_DataBound" Width="100%">
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update" /></li><li><a href="OrderDetail.aspx">Cancel</a></li></ul>
            <div style="clear:both"></div></div>
            <div>
                <table cellpadding="6" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td bgcolor="darkgreen" nowrap="nowrap" style="color: white" align="center">
                            訂單號:<br />
                            <asp:Label ID="lbOrderId" runat="server" Font-Bold="True" Text='<%# Eval("orderId") %>'
                                Font-Size="14pt"></asp:Label></td>
                        <td width="100%">
                            <uc2:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" ScheduleId='<%# Eval("scheduleId") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="darkgreen" colspan="2" height="1">
                        </td>
                    </tr>
                </table>
                <table cellpadding="2" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td valign="top" width="50%">
                            <fieldset style="height: 160px;">
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
                                                <asp:Label ID="lbMemberID" runat="server" Text='<%# Eval("memberID") %>' />
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
                            <fieldset style="height: 160px;">
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
                                            Adult<asp:TextBox ID="txtPriceAdult" runat="server" Text='<%# Bind("priceAdult") %>'
                                                Width="80" Enabled='<%# IsFloatPrice() %>' />
                                            &nbsp;&nbsp;Child<asp:TextBox ID="txtPriceChild" runat="server" Text='<%# Bind("priceChild") %>'
                                                Width="80" Enabled='<%# IsFloatPrice() %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" nowrap="noWrap" class="prompt">
                                            座位:
                                        </td>
                                        <td class="content" colspan="1">
                                            <asp:Label ID="lbSeatList" runat="server" Text='<%# GetSeatList(Eval("orderId")) %>'></asp:Label></td>
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
                                            <asp:TextBox ID="txtRemark" runat="server" Text='<%# Bind("remark") %>' Width="95%"
                                                Rows="3" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Notes:</td>
                                        <td>
                                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Bind("notes") %>' Width="95%"
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
                                            <asp:Label ID="lbSubtotal" runat="server" Text='<%# Eval("fare") %>' CssClass="StrongNumber"></asp:Label>
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
                                            <asp:Label ID="lbSuggestAmount" runat="server" Text='<%# Eval("suggestAmount") %>'
                                                CssClass="StrongNumber"></asp:Label>
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
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update" /></li><li><a href="OrderDetail.aspx">Cancel</a></li></ul>
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
