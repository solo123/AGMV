<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="DayBalance" Title="Untitled Page" Codebehind="DayBalance.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <div align=center>
    <span class="head02">**請註意**</span>
    <div align=left style="width:550px;">
    
    
    請勿在交易時段運行結算功能，結算僅處理今日以前的數據並完成以下事務：<br />
    <table border="1" cellpadding="4" cellspacing="0" class="detail_view" width="100%">
        <tr>
            <td align="center" class="prompt" width="50">1</td>
            <td class="prompt" width="95%">
                Close Schedules;</td>
        </tr>
        <tr>
            <td align="center" width="50">
            </td>
            <td class="content">
                <asp:Label ID="lbPreSchedule" runat="server" Text=""></asp:Label></td>
        </tr>
        <tr>
            <td align="center" class="prompt" width="50">2</td>
            <td class="prompt">
                Close Orders;</td>
        </tr>
        <tr>
            <td align="center" width="50">
            </td>
            <td class="content">
                <asp:Label ID="lbOrderNum" runat="server" Text=""></asp:Label></td>
        </tr>
        <tr>
            <td align="center" class="prompt" width="50">3</td>
            <td class="prompt">
                Auto-gen Schedules;</td>
        </tr>
        <tr>
            <td align="center" width="50">
            </td>
            <td class="content">
                <asp:Label ID="lbAutoGen" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" class="prompt" width="50">
                4</td>
            <td class="prompt">
                Agent Orders;</td>
        </tr>
        <tr>
            <td align="center" width="50">
            </td>
            <td class="content">
                <asp:Label ID="lbAgent" runat="server" CssClass="prompt"></asp:Label></td>
        </tr>
    </table>
    
    </div>
    <br />
    今日日期：<asp:Label ID="lbToday" runat="server" ></asp:Label>
    <asp:Button ID="btnBalanceStart" runat="server" Text="開始結算" 
        OnClick="btnBalanceStart_Click"
        OnClientClick="javascript:return confirm('註意：結算操作不能中斷和撤銷！\n\n已確認今日日期正確，立即開始結算嗎？')" />
    </div>
</asp:Content>

