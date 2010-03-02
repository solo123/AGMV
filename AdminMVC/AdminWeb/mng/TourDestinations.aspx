<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="TourDestinations" Title="Untitled Page" Codebehind="TourDestinations.aspx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lbTourName" runat="server" CssClass="head02"></asp:Label>
    
    <asp:GridView ID="lstTourDest" runat="server" AutoGenerateColumns="False" DataSourceID="TourDayDestDataset" 
        OnRowDataBound="lstTourDest_RowDataBound" Width="100%" DataKeyNames="tourDestId" SkinID="DataList" OnSelectedIndexChanged="lstTourDest_SelectedIndexChanged" 
        >
        <Columns>
            <asp:CommandField SelectText="" ShowSelectButton="True" UpdateImageUrl="~/Images/master/white.gif" />
            <asp:BoundField DataField="visitDate" HeaderText="Day" SortExpression="visitDate" />
            <asp:BoundField DataField="visitOrder" HeaderText="order" SortExpression="visitOrder" />
            <asp:BoundField DataField="DestinationName_cn" HeaderText="Destination" SortExpression="DestinationName_cn" />
            <asp:BoundField DataField="description" HeaderText="Description" ReadOnly="True"
                SortExpression="description" />
            <asp:BoundField DataField="description_cn" HeaderText="說明" ReadOnly="True" SortExpression="description_cn" />
        </Columns>
    </asp:GridView>
    
    <asp:ObjectDataSource ID="TourDayDestDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetTourDayDestList" TypeName="com.Omei.DLL.DS_TourDayDestTableAdapters.tourDestListTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="tourId" Type="Int32" QueryStringField="id" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <br />
    
    <asp:FormView ID="fvTourDayDest" runat="server" CellPadding="4" CellSpacing="2" DataKeyNames="tourDestId"
        DataSourceID="TourDayDestDetailDataset" Width="100%" OnItemDeleted="fvTourDayDest_ItemDeleted" 
        OnItemInserted="fvTourDayDest_ItemInserted" OnItemUpdated="fvTourDayDest_ItemUpdated" 
        >
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:Button ID="btnUpdate" runat="server" CommandName="update" Text="Update" /></li><li><asp:Button ID="btnCancel" runat="server" CommandName="cancel" Text="Cancel" /></li></ul>
            <div style="clear:both"></div></div>

            <table style="width: 100%" class="detail_view">
                <tr>
                    <td align="left" width="15%" class="prompt" nowrap="noWrap">
                        景點:</td>
                    <td align="left" colspan="3">
                        <asp:DropDownList ID="lstDest" runat="server" DataSourceID="DestDataset" DataTextField="destinationName"
                            DataValueField="destinationID" SelectedValue='<%# Bind("destinationId") %>'>
                        </asp:DropDownList>
                        
</td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="noWrap" width="10%">
                        參觀日:</td>
                    <td align="left" width="40%">
                        <asp:TextBox ID="visitDateTextBox" runat="server" Text='<%# Bind("visitDate") %>'>
            </asp:TextBox></td>
                    <td align="left" class="prompt" nowrap="noWrap" width="10%">
                        參觀順序:</td>
                    <td align="left" width="40%">
                        <asp:TextBox ID="visitOrderTextBox" runat="server" Text='<%# Bind("visitOrder") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" colspan="2" valign="top" class="prompt">
                        description:
                        <br />
                        <asp:TextBox ID="descriptionTextBox" runat="server" Rows="8" Text='<%# Bind("description") %>'
                            TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                    <td align="left" colspan="2" valign="top" class="prompt">
                        說明:<br />
                        <asp:TextBox ID="description_cnTextBox" runat="server" Rows="8" Text='<%# Bind("description_cn") %>'
                            TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
            </table>
        </EditItemTemplate>
        <ItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="btnEdit" CommandName="Edit" runat="server" Enabled='<%# PageLogic.CheckActionAuth("auth_TourDestEdit") %>'>Edit</asp:LinkButton></li><li><asp:LinkButton ID="btnAdd" CommandName="New" runat="server" Enabled='<%# PageLogic.CheckActionAuth("auth_TourDestNew") %>'>New</asp:LinkButton></li><li><asp:LinkButton ID="btnDel" CommandName="delete" Enabled='<%# PageLogic.CheckActionAuth("auth_TourDestDel") %>' 
                        OnClientClick="javascript:return confirm('刪除操作不能恢復!\n\n如果您是需要此數據不顯示在網站上，可以通過調整狀態標誌達到目的。\n\n您確認還是要刪除嗎？');" runat="server">Delete</asp:LinkButton></li></ul>
            <div style="clear:both"></div></div>

            <table style="width: 100%" class="detail_view">
                <tr>
                    <td align="left" width="15%" class="prompt" nowrap="noWrap">
                        景點:</td>
                    <td align="left" class="content" colspan="3">
                        <asp:Label ID="destinationIdLabel" runat="server" Text='<%# Bind("destinationId") %>'>
            </asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="noWrap" width="10%">
                        參觀日:</td>
                    <td align="left" class="content" width="40%">
                        <asp:Label ID="visitDateLabel" runat="server" Text='<%# Bind("visitDate") %>'></asp:Label></td>
                    <td align="left" class="prompt" nowrap="noWrap" width="10%">
                        參觀順序:</td>
                    <td align="left" class="content" width="40%">
                        <asp:Label ID="visitOrderLabel" runat="server" Text='<%# Bind("visitOrder") %>'>
            </asp:Label></td>
                </tr>
                <tr>
                    <td align="left" colspan="2" valign="top" class="prompt">
                        description:
                        <hr />
                        <asp:Label ID="descriptionLabel" runat="server" Text='<%# Bind("description") %>' CssClass="content"></asp:Label></td>
                    <td align="left" colspan="2" valign="top" class="prompt">
                        說明:<hr />
                        <asp:Label ID="description_cnLabel" runat="server" Text='<%# Bind("description_cn") %>' CssClass="content"></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
        <InsertItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                    Text="Insert">
                </asp:LinkButton></li>
                    
                </ul>
            <div style="clear:both"></div></div>

            <table style="width: 100%" class="detail_view">
                <tr>
                    <td align="left" width="15%" class="prompt" nowrap="noWrap">
                        景點:</td>
                    <td align="left" colspan="3">
                    
                        
                        
                        <asp:DropDownList ID="lstDest" runat="server" DataSourceID="DestDataset" 
                        DataTextField="destinationName"
                            DataValueField="destinationID" SelectedValue='<%# Bind("destinationId") %>'>
                        </asp:DropDownList>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="noWrap" width="10%">
                        參觀日:</td>
                    <td align="left" width="40%">
                        <asp:TextBox ID="visitDateTextBox" runat="server" Text='<%# Bind("visitDate") %>'>
            </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="visitDateTextBox"
                            Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="visitDateTextBox"
                            Display="Dynamic" ErrorMessage="必須是數字" Operator="DataTypeCheck" SetFocusOnError="True"
                            Type="Integer"></asp:CompareValidator></td>
                    <td align="left" class="prompt" nowrap="noWrap" width="10%">
                        參觀順序:</td>
                    <td align="left" width="40%">
                        &nbsp;<asp:TextBox ID="visitOrderTextBox" runat="server" Text='<%# Bind("visitOrder") %>'>
            </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="visitOrderTextBox"
                            Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="visitOrderTextBox"
                            Display="Dynamic" ErrorMessage="必須是數字" Operator="DataTypeCheck" SetFocusOnError="True"
                            Type="Integer" ValidationGroup="TourDestAddGroup"></asp:CompareValidator></td>
                </tr>
                <tr>
                    <td align="left" colspan="2" valign="top" class="prompt">
                        description:
                        <br />
                        <asp:TextBox ID="descriptionTextBox" runat="server" Rows="8" Text='<%# Bind("description") %>'
                            TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                    <td align="left" colspan="2" valign="top" class="prompt">
                        說明:<br />
                        <asp:TextBox ID="description_cnTextBox" runat="server" Rows="8" Text='<%# Bind("description_cn") %>'
                            TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    
    <asp:ObjectDataSource ID="TourDayDestDetailDataset" runat="server" DeleteMethod="Delete"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetTourDayDestDetail"
        TypeName="com.Omei.DLL.DS_TourDayDestTableAdapters.tourDestDetailTableAdapter" UpdateMethod="Update" InsertMethod="Insert">
        <DeleteParameters>
            <asp:Parameter Name="Original_tourDestid" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="destinationId" Type="Int32" />
            <asp:Parameter Name="visitDate" Type="Int32" />
            <asp:Parameter Name="visitOrder" Type="Int32" />
            <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="description_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="Original_tourDestid" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lstTourDest" DefaultValue="-1" Name="tourDestId"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="tourId" Type="Int32" QueryStringField="id" />
            <asp:Parameter Name="destinationId" Type="Int32" />
            <asp:Parameter Name="visitDate" Type="Int32" />
            <asp:Parameter Name="visitOrder" Type="Int32" />
            <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="description_cn" Type="String" ConvertEmptyStringToNull=False />
        </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="DestDataset" runat="server" 
        SelectMethod="GetDestinationTitle" 
        TypeName="com.Omei.DLL.DS_DestinationsTableAdapters.DestTitleTableAdapter" OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>
    
</asp:Content>

