<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_TypeMultiSelector" Codebehind="TypeMultiSelector.ascx.cs" %>

<asp:CheckBoxList ID="clTypes" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
</asp:CheckBoxList>

<asp:ObjectDataSource ID="typeRefDataset" runat="server" OldValuesParameterFormatString="original_{0}" 
    SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
    <SelectParameters>
        <asp:Parameter Name="listClass" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
