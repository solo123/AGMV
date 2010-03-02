<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ScheduleOrders" Title="Untitled Page" Codebehind="ScheduleOrders.aspx.cs" %>

<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<asp:ObjectDataSource ID="OrderDataset" runat="server" SelectMethod="GetOrdersByScheduleID" 
        TypeName="com.Omei.BLL.Admin.AdminOrderBiz" 
        OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter Name="scheduleID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
    
    <uc1:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" />
    <hr />

    <div class="toolbox listButtons">
        <ul>
            <li>
                <asp:LinkButton ID="btnNewOrder" runat="server" OnClick="btnNewOrder_Click">New Order</asp:LinkButton></li><li>
                    <asp:Label ID="txtMsg" runat="server" ForeColor="red" /></li></ul>
    <div style="clear:both"></div></div>
    
    <asp:GridView ID="lstOrder" runat="server" AutoGenerateColumns="False" DataKeyNames="orderId"
        DataSourceID="OrderDataset" SkinID="DataList" Width="100%" 
        OnRowDataBound="lstOrder_RowDataBound" AllowPaging="True" AllowSorting="True" PageSize="100">
        <Columns>
            <asp:TemplateField HeaderText="Order#" InsertVisible="False" SortExpression="orderId">
                <ItemStyle HorizontalAlign="Center" Font-Bold="True" />
                <ItemTemplate>
                    <asp:HyperLink ID="lnkOrderID" NavigateUrl='<%# Eval("orderId","OrderDetail.aspx?id={0}") %>' Text='<%# Bind("orderId") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Customer" SortExpression="firstName">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("firstName") %>'></asp:Label>.
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("lastName") %>'></asp:Label> 
                    <br />
                    <asp:Label ID="lbNumAdult" runat="server" Text='<%# Bind("numberAdult") %>'></asp:Label> adult, 
                    <asp:Label ID="lbNumChild" runat="server" Text='<%# Bind("numberChild") %>'></asp:Label> child,
                    <asp:Label ID="lbNumFree" runat="server" Text='<%# Bind("numberFree") %>'></asp:Label> free,
                    <asp:Label ID="lbRooms" runat="server" Text='<%# Bind("bookRooms") %>'></asp:Label> room /
                    <asp:Label ID="lbShare" runat="server" Text='<%# Eval("roomShare") %>' />
                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="actualAmount" HeaderText="Amount" SortExpression="actualAmount" />
            <asp:BoundField DataField="balance" HeaderText="Balance" SortExpression="balance" />
            <asp:TemplateField HeaderText="Tel" SortExpression="contactPhone">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("contactPhone") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Employee" SortExpression="empId">
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("nickname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Agent" DataField="shortName" SortExpression="shortName" />
            <asp:TemplateField HeaderText="Pickup">
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# ShowPickup(Eval("pickup")) %>'></asp:Label>
                    <asp:Literal ID="Literal2" runat="server" Text='<%# ShowEmailIcon(Eval("email")) %>'></asp:Literal>
                    <asp:Literal ID="Literal1" runat="server" Text='<%# ShowAgentIcon(Eval("agentId")) %>'></asp:Literal>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <br />
            &nbsp;Empty ...
        </EmptyDataTemplate>
    </asp:GridView>


</asp:Content>

