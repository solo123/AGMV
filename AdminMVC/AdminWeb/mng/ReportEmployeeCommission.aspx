<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ReportEmployeeCommission" Title="Untitled Page" Codebehind="ReportEmployeeCommission.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li>From:</li><li>
                <uc1:DateInputCtl ID="dateFrom" runat="server"  />
            </li>
            <li>To:</li><li>
                <uc1:DateInputCtl ID="dateTo" runat="server" />
            </li>
            <li>
                Employee:</li><li>
                <asp:DropDownList runat="server" ID="lstEmployee" AutoPostBack="true" DataTextField="employee" DataValueField="empID"></asp:DropDownList>
            </li>
            <li>
                <asp:LinkButton ID="btnQuery" runat="server">Query</asp:LinkButton></li>
        </ul>
    <div style="clear:both"></div></div>
   
    
    <asp:Literal ID="lstReport" runat="server" />
</asp:Content>

