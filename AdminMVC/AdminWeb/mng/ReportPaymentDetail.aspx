<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ReportPaymentDetail" Title="Untitled Page" Codebehind="ReportPaymentDetail.aspx.cs" %>
<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li>From:</li><li>
                <uc1:DateInputCtl ID="dateFrom" runat="server" />
            </li>
            <li>To:</li><li>
                <uc1:DateInputCtl ID="dateTo" runat="server" />
                &nbsp;</li><li>
                    <asp:LinkButton ID="btnQuery" runat="server" OnClick="btnQuery_Click">Query</asp:LinkButton>
                </li><li>
                    <a href="ReportPayment.aspx">Daily Payment</a></li><li class="head02">Employee:</li><li>
                <asp:Label ID="lbEmployeeName" runat="server" CssClass="head02" Text=""></asp:Label></li></ul>
    <div style="clear:both"></div></div>
    
    <asp:GridView ID="lstReport" runat="server" DataSourceID="PaymentReportDataset" SkinID="NormalDataList" Width="100%" AutoGenerateColumns="False">
        <Columns>
            <asp:TemplateField HeaderText="Order#">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" target="_blank"
                        Text='<%# Eval("orderID") %>' NavigateUrl='<%# Eval("orderID","OrderDetail.aspx?id={0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Pay Date" DataField="payDate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Amount" DataField="amount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Method" DataField="method" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Remark" DataField="remark" />
            <asp:BoundField HeaderText="Op Employee" DataField="opEmployee" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Receive by" DataField="payEmployee" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="PaymentReportDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetPaymentReportDetail" TypeName="com.Omei.BLL.Admin.PaymentReportBiz">
        <SelectParameters>
            <asp:QueryStringParameter Name="employeeID" QueryStringField="id" Type="Int32" />
            <asp:ControlParameter ControlID="dateFrom" Name="fromDate" PropertyName="DateValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="dateTo" Name="toDate" PropertyName="DateValue"
                Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

