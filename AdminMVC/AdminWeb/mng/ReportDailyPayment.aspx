<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ReportDailyPayment" Title="Untitled Page" Codebehind="ReportDailyPayment.aspx.cs" %>
<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox">
<table>
    <tr>
        <td>Date:</td>
        <td>
            <uc1:DateInputCtl ID="DateInputCtl1" runat="server" /></td>
        <td>
            <asp:Button ID="btnQry" runat="server" Text="Query" /></td>
    </tr>
</table>
<div style="clear:both"></div>    
</div>

    <asp:GridView ID="lstPayment" runat="server" AutoGenerateColumns="False" DataKeyNames="paymentId" DataSourceID="PaymentDataset" SkinID="NormalDataList" Width="100%">
        <Columns>
            <asp:BoundField DataField="paymentId" HeaderText="PID" InsertVisible="False"
                ReadOnly="True" SortExpression="paymentId" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="amount" HeaderText="Amount" SortExpression="amount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Method" SortExpression="method">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("PaymentMethod",Eval("method"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Reason" SortExpression="reason">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("PaymentReason", Eval("reason"), "en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="payDate" HeaderText="Date" SortExpression="payDate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="remark" HeaderText="Remark" SortExpression="remark" HtmlEncode="false" />
            <asp:BoundField DataField="employeeName" HeaderText="Receive by" ReadOnly="True"
                SortExpression="employeeName" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="opEmpName" HeaderText="Employee" ReadOnly="True" SortExpression="opEmpName" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="PaymentDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetPaymentsByDay" TypeName="com.Omei.BLL.Admin.AdminPaymentBiz">
        <SelectParameters>
            <asp:ControlParameter ControlID="DateInputCtl1" Name="date" PropertyName="DateValue" Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
</asp:Content>

