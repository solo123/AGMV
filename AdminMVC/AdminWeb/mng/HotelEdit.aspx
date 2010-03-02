<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="HotelEdit" Title="Untitled Page" Codebehind="HotelEdit.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:FormView ID="fvHotel" runat="server" 
        DataKeyNames="hotelID"  
        DataSourceID="HotelDataset"
        Width="100%">
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update">
            </asp:LinkButton></li><li>
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
</li>
                </ul><div style="clear:both"></div>
            </div>
        
            <table width="100%" class="detail_view">
                <tr>
                    <td class="prompt">Hotel ID:</td>
                    <td class="content"><asp:Label ID="hotelIDLabel1" runat="server" Text='<%# Eval("hotelID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">Icon:</td>
                    <td class="content">
                        </td>
                </tr>
                <tr>
                    <td class="prompt">Hotel name:</td>
                    <td class="content"><asp:TextBox ID="hotelNameTextBox" runat="server" Text='<%# Bind("hotelName") %>' Width="60px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="hotelNameTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="prompt">Star rank:</td>
                    <td class="content"><asp:TextBox ID="starRankTextBox" runat="server" Text='<%# Bind("starRank") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="starRankTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="starRankTextBox"
                            Display="Dynamic" ErrorMessage="Please enter 0-6." Operator="DataTypeCheck" SetFocusOnError="True"
                            Type="Double"></asp:CompareValidator></td>
                </tr>
                <tr>
                    <td class="prompt">Description:</td>
                    <td class="content"><asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">Price info:</td>
                    <td class="content"><asp:TextBox ID="priceInfoTextBox" runat="server" Text='<%# Bind("priceInfo") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="noWrap">Contact info:</td>
                    <td class="content"><asp:TextBox ID="contactInfoTextBox" runat="server" Text='<%# Bind("contactInfo") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">Status:</td>
                    <td class="content"><asp:DropDownList ID="lstStatus" runat="server" SelectedValue='<%# Bind("status") %>'>
                            <asp:ListItem Value="1">Valid</asp:ListItem>
                            <asp:ListItem Value="0">Invalid</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton></li><li>
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
</li>
                </ul><div style="clear:both"></div>
            </div>
            <table width="100%" class="detail_view">
                <tr>
                    <td class="prompt">Hotel ID:</td>
                    <td class="content"><asp:Label ID="hotelIDLabel1" runat="server" Text='<%# Eval("hotelID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">Icon:</td>
                    <td class="content">
                        </td>
                </tr>
                <tr>
                    <td class="prompt">Hotel name:</td>
                    <td class="content"><asp:TextBox ID="hotelNameTextBox" runat="server" Text='<%# Bind("hotelName") %>' Width="60px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="hotelNameTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="prompt">Star rank:</td>
                    <td class="content"><asp:TextBox ID="starRankTextBox" runat="server" Text='<%# Bind("starRank") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="starRankTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="starRankTextBox"
                            Display="Dynamic" ErrorMessage="Please enter 0-6." Operator="DataTypeCheck" SetFocusOnError="True"
                            Type="Double"></asp:CompareValidator></td>
                </tr>
                <tr>
                    <td class="prompt">Description:</td>
                    <td class="content"><asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">Price info:</td>
                    <td class="content"><asp:TextBox ID="priceInfoTextBox" runat="server" Text='<%# Bind("priceInfo") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="noWrap">Contact info:</td>
                    <td class="content"><asp:TextBox ID="contactInfoTextBox" runat="server" Text='<%# Bind("contactInfo") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">Status:</td>
                    <td class="content"><asp:DropDownList ID="lstStatus" runat="server" SelectedValue='<%# Bind("status") %>'>
                            <asp:ListItem Value="1">Valid</asp:ListItem>
                            <asp:ListItem Value="0">Invalid</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="btnEdit" Text="Edit" runat="server" CommandName="Edit" /></li>
                    <li><asp:LinkButton ID="btnDel" Text="Delete" runat="server" CommandName="Delete" /></li>
                </ul><div style="clear:both"></div>
            </div>
            <table class="detail_view" width="100%">
                <tr>
                    <td class="prompt" width="150">
                        ID:</td>
                    <td class="content">
                        <asp:Label ID="hotelIDLabel" runat="server" Text='<%# Eval("hotelID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Icon:</td>
                    <td class="content">
                        </td>
                </tr>
                <tr>
                    <td class="prompt">
                        Name:</td>
                    <td class="content">
                        <asp:Label ID="hotelNameLabel" runat="server" Text='<%# Bind("hotelName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Stars:</td>
                    <td class="content">
                        <asp:Label ID="starRankLabel" runat="server" Text='<%# Bind("starRank") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Description:</td>
                    <td class="content">
                        <asp:Label ID="descriptionLabel" runat="server" Text='<%# Bind("description") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Price info:</td>
                    <td class="content">
                        <asp:Label ID="priceInfoLabel" runat="server" Text='<%# Bind("priceInfo") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Contact info:</td>
                    <td class="content">
                        <asp:Label ID="contactInfoLabel" runat="server" Text='<%# Bind("contactInfo") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Status:</td>
                    <td class="content">
                        <asp:Label ID="statusLabel" runat="server" Text='<%# Bind("status") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="HotelDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetHotelDetail" TypeName="com.Omei.BLL.Admin.HotelBiz" DeleteMethod="DeleteHotel" InsertMethod="AddHotel" UpdateMethod="UpdateHotel">
        <DeleteParameters>
            <asp:Parameter Name="Original_hotelID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Original_hotelID" Type="Int32" />
            <asp:Parameter Name="hotelName" Type="String" />
            <asp:Parameter Name="starRank" Type="Decimal" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="priceInfo" Type="String" />
            <asp:Parameter Name="contactInfo" Type="String" />
            <asp:Parameter Name="status" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="hotelID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="hotelName" Type="String" />
            <asp:Parameter Name="starRank" Type="Decimal" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="priceInfo" Type="String" />
            <asp:Parameter Name="contactInfo" Type="String" />
            <asp:Parameter Name="status" Type="Int32" />
        </InsertParameters>
    </asp:ObjectDataSource>


</asp:Content>

