<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="MyOrders" Title="Untitled Page" Codebehind="MyOrders.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ObjectDataSource ID="OrderDataset" runat="server" SelectMethod="GetEmployeeOrders" 
        TypeName="com.Omei.BLL.Admin.AdminOrderBiz" 
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter Name="employeeID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    

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
            <asp:TemplateField HeaderText="Tour Name" >
                <ItemTemplate>
                    <asp:Label ID="lbTourName" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="startDate" DataFormatString="{0:d}" HeaderText="Departure"
                SortExpression="startDate" HtmlEncode="False" />
            <asp:TemplateField HeaderText="Customer" SortExpression="customerName">
                <ItemTemplate>
                    <asp:Label ID="lbFirstName" runat="server" Text='<%# Eval("firstName") %>' />.
                    <asp:Label ID="lbLastName" runat="server" Text='<%# Eval("lastname") %>' />
                    <br />
                    <asp:Label ID="lbNumAdult" runat="server" Text='<%# Eval("numberAdult") %>' /> Adult,
                    <asp:Label ID="lbNumChild" runat="server" Text='<%# Eval("numberChild") %>' /> Child,
                    <asp:Label ID="lbNumFree" runat="server" Text='<%# Eval("numberFree") %>' /> Free,
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="contactPhone" HeaderText="contactPhone" SortExpression="contactPhone" />
            <asp:BoundField DataField="fromAgent" HeaderText="Agent Recv" SortExpression="fromAgent" />
            <asp:BoundField DataField="toAgent" HeaderText="Agent Transfor" SortExpression="toAgent" />
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("OrderStatus",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

