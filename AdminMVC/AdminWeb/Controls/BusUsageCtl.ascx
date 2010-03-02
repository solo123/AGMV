<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_BusUsageCtl" Codebehind="BusUsageCtl.ascx.cs" %>
<asp:ObjectDataSource ID="BusUsageDataset" runat="server" SelectMethod="GetBusUsageList" TypeName="com.Omei.BLL.Admin.AdminBusBiz" DeleteMethod="DelBusUsage" OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter Name="vehicleId" Type="Int32" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="original_usageId" Type="Int32" />
    </DeleteParameters>
</asp:ObjectDataSource>
<asp:GridView ID="lstBusUsage" runat="server" AutoGenerateColumns="False" DataKeyNames="usageId"
    DataSourceID="BusUsageDataset" CellPadding="4">
    <Columns>
        <asp:CommandField ShowDeleteButton=true  DeleteText="Remove" />
        <asp:BoundField DataField="startDate" HeaderText="From" SortExpression="startDate" DataFormatString="{0:d}" HtmlEncode="False" />
        <asp:BoundField DataField="endDate" HeaderText="To" SortExpression="endDate" DataFormatString="{0:d}" HtmlEncode="False" />
    </Columns>
</asp:GridView>
<br />
<table>
    <tr>
        <td nowrap="nowrap">
            From:<asp:TextBox ID="txtStartDate" runat="server" ValidationGroup="VehicleUsageGroup" Width="120px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStartDate"
                ErrorMessage="*" SetFocusOnError="True" ValidationGroup="VehicleUsageGroup"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtStartDate"
                Display="Dynamic" ErrorMessage="日期格式不對" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date" ValidationGroup="VehicleUsageGroup"></asp:CompareValidator></td>
        <td nowrap="nowrap">
            To:<asp:TextBox ID="txtEndDate" runat="server" ValidationGroup="VehicleUsageGroup" Width="120px"></asp:TextBox><asp:RequiredFieldValidator
                ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEndDate" ErrorMessage="*"
                SetFocusOnError="True" ValidationGroup="VehicleUsageGroup"></asp:RequiredFieldValidator><asp:CompareValidator ID="CompareValidator2"
                    runat="server" ControlToValidate="txtEndDate" Display="Dynamic" ErrorMessage="日期格式不對"
                    Operator="DataTypeCheck" SetFocusOnError="True" Type="Date" ValidationGroup="VehicleUsageGroup"></asp:CompareValidator></td>
        <td nowrap="nowrap">
            <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" Enabled='<%# PageLogic.CheckActionAuth("auth_BusNew") %>' ValidationGroup="VehicleUsageGroup" /></td>
    </tr>
</table>
