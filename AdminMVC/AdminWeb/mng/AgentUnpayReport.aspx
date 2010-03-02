<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentUnpayReport" Title="Untitled Page" Codebehind="AgentUnpayReport.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox">
    Agent:<asp:DropDownList ID="seleAgent" runat="server" AutoPostBack="True" DataSourceID="HaveOrdersAgentDataset" DataTextField="companyName" DataValueField="companyId">
    </asp:DropDownList>
    &nbsp;
    <asp:Button ID="btnPay" Text="Agent Payment" runat="server" OnClick="btnPay_Click" />
    <asp:ObjectDataSource ID="HaveOrdersAgentDataset" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetHaveOrdersAgents"
        TypeName="com.Omei.BLL.Admin.AdminCompanyBiz">
    </asp:ObjectDataSource>
    <div style="clear:both"></div>
</div>

<asp:GridView ID="lstAgentBills" runat="server" AutoGenerateColumns="False" DataSourceID="AgentBillDataset" SkinID="DataList" Width="100%">
    <Columns>
        <asp:BoundField DataField="reportDate" HeaderText="Bill Date" SortExpression="reportDate" DataFormatString="{0:d}" HtmlEncode="False" >
            <ItemStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="orderCount" HeaderText="Count" ReadOnly="True" SortExpression="orderCount" >
            <ItemStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="agentReceivable" HeaderText="Total Receivable" ReadOnly="True"
            SortExpression="agentReceivable" >
            <ItemStyle HorizontalAlign="Right" />
        </asp:BoundField>
        <asp:BoundField DataField="agentPaid" HeaderText="Total Paid" ReadOnly="True" SortExpression="agentPaid" >
            <ItemStyle HorizontalAlign="Right" />
        </asp:BoundField>
    </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AgentBillDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetAgentBills" TypeName="com.Omei.DLL.DS_AgentTableAdapters.AgentBillsTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="seleAgent" Name="agentID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>


</asp:Content>

