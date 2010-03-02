<%@ Page Language="C#" MasterPageFile="../public/AdminContent.master" AutoEventWireup="true" Inherits="OpLog" Title="O'Mei - Operation Log" Codebehind="OpLog.aspx.cs" %>

<%@ Register Src="../Controls/OmeiTypeSelectorCtl.ascx" TagName="OmeiTypeSelectorCtl"
    TagPrefix="uc4" %>
<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc2" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:ObjectDataSource ID="EmployeeDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetEmployeeNameList" TypeName="com.Omei.DLL.DS_EmployeeTableAdapters.EmployeeNameListTableAdapter">
</asp:ObjectDataSource>

<div class="toolbox">
<table>
    <tr>
        <td>
            Employee:<br />
            <uc2:DataSelector ID="seleEmployee" runat="server" AutoPostBack="true"
                DataSourceID="EmployeeDataset" DataTextField="username" 
                DataValueField="employeeId" DefaultValue="0" NoSelectPrompt="-- All --"/>
        </td>
        <td>Type:<br />
            &nbsp;<uc4:OmeiTypeSelectorCtl ID="seleType" runat="server" TypeName="LogType" />
        </td>
        <td>Date from:<br /><uc1:DateInputCtl ID="DateFrom" runat="server" /></td>
        <td>to:<br /><uc1:DateInputCtl ID="DateTo" runat="server" /></td>
        <td>Description:<br />
            <asp:TextBox ID="txtDescription" runat="server" /></td>
        <td>&nbsp;<br />
            <asp:Button ID="btnQuery" runat="server" Text="Query" /></td>
    </tr>
</table>
    <div style="clear:both"></div></div>

    <asp:ObjectDataSource ID="LogDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="Query" TypeName="com.Omei.BLL.Admin.OpLogBiz">
        <SelectParameters>
            <asp:ControlParameter ControlID="seleEmployee" Name="employeeID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="seleType" Name="opType" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DateFrom" Name="startDate" PropertyName="DateValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="DateTo" Name="endDate" PropertyName="DateValue" Type="DateTime" />
            <asp:ControlParameter ControlID="txtDescription" Name="description" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:GridView ID="lstOpLog" runat="server" AutoGenerateColumns="False" DataKeyNames="logID" DataSourceID="LogDataset" SkinID="NormalDataList" Width="100%" AllowPaging="True" PageSize="20">
        <Columns>
            <asp:BoundField DataField="logID" HeaderText="Log#" InsertVisible="False" ReadOnly="True"
                SortExpression="logID" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="employeeName" HeaderText="Employee" SortExpression="employeeName" />
            <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" HtmlEncode="False" />
            <asp:TemplateField HeaderText="Op type" SortExpression="opType">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("LogType", Eval("opType"), "en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="opDate" HeaderText="Date" SortExpression="opDate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="lnkGo" runat="server" NavigateUrl='<%# LogNavUrl() %>'>Go</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    

</asp:Content>

