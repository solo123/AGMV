<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" 
    AutoEventWireup="true" Inherits="Admin_BusEdit" 
    Title="Untitled Page" EnableEventValidation="false" Codebehind="BusEdit.aspx.cs" %>

<%@ Register Src="../Controls/BusUsageCtl.ascx" TagName="BusUsageCtl" TagPrefix="uc2" %>
<%@ Register Src="../Controls/NotesCtl.ascx" TagName="NotesCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    <ul>
        <li><a href="BusList.aspx">返囬</a></li><li><asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" Enabled='<%# PageLogic.CheckActionAuth("auth_BusEdit") %>' >保存</asp:LinkButton></li><li><asp:LinkButton ID="btnDelete" runat="server" 
            OnClick="btnDelete_Click"  Enabled='<%# PageLogic.CheckActionAuth("auth_BusDel") %>'
            OnClientClick="javascript:return confirm('刪除操作不能恢復!\n\n如果您是需要此數據不顯示在網站上，可以通過調整狀態標誌達到目的。\\n\\n您確認還是要刪除嗎？');" >刪除</asp:LinkButton></li><li><asp:Label ID="txtToolMessage" runat="server" ForeColor="Red"></asp:Label></li></ul>
<div style="clear:both"></div></div>
    
    <table style="width: 100%">
        <tr>
            <td colspan="4">
            汽車編號:<asp:Literal ID="txtVehicleId" runat="server"></asp:Literal>
            <hr />
            </td>
        </tr>
        <tr>
            <td align="right" width="15%">
                汽車名:</td>
            <td width="35%">
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox></td>
            <td align="right" width="15%">
                車型:</td>
            <td width="35%">
                <asp:DropDownList ID="lstVehicleType" runat="server" DataSourceID="BusTypeDataset" DataTextField="listTitle_cn" DataValueField="listValue">
                </asp:DropDownList>&nbsp;
                <asp:ObjectDataSource ID="BusTypeDataset" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="BusType" Name="listClass" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                客位數:</td>
            <td>
                <asp:TextBox ID="txtSeatNum" runat="server"></asp:TextBox></td>
            <td align="right">
                檢查日期:</td>
            <td>
                <asp:TextBox ID="txtInspDate" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="right">
                Plate:</td>
            <td>
                <asp:TextBox ID="txtPlate" runat="server"></asp:TextBox></td>
            <td align="right">
                VIN:</td>
            <td>
                <asp:TextBox ID="txtVin" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="right">
                自有车:</td>
            <td>
                <asp:CheckBox ID="chkOwn" runat="server" /></td>
            <td align="right">
                狀態:</td>
            <td>
                <asp:CheckBox ID="chkStatus" runat="server" /></td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td>
                說明:<br />
                &nbsp;
                <asp:TextBox ID="txtNotes" runat="server" Rows="4" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
        </tr>
    </table>
    <uc2:BusUsageCtl ID="lstBusUsage" runat="server" />



</asp:Content>

