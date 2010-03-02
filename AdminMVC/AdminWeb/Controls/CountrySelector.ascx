<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_CountrySelector" Codebehind="CountrySelector.ascx.cs" %>
<%@ Register Src="DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>
<uc1:DataSelector ID="lstCountry" runat="server" 
    DataTextField="countryName" DataValueField="code" DataSourceID="CountryDataset"
    DefaultValue="" />
<asp:ObjectDataSource ID="CountryDataset" runat="server" OldValuesParameterFormatString="original_{0}" 
    SelectMethod="GetData" TypeName="com.Omei.DLL.DS_CountryTableAdapters.CountryTableAdapter"></asp:ObjectDataSource>
