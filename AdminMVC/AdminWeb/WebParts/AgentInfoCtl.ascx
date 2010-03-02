<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_AgentInfoCtl" Codebehind="AgentInfoCtl.ascx.cs" %>
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
                            <asp:HyperLink ID="lnkCompany" runat="server" NavigateUrl='<%# Eval("agentID","../CompanyEdit.aspx?id={0}") %>'>Agent Detail</asp:HyperLink>
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