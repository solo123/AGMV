<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_HotelListCtl" Codebehind="HotelListCtl.ascx.cs" %>

<asp:Repeater ID="lstHotel" runat="server" DataSourceID="HotelDataset">
    <HeaderTemplate>
        <table width="100%" border="1" style="border-collapse:collapse;" class="detail_view">
    </HeaderTemplate>
    
    <ItemTemplate>
            <tr>
                <td class="prompt1" align=center>第<%# Eval("night") %>晚</td>
                <td align=left>
                    <span class="prompt1">Hotel:</span><asp:Label ID="Label2" runat="server" Text='<%# Eval("companyName") %>' CssClass="content" />|
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("companyName_cn") %>'></asp:Label>
                    <span class="prompt1">Address:</span><asp:Label ID="Label3" runat="server" Text='<%# Eval("Address") %>' CssClass="content" />
                    <br />
                    <span class="prompt1">Contact:</span><asp:Label ID="Label4" runat="server" Text='<%# Eval("contactPerson") %>' CssClass="content" />
                    <span class="prompt1">Tel:</span><asp:Label ID="Label5" runat="server" Text='<%# Eval("telephone") %>' CssClass="content" />
                    <span class="prompt1">Fax:</span><asp:Label ID="Label6" runat="server" Text='<%# Eval("Fax") %>' CssClass="content" />
                </td>
            </tr>
    </ItemTemplate>
    
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>
<asp:ObjectDataSource ID="HotelDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetHotelList" TypeName="com.Omei.DLL.DS_HotelsTableAdapters.ScheduleHotelDetailListTableAdapter">
    <SelectParameters>
        <asp:Parameter Name="scheduleID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
