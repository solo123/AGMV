<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_FlightsList" Title="歐美旅遊-機票" Codebehind="FlightsList.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    <ul>
        <li>
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td><a href="FlightEdit.aspx?new=1" visible='<%# PageLogic.CheckActionAuth("FlightAddNew") %>'>New</a></td>
                <td>&nbsp;</td>
                <td>(</td>
                <td><asp:RadioButtonList ID="lstStatus" runat="server" AutoPostBack="true" RepeatDirection="Horizontal">
                <asp:ListItem Text="Show" Selected="True" Value="1" />
                <asp:ListItem Text="Hide" Value="0" />
            </asp:RadioButtonList></td>
                <td>) on website.</td>
            </tr>
        </table>
            </li></ul><div style="clear:both"></div>
</div>

<div>
<asp:ObjectDataSource ID="FlightsDataset" runat="server" SelectMethod="GetFlights"
        TypeName="com.Omei.BLL.Admin.FlightBiz" OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:ControlParameter ControlID="lstStatus" Name="status" PropertyName="SelectedValue"
            Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

    <asp:GridView ID="lstFlights" runat="server" AutoGenerateColumns="False" DataKeyNames="flightId"
        DataSourceID="FlightsDataset" SkinID="DataList" Width="100%" OnRowDataBound="lstFlights_RowDataBound">
        <Columns>
            <asp:BoundField DataField="flightId" HeaderText="ID" InsertVisible="False"
                ReadOnly="True" SortExpression="flightId" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="airportFrom" HeaderText="From" SortExpression="airportFrom" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="airportTo" HeaderText="To" SortExpression="airportTo" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="airline" HeaderText="Airline" SortExpression="airline" />
            <asp:BoundField DataField="flight" HeaderText="Flight" SortExpression="flight" />
            <asp:TemplateField HeaderText="R/N" SortExpression="roundTrip">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("roundTrip") %>' Enabled="false" />/
                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("nonStop") %>' Enabled="false" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Price" SortExpression="priceAdult">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("priceAdult") %>'></asp:Label> /
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("priceChild") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView> 
    <br />
</div>

</asp:Content>

