<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ReportAgentSummary" Title="Untitled Page" Codebehind="ReportAgentSummary.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:GridView ID="lstAgentSummary" runat="server" AutoGenerateColumns="False" DataSourceID="AgentSummaryDataset" SkinID="NormalDataList" Width="100%" OnRowDataBound="lstAgentSummary_RowDataBound" ShowFooter="True">
        <Columns>
            <asp:TemplateField HeaderText="companyName" SortExpression="companyName">
                <ItemTemplate>
                    <asp:Label ID="lbCompanyName" runat="server" Text='<%# Bind("companyName") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lbCompanyName_cn" runat="server" Text='<%# Eval("companyName_cn") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbPrompt" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Receivable" SortExpression="agentReceivable">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("agentReceivable") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="right" />
                <FooterTemplate>
                    <asp:Label ID="lbTotReceivable" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount" SortExpression="additionalDiscount">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("additionalDiscount") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="right" />
                <FooterTemplate>
                    <asp:Label ID="lbTotDiscount" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actual Receivable">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbActualReceivable" runat="server" />
                </ItemTemplate>
                <FooterStyle HorizontalAlign="right" />
                <FooterTemplate>
                    <asp:Label ID="lbTotActualReceivable" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Paid" SortExpression="agentPaid">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("agentPaid") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="right" />
                <FooterTemplate>
                    <asp:Label ID="lbTotPaid" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Balance">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbBalance" runat="server" />
                </ItemTemplate>
                <FooterStyle HorizontalAlign="right" />
                <FooterTemplate>
                    <asp:Label ID="lbTotBalance" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AgentSummaryDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetAgentTotal" TypeName="com.Omei.DLL.DS_AgentTableAdapters.AgentTotalTableAdapter">
    </asp:ObjectDataSource>

</asp:Content>

