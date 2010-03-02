<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Tours" Title="Untitled Page" Codebehind="Tours.aspx.cs" %>

<%@ Register Src="../Controls/OmeiTypeSingleSelector.ascx" TagName="OmeiTypeSingleSelector"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:ObjectDataSource ID="TourListDataset" runat="server"
    OldValuesParameterFormatString="original_{0}" 
    SelectMethod="GetTourList" TypeName="com.Omei.BLL.Admin.AdminTourBiz">
    <SelectParameters>
        <asp:QueryStringParameter Name="tourType" QueryStringField="tourtype" Type="Int32" />
        <asp:ControlParameter ControlID="cbShow" Name="showOnWeb" PropertyName="Checked" Type="Boolean" />
    </SelectParameters>
</asp:ObjectDataSource>
 
 <div class="toolbox listButtons">
    <table>
        <tr>
            <td><asp:HyperLink ID="lnkNew" Text="Add New" runat="server" Enabled='<%# PageLogic.CheckActionAuth("auth_TourNew") %>' NavigateUrl="TourDetail.aspx?add=1" /></td>
            <td><asp:CheckBox ID="cbShow" runat="server" Text="Show on OmeiTravel.com" AutoPostBack="true" Checked="true" /></td>
        </tr>
    </table>
 <div style="clear:both"></div></div>
 <div style="clear:both;">
    <asp:GridView ID="lstTourList" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" DataKeyNames="TourID" DataSourceID="TourListDataset"
        SkinID="DataList" Width="100%" OnRowDataBound="lstTourList_RowDataBound" PageSize="100" 
        >
        <Columns>
            <asp:BoundField DataField="TourID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="TourID" >
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Name" SortExpression="TourName">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" CssClass="TourName" Text='<%# Eval("TourName_cn") %>'></asp:Label>
                    <asp:Label ID="Label5" runat="server" Text='<%# DayNights.GetDayNightText(Eval("tourDay"), "cn") %>' />
                    <br />
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("TourName") %>'></asp:Label>
                    <asp:Label ID="lbDays" runat="server" Text='<%# DayNights.GetDayNightText(Eval("tourDay"), "en") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Day" SortExpression="TourDay">
                <ItemStyle Wrap="False" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Literal ID="lbDay" runat="server" Text='<%# Eval("TourDay") %>'></asp:Literal>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Price(Adult/Child)" SortExpression="priceAdult">
                <ItemStyle Wrap="False" HorizontalAlign="Center" />
                <HeaderStyle Wrap="False" />
                <ItemTemplate>
                    $<asp:Literal ID="lbpa" runat="server" Text='<%# Eval("priceAdult") %>'></asp:Literal>
                    / $<asp:Literal ID="lbpc" runat="server" Text='<%# Eval("priceChild") %>'></asp:Literal>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="weekly" HeaderText="Take off" SortExpression="weekly" >
                <ItemStyle Wrap="False" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Type" SortExpression="tourType">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourType", Eval("tourType"), "en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourStatus",Eval("status"), "en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </div>      
    
</asp:Content>

