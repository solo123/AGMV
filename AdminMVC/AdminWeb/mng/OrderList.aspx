<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="OrderList" Title="Untitled Page" Codebehind="OrderList.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div>
    <fieldset>
       <legend>Filter</legend>Schedule ID:<asp:TextBox ID="inpScheduleId" runat="server" Width="60px"></asp:TextBox>
        &nbsp;
        Customer name:<asp:TextBox ID="inpCustName" runat="server" Width="110px"></asp:TextBox>
        &nbsp;
        Contact phone:<asp:TextBox ID="inpPhone" runat="server" Width="110px"></asp:TextBox>&nbsp; 
        <br />
        Status:<asp:DropDownList ID="lstStatus" runat="server">
            <asp:ListItem Selected="True" Value="-1">--All--</asp:ListItem>
            <asp:ListItem Value="0">Web order</asp:ListItem>
            <asp:ListItem Value="1">Hold</asp:ListItem>
            <asp:ListItem Value="2">Sold</asp:ListItem>
            <asp:ListItem Value="3">Full pay</asp:ListItem>
            <asp:ListItem Value="7">Canceled</asp:ListItem>
            <asp:ListItem Value="8">Closed</asp:ListItem>
        </asp:DropDownList>&nbsp;
        Date range:&nbsp;<uc1:DateInputCtl ID="dateFrom" runat="server" />
        &nbsp;
        ~ &nbsp;<uc1:DateInputCtl ID="dateTo" runat="server" />
        &nbsp;


        &nbsp;&nbsp; &nbsp;<asp:Button ID="btnQuery" runat="server" Text="Query" OnClick="btnQuery_Click" />
        <asp:Button ID="btnAllOrders" runat="server" Text="All Orders" OnClick="btnAllOrders_Click" /></fieldset>
</div>


<br />
    <asp:ObjectDataSource ID="OrderDataset" runat="server" SelectMethod="QueryOrders" 
        TypeName="com.Omei.BLL.Admin.AdminOrderBiz" OldValuesParameterFormatString="original_{0}" 
        OnSelecting="OrderDataset_Selecting">
        <SelectParameters>
            <asp:Parameter Name="condition" Type="Object" />
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
            <asp:TemplateField HeaderText="Tour Name">
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
            <asp:BoundField DataField="shortName" HeaderText="Agent" SortExpression="shortName" />
            <asp:BoundField DataField="nickname" HeaderText="Employee" SortExpression="nickname" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="orderDate" HeaderText="Order date" SortExpression="orderDate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("OrderStatus",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

