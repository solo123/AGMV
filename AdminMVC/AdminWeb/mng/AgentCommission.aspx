<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentCommission" Title="Untitled Page" Codebehind="AgentCommission.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset>
        <asp:FormView ID="fvAgent" runat="server" DataSourceID="AgentDataset">
            <ItemTemplate>
                <table cellpadding="4" cellspacing="4" border="0" class="detail_view">
                    <tr>
                        <td class="prompt">
                            Agent:</td>
                        <td nowrap="nowrap">
                            <span class="head02">[ID:<asp:Literal ID="txtAgentID" runat="server" Text='<%# Eval("agentID") %>' />]
                                &nbsp;
                                <asp:Label ID="txtAgentName" runat="server" Text='<%# Eval("companyName") %>' />
                                /
                                <asp:Label ID="txtAgentName_cn" runat="server" Text='<%# Eval("companyName_cn") %>' />
                            </span>&nbsp;&nbsp; |
                            <asp:HyperLink ID="lnkCompany" runat="server" NavigateUrl='<%# Eval("agentID","CompanyEdit.aspx?id={0}") %>'>Agent Detail</asp:HyperLink>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="prompt">
                            Contact:</td>
                        <td class="content">
                            <asp:Label ID="txtContact" runat="server" Text='<%# Eval("contactPerson") %>' />&nbsp;
                            (Tel:<asp:Label ID="txtTel" runat="server" Text='<%# Eval("telephone") %>' />, Fax:<asp:Label
                                ID="txtFax" runat="server" Text='<%# Eval("fax") %>' />)</td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" class="prompt">
                            Discount:</td>
                        <td class="content" nowrap="nowrap">
                            <asp:Label ID="txtDiscount" runat="server" Text='<%# Eval("discount", "{0}%") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" class="prompt">
                            Balance:
                        </td>
                        <td class="content">
                            <asp:Label ID="txtBalance" runat="server" CssClass="StrongNumber" Text='<%# Eval("balance") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
        <asp:ObjectDataSource ID="AgentDataset" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetAgentInfo" TypeName="com.Omei.BLL.Admin.AgentBiz">
            <SelectParameters>
                <asp:Parameter Name="agentID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </fieldset>
    
    <asp:GridView ID="lstOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="orderID"
        DataSourceID="OrdersDataset" SkinID="DataList" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="Order#">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="lnkOrderID" runat="server" NavigateUrl='<%# Eval("orderID", "OrderDetail.aspx?id={0}") %>'
                        Text='<%# Eval("orderID") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Customer">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbCustomer" runat="server" Text='<%# Eval("customer") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Amount">
                <ItemTemplate>
                    <asp:Label ID="lbAmount" runat="server" Text='<%# Eval("actualAmount") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Commission">
                <ItemTemplate>
                    <asp:TextBox ID="txtAgentCmt" runat="server" Text='<%# Eval("agentCmt") %>' Width="80px"></asp:TextBox>
                    <asp:HiddenField ID="hdAgentCmt" runat="server" Value='<%# Eval("agentCmt") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Net Total">
                <ItemTemplate>
                    <asp:Label ID="lbNetTotal" runat="server" Text='<%# Eval("agentCredit") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Paid">
                <ItemTemplate>
                    <asp:Label ID="lbPay" runat="server" Text='<%# Eval("agentBillAmount") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Balance">
                <ItemTemplate>
                    <asp:Label ID="lbBalance" runat="server" Text='<%# Eval("balance") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="OrdersDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetAgentOrders" TypeName="com.Omei.BLL.Admin.AgentOrderBiz">
        <SelectParameters>
            <asp:Parameter Name="agentID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <div class="toolbox listButtons">
        <ul>
            <li>
                <asp:LinkButton ID="btnSave" runat="server" OnClientClick="javascript:return cfm('您將要修改對應Order的Agent Commission。\n\n確認修改嗎？')" OnClick="btnSave_Click">Update</asp:LinkButton></li>
                <li><a href="AgentOrders.aspx">Cancel</a></li>
                
                </ul>
        <div style="clear:both"></div>
    </div>
    <br />
    <asp:Label ID="lbMsg" runat="server" EnableViewState="false" />
</asp:Content>
