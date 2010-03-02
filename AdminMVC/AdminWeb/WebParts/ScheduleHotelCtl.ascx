<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_ScheduleHotelCtl" Codebehind="ScheduleHotelCtl.ascx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>

<asp:ObjectDataSource ID="HotelDataset" runat="server" OldValuesParameterFormatString="original_{0}" 
    SelectMethod="GetData" TypeName="com.Omei.DLL.DS_CompanysTableAdapters.HotelListTableAdapter"></asp:ObjectDataSource>

<asp:GridView ID="lstHotels" runat=server AutoGenerateColumns="False" DataKeyNames="scheduleHotelID" DataSourceID="ScheduleHotelDataset" ShowFooter="True" ShowHeader="False">

    <EmptyDataTemplate>
        <asp:LinkButton ID="btnAdd" runat="server" OnClick="btnAdd_Click">Add hotels</asp:LinkButton>
    </EmptyDataTemplate>
    
    <Columns>
        <asp:TemplateField HeaderText="night" SortExpression="night">
            <ItemTemplate>
                第<asp:Literal ID="txtNight" runat=server Text='<%# Eval("night") %>' />晚
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="hotelID" SortExpression="hotelID">
            <ItemTemplate>
                <asp:HiddenField ID="hdScheduleHotelID" runat="server" Value='<%# Eval("scheduleHotelID") %>' />
                <uc1:DataSelector ID="seleHotel" runat="server" SelectedValue='<%# Eval("hotelID") %>' 
                    DataSourceID="HotelDataset" DataTextField="companyName" DataValueField="companyId" />
            </ItemTemplate>
            
            <FooterTemplate>
                <asp:LinkButton ID="btnDel" runat="server" OnClick="btnDel_Click">Reset</asp:LinkButton> | 
                <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click">Save</asp:LinkButton>            
            </FooterTemplate>
        </asp:TemplateField>
    </Columns>
    
</asp:GridView>

<asp:ObjectDataSource ID="ScheduleHotelDataset" runat="server" DeleteMethod="DeleteScheduleHotel"
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetScheduleHotel"
    TypeName="com.Omei.DLL.DS_HotelsTableAdapters.ScheduleHotelTableAdapter" >
    <DeleteParameters>
        <asp:Parameter Name="scheduleID" Type="Int32" />
    </DeleteParameters>
    <SelectParameters>
        <asp:Parameter Name="scheduleID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
