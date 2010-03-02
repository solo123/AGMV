<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="TourDetail" Title="Untitled Page" Codebehind="TourDetail.aspx.cs" %>

<%@ Register Src="../Controls/TypeSelectorCtl.ascx" TagName="TypeSelectorCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ObjectDataSource ID="TourDetailDataset" runat="server" InsertMethod="InsertTour" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetTourDetail" 
        TypeName="com.Omei.BLL.Admin.AdminTourBiz" DeleteMethod="DelTour" UpdateMethod="UpdateTourDetail" 
        OnInserted="TourDetailDataset_Inserted">
        <SelectParameters>
            <asp:QueryStringParameter Name="tourId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="TourName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="TourName_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="tourOrder" Type="Int32" />
            <asp:Parameter Name="TourDay" Type="Byte" />
            <asp:Parameter Name="Description" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="Description_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="TourType" Type="Byte" />
            <asp:Parameter Name="status" Type="Byte" />
            <asp:Parameter Name="hasSeatTable" Type="Boolean" />
            <asp:Parameter Name="isFloatPrice" Type="Boolean" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_TourID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TourName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="TourName_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="tourOrder" Type="Int32" />
            <asp:Parameter Name="TourDay" Type="Byte" />
            <asp:Parameter Name="Description" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="Description_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="TourType" Type="Byte" />
            <asp:Parameter Name="status" Type="Byte" />
            <asp:Parameter Name="hasSeatTable" Type="Boolean" />
            <asp:Parameter Name="isFloatPrice" Type="Boolean" />
            <asp:Parameter Name="Original_TourID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>

    <asp:FormView ID="fvTourDetail" runat="server" DataSourceID="TourDetailDataset" DataKeyNames="TourID" Width="100%">
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="Update">
                </asp:LinkButton></li><li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="Cancel">
                </asp:LinkButton></li></ul>
            <div style="clear:both"></div></div>
            
            ID:
            <asp:Label ID="TourIDLabel1" runat="server" Text='<%# Eval("TourID") %>'></asp:Label><br />
            <table class="detail_view" style="width: 100%">
                <tr>
                    <td class="prompt" nowrap="nowrap" width="8%">
                        Name:</td>
                    <td width="42%">
            <asp:TextBox ID="TourNameTextBox" runat="server" Text='<%# Bind("TourName") %>' Width="95%"></asp:TextBox></td>
                    <td class="prompt" nowrap="nowrap" width="8%">
                        名稱:</td>
                    <td width="42%">
            <asp:TextBox ID="TourName_cnTextBox" runat="server" Text='<%# Bind("TourName_cn") %>' Width="95%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Description:</td>
                    <td>
            <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Rows="6" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                    <td class="prompt" nowrap="nowrap">
                        說明:</td>
                    <td>
            <asp:TextBox ID="Description_cnTextBox" runat="server" Text='<%# Bind("Description_cn") %>' Rows="6" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Days:</td>
                    <td>
            <asp:TextBox ID="TourDayTextBox" runat="server" Text='<%# Bind("TourDay") %>' Width="100px"></asp:TextBox></td>
                    <td class="prompt" nowrap="nowrap">
                        Type:</td>
                    <td>
                        <uc1:TypeSelectorCtl ID="TypeSelectorCtl1" TypeName="TourType" SelectedValue='<%# Bind("tourType") %>' runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        使用座位表:</td>
                    <td><asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("hasSeatTable") %>' /></td>
                    <td class="prompt">
                        浮动价格:</td>
                    <td>
                        &nbsp;<asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("isFloatPrice") %>' /></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Order:</td>
                    <td>
                        &nbsp;<asp:TextBox ID="tourOrderTextBox" runat="server" Text='<%# Bind("tourOrder") %>' Width="100px"></asp:TextBox></td>
                    <td class="prompt" nowrap="nowrap">
                        Status:</td>
                    <td>
                    <uc1:TypeSelectorCtl ID="TypeSelectorCtl2" TypeName="TourStatus" SelectedValue='<%# Bind("status") %>' runat="server" />
            </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                    Text="Insert">
                </asp:LinkButton></li>
                    <li><asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="Cancel">
                </asp:LinkButton></li>
                </ul>
            <div style="clear:both"></div></div>
            
            ID:
            <asp:Label ID="TourIDLabel1" runat="server" Text='<%# Eval("TourID") %>'></asp:Label><br />
            <table class="detail_view" style="width: 100%">
                <tr>
                    <td class="prompt" nowrap="nowrap" width="8%">
                        Name:</td>
                    <td width="42%">
            <asp:TextBox ID="TourNameTextBox" runat="server" Text='<%# Bind("TourName") %>' Width="95%"></asp:TextBox></td>
                    <td class="prompt" nowrap="nowrap" width="8%">
                        名稱:</td>
                    <td width="42%">
            <asp:TextBox ID="TourName_cnTextBox" runat="server" Text='<%# Bind("TourName_cn") %>' Width="95%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Description:</td>
                    <td>
            <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Rows="6" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                    <td class="prompt" nowrap="nowrap">
                        說明:</td>
                    <td>
            <asp:TextBox ID="Description_cnTextBox" runat="server" Text='<%# Bind("Description_cn") %>' Rows="6" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Days:</td>
                    <td>
            <asp:TextBox ID="TourDayTextBox" runat="server" Text='<%# Bind("TourDay") %>' Width="100px"></asp:TextBox></td>
<td class="prompt" nowrap="nowrap">
                        Type:</td>
                    <td>
                        <uc1:TypeSelectorCtl ID="TypeSelectorCtl1" TypeName="TourType" SelectedValue='<%# Bind("tourType") %>' runat="server" />
                        
                        
                        
                        
                        </td>                </tr>
                
                
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        使用座位表:</td>
                    <td><asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("hasSeatTable") %>' /></td>
                    <td class="prompt">
                        浮动价格:</td>
                    <td>
                        &nbsp;<asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("isFloatPrice") %>' /></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        Order:</td>
                    <td>
                        &nbsp;<asp:TextBox ID="tourOrderTextBox" runat="server" Text='<%# Bind("tourOrder") %>' Width="100px"></asp:TextBox></td>
                    <td class="prompt" nowrap="nowrap">
                        Status:</td>
                    <td>
                    <uc1:TypeSelectorCtl ID="TypeSelectorCtl2" TypeName="TourStatus" SelectedValue='<%# Bind("status") %>' runat="server" />
            </td>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                Text="Edit" Enabled='<%# PageLogic.CheckActionAuth("auth_TourEdit") %>'></asp:LinkButton></li><li><a href="#" onclick="prepareUpload('<%# Eval("TourID") %>');return false;"> Photo </a></li>
                <li><a href='TourDestinations.aspx' visible='<%# PageLogic.CheckPageAuth("TourDestinations.aspx") %>' > 行程錶 </a></li>
                <li><a href='TourSchedule.aspx' visible='<%# PageLogic.CheckPageAuth("TourSchedule.aspx") %>'> Schedule </a></li>
                <li><a href="TourFee.aspx">Tour Fee</a></li></ul>
        <div style="clear:both"></div></div>


            Tour ID:<asp:Label ID="TourIDLabel" runat="server" CssClass="head02" Text='<%# Eval("TourID") %>'></asp:Label><br />
            <table style="width: 100%" class="detail_view">
                <tr>
                    <td class="prompt" width="50%" valign="top">
                        Name:<br />
            <asp:Label ID="TourNameLabel" runat="server" Text='<%# Bind("TourName") %>' CssClass="head02"></asp:Label>
            <asp:Label ID="lbDays" runat="server" Text='<%# DayNights.GetDayNightText(Eval("tourDay"), "en") %>' /></td>
                    <td class="prompt" width="50%" valign="top">
                        名稱:<br />
            <asp:Label ID="TourName_cnLabel" runat="server" Text='<%# Bind("TourName_cn") %>' CssClass="head02"></asp:Label>
            <asp:Label ID="Label1" runat="server" Text='<%# DayNights.GetDayNightText(Eval("tourDay"), "cn") %>' />
            </td>
                </tr>
                <tr>
                    <td class="prompt" valign="top">
                        Description:<br />
            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>' CssClass="content"></asp:Label></td>
                    <td class="prompt" valign="top">
                        說明:<br />
            <asp:Label ID="Description_cnLabel" runat="server" Text='<%# Bind("Description_cn") %>' CssClass="content"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" valign="top">
                        </td>
                    <td class="prompt" valign="top">
                    </td>
                </tr>
                <tr>
                    <td class="prompt" valign="top" colspan="2">
                        <hr />
                        使用座位表:<asp:CheckBox ID="CheckBox1" runat="server" Enabled="false" Checked='<%# Eval("hasSeatTable") %>' />
                        &nbsp;|&nbsp;
                        浮动价格:<asp:CheckBox ID="CheckBox3" runat="server" Enabled="false" Checked='<%# Eval("isFloatPrice") %>' /><br />
                        Show Order:<asp:Label ID="tourOrderLabel" runat="server" Text='<%# Bind("tourOrder") %>' CssClass="content"></asp:Label>
                        &nbsp;|&nbsp;
                        Tour Type:<asp:Label ID="TourTypeLabel" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourType", Eval("TourType"), "en") %>' CssClass="content"></asp:Label>
                        &nbsp;|&nbsp;
                        Status:<asp:Label ID="statusLabel" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourStatus", Eval("status"), "en") %>' CssClass="content"></asp:Label></td>
                </tr>
            </table><br />
            
            <iframe id="frmUploadPhoto" width=0 height=0 scrolling=no frameborder=no src=""></iframe>

        </ItemTemplate>
    </asp:FormView>

<script language=javascript type="text/javascript">
    function prepareUpload(tourId)
    {
        var frm = document.all.frmUploadPhoto;
        if ( frm!=null)
        {
            frm.width = 640;
            frm.height = 160;
            frm.src = "TourPicUpload.aspx?id=" + tourId;
        }
        
    }
</script> 

</asp:Content>

