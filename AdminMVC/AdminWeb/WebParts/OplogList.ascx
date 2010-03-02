<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_OplogList" Codebehind="OplogList.ascx.cs" %>
Operation Log:<br />
<asp:GridView ID="lstOp" runat="server" AutoGenerateColumns="False" DataKeyNames="logID" DataSourceID="logDataset" SkinID="NormalDataList" ShowHeader="False">
    <Columns>
        <asp:BoundField DataField="opDate" HeaderText="Date" SortExpression="opDate" >
            <ItemStyle CssClass="grayText" />
        </asp:BoundField>
        <asp:BoundField DataField="employeeName" HeaderText="Employee" SortExpression="employeeName" >
            <ItemStyle Font-Bold="True" />
        </asp:BoundField>
        <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" HtmlEncode="False" />
    </Columns>
</asp:GridView>
<asp:ObjectDataSource ID="logDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetRelateLog" TypeName="com.Omei.BLL.Admin.OpLogBiz">
    <SelectParameters>
        <asp:Parameter Name="opType" Type="Int32" />
        <asp:Parameter Name="relateID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
