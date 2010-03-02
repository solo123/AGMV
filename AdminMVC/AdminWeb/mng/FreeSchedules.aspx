<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="FreeSchedules" Title="Untitled Page" Codebehind="FreeSchedules.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <div class="toolbox listButtons">
        <ul>
            <li>
                <asp:DropDownList ID="lstFreeTours" runat="server" DataSourceID="FreeTourNameList" DataTextField="tourName" DataValueField="tourID">
                </asp:DropDownList>
                
                <asp:ObjectDataSource ID="FreeTourNameList" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetTourNameList" TypeName="com.Omei.BLL.Admin.AdminTourBiz">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="tourType" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </li>
            <li><a href="TourDetail.aspx?add=1">Add Tour</a></li>
            <li>|</li>
            <li><asp:LinkButton ID="btnAddSchedule" runat="server" Text="Add Schedule" OnClick="btnAddSchedule_Click" /></li></ul>
    <div style="clear:both"></div></div>
    
    <asp:GridView ID="lstSchedule" runat="server" Width="100%" AutoGenerateColumns="False" 
        SkinID="NormalDataList" 
        DataSourceID="FreeScheduleDataset" DataKeyNames="scheduleId" AllowSorting="True" 
        AllowPaging="True" PageSize="300">
        <Columns>
            <asp:TemplateField HeaderText="Schedule ID" SortExpression="scheduleId">
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="lnkScheduleID" runat="server" 
                        NavigateUrl='<%# Eval("scheduleId", "FreeOrders.aspx?id={0}") %>'
                        Text='<%# Eval("scheduleId") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tour name" SortExpression="TourName_cn">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("TourName") %>' /><br />
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("TourName_cn") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="SubTitle" SortExpression="subTitle" DataField="subTitle" />
            <asp:TemplateField HeaderText="Price(Adult/Child)" SortExpression="priceAdult">
                <ItemStyle HorizontalAlign="center" />
                <ItemTemplate>
                    <asp:Label ID="lbPriceAdult" runat="server" Text='<%# Bind("priceAdult") %>'></asp:Label> / 
                    <asp:Label ID="lbPriceChild" runat="server" Text='<%# Bind("priceChild") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="bookCustomers" SortExpression="bookCustomers">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("bookCustomers") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("bookCustomers") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" 
                        NavigateUrl='<%# Eval("scheduleId", "FreeScheduleEdit.aspx?id={0}") %>'
                        Text='<%# OmeiStatus.GetOmeiStatusText("ScheduleStatus",Eval("status"),"en") %>'></asp:HyperLink>                
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="FreeScheduleDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="com.Omei.DLL.DS_SchedulesTableAdapters.FreeSchedulesTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="lstFreeTours" Name="tourID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

