<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ReportPayment" Title="Untitled Page" Codebehind="ReportPayment.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li>Date:</li><li>
                <uc1:DateInputCtl ID="dateFrom" runat="server"  />
            </li>
            <li>
                <asp:Button ID="btnQuery" runat="server" Text="Query" OnClick="btnQuery_Click" /></li><li>
            </li>
        </ul>
    <div style="clear:both"></div></div>
    
    
    <asp:GridView ID="lstReport" runat="server" DataSourceID="PaymentReportDataset" SkinID="DataList" Width="100%" 
    AutoGenerateColumns="False" OnRowDataBound="lstReport_RowDataBound" DataKeyNames="empID,reason">
        <Columns>
            <asp:BoundField HeaderText="empID" DataField="empID" />
            <asp:TemplateField HeaderText="Employee Name">
                <ItemTemplate>
                    <asp:Label ID="lbEmployeeName" runat="server" Text='<%# Eval("nickname") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="Reason" DataField="reason" >
                <ItemStyle ForeColor="Red" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Cash" DataField="cash" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Credit Card" DataField="creditCard" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Check" DataField="check" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Agent" DataField="agent" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    
    
    <asp:ObjectDataSource ID="PaymentReportDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDailyReport" TypeName="com.Omei.BLL.Admin.PaymentReportBiz">
        <SelectParameters>
            <asp:ControlParameter ControlID="dateFrom" Name="date" PropertyName="DateValue"
                Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

