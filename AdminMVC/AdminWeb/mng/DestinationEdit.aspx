<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="DestinationEdit" Title="Untitled Page" Codebehind="DestinationEdit.aspx.cs" %>
<%@ Register Src="../Controls/CountrySelector.ascx" TagName="CountrySelector" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
    <asp:ObjectDataSource ID="DestinationDetailDataset" runat="server" InsertMethod="AddDestination" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetDestinationDetail" 
        TypeName="com.Omei.BLL.Admin.AdminDestinationBiz" UpdateMethod="UpdateDestination" OnInserted="DestinationDetailDataset_Inserted" 
        >
        <UpdateParameters>
            <asp:SessionParameter Name="loginUserInfo" Type="Object" SessionField="LoginUserInfo" />
            <asp:Parameter Name="Original_DestinationID" Type="Int32" />
            <asp:Parameter Name="DestinationName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="DestinationName_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="Description" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="Description_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="status" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="destinationId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:SessionParameter Name="loginUserInfo" Type="Object" SessionField="LoginUserInfo" />
            <asp:Parameter Name="DestinationName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="DestinationName_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull=False  />
            <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="Description" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="Description_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="status" Type="Int32" />
        </InsertParameters>
    </asp:ObjectDataSource>
    
    <asp:FormView ID="fvDestination" runat="server" 
        DataKeyNames="DestinationID" DataSourceID="DestinationDetailDataset" Width="100%" 
        >
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="Update" Enabled='<%# PageLogic.CheckActionAuth("auth_DestinationEdit") %>'>
                </asp:LinkButton></li>
                    <li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="Cancel">
                </asp:LinkButton></li>
                </ul><div style="clear:both"></div>
            </div>
            
            ID:
            <asp:Label ID="DestinationIDLabel1" runat="server" Text='<%# Eval("DestinationID") %>'>
            </asp:Label><br />
            <table style="width: 100%" class="detail_view">
                <tr>
                    <td class="prompt" nowrap="noWrap" width="10%">
                        Name:</td>
                    <td width="40%">
            <asp:TextBox ID="DestinationNameTextBox" runat="server" Text='<%# Bind("DestinationName") %>' Width="90%"></asp:TextBox></td>
                    <td class="prompt" nowrap="noWrap" width="10%">
                        名稱:</td>
                    <td width="40%">
            <asp:TextBox ID="DestinationName_cnTextBox" runat="server" Text='<%# Bind("DestinationName_cn") %>' Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td valign="top" class="prompt" nowrap="noWrap">
                        Description:</td>
                    <td valign="top">
            <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Rows="8" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                    <td valign="top" class="prompt" nowrap="noWrap">
                        說明:</td>
                    <td valign="top">
            <asp:TextBox ID="Description_cnTextBox" runat="server" Text='<%# Bind("Description_cn") %>' Rows="8" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="noWrap">
                        City:&nbsp;</td>
                    <td>
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' Width="120px"></asp:TextBox></td>
                    <td class="prompt" nowrap="noWrap">
                        State:&nbsp;</td>
                    <td>
            <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' Width="120px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="noWrap">
                        country:
                    </td>
                    <td>
                        <uc1:CountrySelector ID="CountrySelector1" runat="server" Lang="1" CountryCode='<%# Bind("country") %>' />
                    </td>
                    <td class="prompt" nowrap="noWrap">
                        Status:</td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("status") %>'>
                            <asp:ListItem Value="1">有效</asp:ListItem>
                            <asp:ListItem Value="0">无效</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                    Text="Insert" Enabled='<%# PageLogic.CheckActionAuth("auth_DestinationNew") %>'>
                </asp:LinkButton></li>
                    <li><asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="Cancel">
                </asp:LinkButton></li>
                </ul><div style="clear:both"></div>
            </div>
            
            ID:
            <asp:Label ID="DestinationIDLabel1" runat="server" Text='<%# Eval("DestinationID") %>'>
            </asp:Label><br />
            <table style="width: 100%" class="detail_view">
                <tr>
                    <td class="prompt" nowrap="noWrap" width="10%">
                        Name:</td>
                    <td width="40%">
            <asp:TextBox ID="DestinationNameTextBox" runat="server" Text='<%# Bind("DestinationName") %>' Width="90%"></asp:TextBox></td>
                    <td class="prompt" nowrap="noWrap" width="10%">
                        名稱:</td>
                    <td width="40%">
            <asp:TextBox ID="DestinationName_cnTextBox" runat="server" Text='<%# Bind("DestinationName_cn") %>' Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td valign="top" class="prompt" nowrap="noWrap">
                        Description:</td>
                    <td valign="top">
            <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Rows="8" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                    <td valign="top" class="prompt" nowrap="noWrap">
                        說明:</td>
                    <td valign="top">
            <asp:TextBox ID="Description_cnTextBox" runat="server" Text='<%# Bind("Description_cn") %>' Rows="8" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="noWrap">
                        City:&nbsp;</td>
                    <td>
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' Width="120px"></asp:TextBox></td>
                    <td class="prompt" nowrap="noWrap">
                        State:&nbsp;</td>
                    <td>
            <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' Width="120px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="noWrap">
                        country:
                    </td>
                    <td>
                        <uc1:CountrySelector ID="CountrySelector1" runat="server" Lang="1" CountryCode='<%# Bind("country") %>' />
                    </td>
                    <td class="prompt" nowrap="noWrap">
                        Status:</td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("status") %>'>
                            <asp:ListItem Value="1">有效</asp:ListItem>
                            <asp:ListItem Value="0">无效</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                    Text="Edit" Enabled='<%# PageLogic.CheckActionAuth("auth_DestinationEdit") %>'></asp:LinkButton></li>
                    <li><asp:HyperLink ID="lnkPhotos" runat="server" 
                        NavigateUrl='<%# Eval("DestinationId","DestinationPics.aspx?id={0}") %>' CssClass='<%# PageLogic.GetPageAuthStyle("DestinationPics.aspx") %>' >Photos</asp:HyperLink></li>
                </ul><div style="clear:both"></div>
            </div>

            <table style="width: 100%" cellpadding="2" cellspacing="2" class="detail_view">
                <tr>
                    <td class="prompt" nowrap="noWrap">
                        ID:
                        <asp:Label ID="DestinationIDLabel" runat="server" Text='<%# Eval("DestinationID") %>' CssClass="content"></asp:Label></td>
                    <td align="right" class="prompt" width="50%">
                        Status:<asp:Label ID="StatusLabel" runat="server" Text='<%# Bind("Status") %>' CssClass="content"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" valign="top">
                        Name:<br />
                        <asp:Label ID="DestinationNameLabel" runat="server" Text='<%# Bind("DestinationName") %>' CssClass="content"></asp:Label></td>
                    <td class="prompt" valign="top">
                        名稱:<br />
                        <asp:Label ID="DestinationName_cnLabel" runat="server" Text='<%# Bind("DestinationName_cn") %>' CssClass="content"></asp:Label></td>
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
                    <td colspan="2" class="prompt" nowrap="noWrap">
                        city:
                        <asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>' CssClass="content"></asp:Label>&nbsp;
                        state:
                        <asp:Label ID="stateLabel" runat="server" Text='<%# Bind("state") %>' CssClass="content"></asp:Label>&nbsp;
                        country:
                        <asp:Label ID="countryLabel" runat="server" Text='<%# Bind("country") %>' CssClass="content"></asp:Label></td>
                </tr>
            </table>
            
        </ItemTemplate>
    </asp:FormView>

</asp:Content>

