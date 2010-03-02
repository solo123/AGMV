<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_HotelList" Title="歐美旅遊-酒店管理" Codebehind="HotelList.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    <ul>
        <li><a href="HotelEdit.aspx?new=1">New</a></ul><div style="clear:both"></div>
</div>

<div>
<asp:ObjectDataSource ID="HotelDataset" runat="server" SelectMethod="GetHotelList"
        TypeName="com.Omei.BLL.Admin.HotelBiz" OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="status" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
    <asp:GridView ID="lstHotel" runat="server" AutoGenerateColumns="False" DataKeyNames="hotelID"
        DataSourceID="HotelDataset" SkinID="NormalDataList" Width="100%" OnRowDataBound="lstHotel_RowDataBound">
        <Columns>
            <asp:BoundField DataField="hotelID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="hotelID" />
            <asp:TemplateField HeaderText="Icon" SortExpression="iconID">
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="hotelName" HeaderText="Hotel name" SortExpression="hotelName" />
            <asp:BoundField DataField="starRank" HeaderText="Star" SortExpression="starRank" />
            <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
            <asp:BoundField DataField="priceInfo" HeaderText="Price info" SortExpression="priceInfo" />
            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
        </Columns>
    </asp:GridView> 
</div>
  
</asp:Content>

