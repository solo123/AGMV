<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_PubControls_CtlLst_AgentOrders" Codebehind="CtlLst_AgentOrders.ascx.cs" %>
<asp:GridView ID="lstOrder" runat="server" AutoGenerateColumns="False" DataKeyNames="orderId"
        DataSourceID="OrdersDataset" SkinID="DataList" Width="100%" 
        >
        <Columns>
            <asp:TemplateField HeaderText="Order ID" SortExpression="orderId">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkOrder" runat="server" Text='<%# Bind("orderId") %>' NavigateUrl='<%# Eval("orderID","~/OrderDetail.aspx?id={0}") %>' />
                </ItemTemplate>
                <HeaderStyle Width="30px" />
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Schedule ID" SortExpression="scheduleId">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkSchedule" runat="server" Text='<%# Bind("scheduleId") %>' NavigateUrl='<%# Eval("scheduleID","~/ScheduleOrders.aspx?id={0}") %>' />
                </ItemTemplate>
                <HeaderStyle Width="30px" />
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tour Name" SortExpression="tourName">
                <ItemTemplate>
                    <asp:Label ID="lbTourName" runat="server" Text='<%# Eval("tourName") %>' />
                    <br />
                    <asp:Label ID="lbTourNameCn" runat="server" Text='<%# Eval("tourName_cn") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="startDate" DataFormatString="{0:d}" HeaderText="Departure"
                SortExpression="startDate" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
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
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("OrderStatus",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
<asp:ObjectDataSource ID="OrdersDataset" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetMatchedOrders" TypeName="com.Omei.BLL.Admin.IMMatchBiz">
    <SelectParameters>
        <asp:Parameter Name="matchID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
