<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="FreeOrders" Title="Untitled Page" Codebehind="FreeOrders.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ObjectDataSource ID="OrderDataset" runat="server" SelectMethod="GetOpenOrdersByScheduleID" 
        TypeName="com.Omei.BLL.Admin.AdminOrderBiz" 
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:QueryStringParameter Name="scheduleID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <div class="toolbox">
        <ul>
            <li>
                <asp:LinkButton ID="btnNewOrder" runat="server" OnClick="btnNewOrder_Click">New Order</asp:LinkButton></li></ul>
    <div style="clear:both"></div></div>
    
    <asp:GridView ID="lstOrder" runat="server" AutoGenerateColumns="False" DataKeyNames="orderId"
        DataSourceID="OrderDataset" SkinID="DataList" Width="100%" 
        OnRowDataBound="lstOrder_RowDataBound" AllowPaging="True" AllowSorting="True" PageSize="100">
        <Columns>
            <asp:BoundField DataField="orderId" HeaderText="Order ID" ReadOnly="True" SortExpression="orderId" >
                <HeaderStyle Width="30px" />
            </asp:BoundField>
            <asp:BoundField DataField="scheduleId" HeaderText="Schedule ID" ReadOnly="True" SortExpression="scheduleId" >
                <HeaderStyle Width="30px" />
            </asp:BoundField>
            <asp:BoundField DataField="tourName" HeaderText="tourName" SortExpression="tourName" />
            <asp:BoundField DataField="startDate" DataFormatString="{0:d}" HeaderText="startDate"
                SortExpression="startDate" HtmlEncode="False" />
            <asp:BoundField DataField="customerName" HeaderText="customerName" SortExpression="customerName" />
            <asp:BoundField DataField="num" HeaderText="num(Ad/Ch)" SortExpression="num" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="contactPhone" HeaderText="contactPhone" SortExpression="contactPhone" />
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("OrderStatus",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>

