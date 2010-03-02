<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" 
    Inherits="AgentRecvInvoiceList" Title="Untitled Page" Codebehind="AgentRecvInvoiceList.aspx.cs" %>

<%@ Register Src="../WebParts/AgentInfoCtl.ascx" TagName="AgentInfoCtl" TagPrefix="uc2" %>

<%@ Register Src="../Controls/OmeiTypeSelectorCtl.ascx" TagName="OmeiTypeSelectorCtl"
    TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    <ul>
        <li>Invoice ID:</li><li>
            <asp:TextBox ID="txtInvoiceID" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Please input invoice ID." ControlToValidate="txtInvoiceID" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator></li><li>
            <asp:LinkButton ID="btnGo" runat="server" OnClick="btnGo_Click">Goto invoice detail</asp:LinkButton>
        </li>
        </ul>
        <div style="clear:both"></div>
</div>
    
    <uc2:AgentInfoCtl ID="AgentInfoCtl1" runat="server" />

    <asp:GridView ID="lstInvoice" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="recvInvID" DataSourceID="InvoiceDataset" OnRowDataBound="lstInvoice_RowDataBound" SkinID="NormalDataList" Width="100%" AllowPaging="True" PageSize="50" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="recvInvID" HeaderText="Invoice ID" InsertVisible="False"
                ReadOnly="True" SortExpression="recvInvID" >
                <ItemStyle HorizontalAlign="Center" Font-Bold="True" ForeColor="Blue" />
            </asp:BoundField>
            <asp:BoundField DataField="shortName" HeaderText="Agent" SortExpression="shortName" />
            <asp:BoundField DataField="actualAmount" HeaderText="Amount" SortExpression="actualAmount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="agentCmt" HeaderText="Commission" SortExpression="agentCmt" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="agentCredit" HeaderText="Net total" SortExpression="agentCredit" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="agentBillAmount" HeaderText="Paid" SortExpression="agentBillAmount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="createDate" HeaderText="Created" SortExpression="createDate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="lastUpdate" HeaderText="Updated" SortExpression="lastUpdate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="InvoiceDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="AgentRecvInvoices" TypeName="com.Omei.BLL.Admin.AgentOrderBiz">
        <SelectParameters>
            <asp:QueryStringParameter Name="agentID" QueryStringField="agent" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>


</asp:Content>

