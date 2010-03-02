<%@ Page Language="C#" AutoEventWireup="true" Inherits="Tools" Codebehind="Tools.aspx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc4" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="btnScheduleStatics" runat="server" Text="Schedule Statics" OnClick="btnScheduleStatics_Click" /><hr />
        <asp:Label ID="lbScheduleStatics" runat="server" Text=""></asp:Label></div>
        
        <uc4:DataSelector ID="agentRecv" runat="server" DataSourceID="CompanyDataset"
                                                DataTextField="companyName" DataValueField="companyId" DefaultValue="0" NoSelectPrompt="--無代理--"
                                                SelectedValue='<%# Bind("agentId") %>' />
        <uc4:DataSelector ID="agentTo" runat="server" DataSourceID="CompanyDataset"
                                                DataTextField="companyName" DataValueField="companyId" DefaultValue="0" NoSelectPrompt="--無代理--"
        
                                                SelectedValue='<%# Bind("agentId") %>' />                                        
        <hr />
        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>                                        
        
        
        <asp:ObjectDataSource ID="CompanyDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCompanyNameList" TypeName="com.Omei.DLL.DS_CompanysTableAdapters.CompanyNameListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="companyType" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </form>
</body>
</html>
