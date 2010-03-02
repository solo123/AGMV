<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_OmeiStatusSelectorCtl" Codebehind="OmeiStatusSelectorCtl.ascx.cs" %>
<asp:DropDownList ID="lstStatus" runat="server" DataSourceID="StatusDataset" DataTextField="listTitle" DataValueField="listValue">
</asp:DropDownList><asp:ObjectDataSource ID="StatusDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetValidListValue" TypeName="com.Omei.BLL.Admin.TypeRefBiz">
    <SelectParameters>
        <asp:Parameter Name="listClass" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
