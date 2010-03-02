<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentNewRecv" Title="Untitled Page" Codebehind="AgentNewRecv.aspx.cs" %>

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
                <ItemTemplate>
                    <asp:CheckBox ID="cbSele" runat="server" Text='<%# Eval("orderID") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="Inv #" DataField="agentInv" SortExpression="agentInv" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Customer">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbCustomer" runat="server" Text='<%# Eval("customer") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    Total:</FooterTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Amount" DataField="actualAmount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Commission" DataField="agentCmt">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Net Total" DataField="agentCredit">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Paid" DataField="agentBillAmount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Balance" DataField="balance">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <h3>All orders printed. no new order remain.</h3>
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:ObjectDataSource ID="OrdersDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetAgentUnprintOrders" TypeName="com.Omei.BLL.Admin.AgentOrderBiz">
        <SelectParameters>
            <asp:Parameter Name="agentID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div class="toolbox listButtons">
        <ul>
            <li>
                <asp:CheckBox ID="cbSelectAll" runat="server" AutoPostBack="True" OnCheckedChanged="cbSelectAll_CheckedChanged" Text="Select All" /></li><li>
                <asp:LinkButton ID="btnCreateRecvInvoice" runat="server" OnClick="btnCreateRecvInvoice_Click">Create Receive Invoice</asp:LinkButton></li></ul>
                
       <div style="clear:both"></div> 
    </div>
    <br />
    <asp:Label ID="lbMsg" runat="server" EnableViewState="false" />
</asp:Content>
