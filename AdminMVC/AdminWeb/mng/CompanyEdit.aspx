<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="CompanyEdit" Title="Untitled Page" Codebehind="CompanyEdit.aspx.cs" %>
<%@ Register Src="../Controls/CountrySelector.ascx" TagName="CountrySelector" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <asp:ObjectDataSource ID="CompanyDetailDataset" runat="server"
        InsertMethod="AddCompany" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCompanyDetail"
        TypeName="com.Omei.BLL.Admin.AdminCompanyBiz" UpdateMethod="UpdateCompanyDetail" DeleteMethod="Delete" 
        OnDeleted="CompanyDetailDataset_Deleted" OnInserted="CompanyDetailDataset_Inserted">
        <UpdateParameters>
            <asp:Parameter Name="shortName" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="companyName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="companyName_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="address" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="zip" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="telephone" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="fax" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="contactPerson" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="email" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="companyType" Type="Byte" />
            <asp:Parameter Name="iconUrl" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="website" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="description_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="discount" Type="Decimal" />
            <asp:Parameter Name="status" Type="Byte" />
            <asp:Parameter Name="Original_companyId" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:Parameter Name="companyId" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="shortName" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="companyName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="companyName_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="address" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="zip" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="telephone" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="fax" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="contactPerson" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="email" Type="String" ConvertEmptyStringToNull=False  />
            <asp:Parameter Name="companyType" Type="Byte" />
            <asp:Parameter Name="iconUrl" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="website" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="description_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="discount" Type="Decimal" />
            <asp:Parameter Name="status" Type="Byte"  />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_companyId" Type="Int32" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:FormView ID="fvCompanyDetail" runat="server" DataKeyNames="companyId" DataSourceID="CompanyDetailDataset" Width="100%" >
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="Update">
                </asp:LinkButton></li><li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="Cancel">
                </asp:LinkButton></li></ul>
                <div style="clear:both"></div>
            </div>
            
            ID:
            <asp:Label ID="companyIdLabel1" runat="server" Text='<%# Eval("companyId") %>'></asp:Label>
            &nbsp;&nbsp;Short name:<asp:TextBox ID="txtShortName" runat="server" Text='<%# Bind("shortName") %>'></asp:TextBox>
            <br />
            <div class="detail_view">
            <table style="width: 100%" cellpadding="2" cellspacing="2">
                <tr>
                    <td class="prompt" valign="top" width="50%">
                        Name:<br />
            <asp:TextBox ID="companyNameTextBox" runat="server" Text='<%# Bind("companyName") %>' Width="90%"></asp:TextBox></td>
                    <td class="prompt" valign="top" width="50%">
                        名稱:<br />
            <asp:TextBox ID="companyName_cnTextBox" runat="server" Text='<%# Bind("companyName_cn") %>' Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" valign="top">
                        Description:<br />
            <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' Rows="6" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                    <td class="prompt" valign="top">
                        說明:<br />
            <asp:TextBox ID="description_cnTextBox" runat="server" Text='<%# Bind("description_cn") %>' Rows="6" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
            </table>
            <table style="width: 100%" cellpadding="2" cellspacing="2">
                <tr>
                    <td class="prompt" width="10%">
                        Type:</td>
                    <td width="40%">
            <asp:TextBox ID="companyTypeTextBox" runat="server" Text='<%# Bind("companyType") %>'>
            </asp:TextBox></td>
                    <td class="prompt" width="10%">
                        Contact person:</td>
                    <td width="40%">
            <asp:TextBox ID="contactPersonTextBox" runat="server" Text='<%# Bind("contactPerson") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Address:</td>
                    <td>
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>'>
            </asp:TextBox></td>
                    <td class="prompt">
                        City:</td>
                    <td>
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        State:</td>
                    <td>
            <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>'>
            </asp:TextBox></td>
                    <td class="prompt">
                        ZIP:</td>
                    <td>
            <asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Country:</td>
                    <td>
                    <uc1:CountrySelector ID="countrySelector1" runat="server" CountryCode='<%# Bind("country") %>' Lang=0 />
                    </td>
                    <td class="prompt">
                        Email:</td>
                    <td>
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Tel:</td>
                    <td>
            <asp:TextBox ID="telephoneTextBox" runat="server" Text='<%# Bind("telephone") %>'>
            </asp:TextBox>
                    </td>
                    <td class="prompt">
                        Fax:</td>
                    <td>
            <asp:TextBox ID="faxTextBox" runat="server" Text='<%# Bind("fax") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Website:</td>
                    <td>
            <asp:TextBox ID="websiteTextBox" runat="server" Text='<%# Bind("website") %>'>
            </asp:TextBox></td>
                    <td class="prompt">
                        Icon URL:</td>
                    <td>
            <asp:TextBox ID="iconUrlTextBox" runat="server" Text='<%# Bind("iconUrl") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Discount:</td>
                    <td>
                        &nbsp;<asp:TextBox ID="txtDiscount" runat="server" Text='<%# Bind("discount") %>'
                            Width="80px"></asp:TextBox>
                        off</td>
                    <td class="prompt">
                        Status:</td>
                    <td>
                <asp:DropDownList ID="seleStatus" SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="1">有傚</asp:ListItem>
                            <asp:ListItem Value="0">無傚</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>
            </div>
        </EditItemTemplate>
        <InsertItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton></li><li><asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li></ul>
                
            <div style="clear:both"></div>
            </div>
            
            <div class="detail_view">
            <table style="width: 100%" cellpadding="2" cellspacing="2">
                <tr>
                    <td>Short name:</td>
                    <td><<asp:TextBox ID="txtShortName" runat="server" Text='<%# Bind("shortName") %>'></asp:TextBox>
                    /td>
                </tr>
                <tr>
                    <td class="prompt" valign="top" width="50%">
                        Name:<br />
            <asp:TextBox ID="companyNameTextBox" runat="server" Text='<%# Bind("companyName") %>' Width="90%"></asp:TextBox></td>
                    <td class="prompt" valign="top" width="50%">
                        名稱:<br />
            <asp:TextBox ID="companyName_cnTextBox" runat="server" Text='<%# Bind("companyName_cn") %>' Width="90%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" valign="top">
                        Description:<br />
            <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' Rows="6" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                    <td class="prompt" valign="top">
                        說明:<br />
            <asp:TextBox ID="description_cnTextBox" runat="server" Text='<%# Bind("description_cn") %>' Rows="6" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
            </table>
            <table style="width: 100%" cellpadding="2" cellspacing="2">
                <tr>
                    <td class="prompt" width="10%">
                        Type:</td>
                    <td width="40%">
            <asp:TextBox ID="companyTypeTextBox" runat="server" Text='<%# Bind("companyType") %>'>
            </asp:TextBox></td>
                    <td class="prompt" width="10%">
                        Contact person:</td>
                    <td width="40%">
            <asp:TextBox ID="contactPersonTextBox" runat="server" Text='<%# Bind("contactPerson") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Address:</td>
                    <td>
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>'>
            </asp:TextBox></td>
                    <td class="prompt">
                        City:</td>
                    <td>
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        State:</td>
                    <td>
            <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>'>
            </asp:TextBox></td>
                    <td class="prompt">
                        ZIP:</td>
                    <td>
            <asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Country:</td>
                    <td>
                    <uc1:CountrySelector ID="countrySelector1" runat="server" CountryCode='<%# Bind("country") %>' Lang=0 />
                    </td>
                    <td class="prompt">
                        Email:</td>
                    <td>
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Tel:</td>
                    <td>
            <asp:TextBox ID="telephoneTextBox" runat="server" Text='<%# Bind("telephone") %>'>
            </asp:TextBox>
                    </td>
                    <td class="prompt">
                        Fax:</td>
                    <td>
            <asp:TextBox ID="faxTextBox" runat="server" Text='<%# Bind("fax") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Website:</td>
                    <td>
            <asp:TextBox ID="websiteTextBox" runat="server" Text='<%# Bind("website") %>'>
            </asp:TextBox></td>
                    <td class="prompt">
                        Icon URL:</td>
                    <td>
            <asp:TextBox ID="iconUrlTextBox" runat="server" Text='<%# Bind("iconUrl") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Discount:</td>
                    <td>
                        <asp:TextBox ID="txtDiscount" runat="server" Text='<%# Bind("discount") %>' Width="80px"></asp:TextBox>
                        off</td>
                    <td class="prompt">
                        Status:</td>
                    <td>
                <asp:DropDownList ID="seleStatus" SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="1">有傚</asp:ListItem>
                            <asp:ListItem Value="0">無傚</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>
            </div>
        </InsertItemTemplate>
        <ItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><a href="Companys.aspx">公司列表</a></li><li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                    Text="Edit" Enabled='<%# PageLogic.CheckActionAuth("auth_CompanyEdit") %>'>
                </asp:LinkButton></li><li><asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                    Enabled='<%# PageLogic.CheckActionAuth("auth_CompanyDel") %>'
                    Text="Delete" OnClientClick="javascript:return confirm('刪除操作不能恢復!\n\n如果您是需要此數據不顯示在網站上，可以通過調整狀態標誌達到目的。\n\n您確認還是要刪除嗎？');"></asp:LinkButton></li><li><asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                    Text="New" Enabled='<%# PageLogic.CheckActionAuth("auth_CompanyNew") %>'>
                </asp:LinkButton></li>
                <li>
                    <asp:HyperLink ID="lnkInvoice" runat="server" 
                        NavigateUrl='<%# Eval("companyID", "AgentOrders.aspx?agent={0}") %>'  Text="Receivable" /></li></ul>
                
                </ul><div style="clear:both"></div>
            </div>
            
            ID:<asp:Label ID="companyIdLabel" runat="server" Text='<%# Eval("companyId") %>'></asp:Label>
            &nbsp;&nbsp;Short name:<asp:Label ID="lbShortName" runat="server" Text='<%# Eval("shortName") %>'></asp:Label>
            <br />
            <div class="detail_view">
            <table style="width: 100%" cellpadding="2" cellspacing="2">
                <tr>
                    <td class="prompt" valign="top" width="50%">
                        Name:<br />
            <asp:Label ID="companyNameLabel" runat="server" Text='<%# Bind("companyName") %>' CssClass="content"></asp:Label></td>
                    <td class="prompt" valign="top" width="50%">
                        名稱:<br />
            <asp:Label ID="companyName_cnLabel" runat="server" Text='<%# Bind("companyName_cn") %>' CssClass="content"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" valign="top">
                        Description:<br />
            <asp:Label ID="descriptionLabel" runat="server" Text='<%# Bind("description") %>' CssClass="content"></asp:Label></td>
                    <td class="prompt" valign="top">
                        說明:<br />
            <asp:Label ID="description_cnLabel" runat="server" Text='<%# Bind("description_cn") %>' CssClass="content"></asp:Label></td>
                </tr>
            </table>
            <table style="width: 100%" cellpadding="2" cellspacing="2">
                <tr>
                    <td class="prompt" width="10%">
                        Type:</td>
                    <td class="content" width="40%">
            <asp:Label ID="companyTypeLabel" runat="server" Text='<%# Bind("companyType") %>'>
            </asp:Label></td>
                    <td class="prompt" width="10%">
                        Contact Person:</td>
                    <td class="content" width="40%">
            <asp:Label ID="contactPersonLabel" runat="server" Text='<%# Bind("contactPerson") %>'>
            </asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" width="10%">
                        Address:</td>
                    <td class="content" width="40%">
            <asp:Label ID="addressLabel" runat="server" Text='<%# Bind("address") %>'></asp:Label></td>
                    <td class="prompt" width="10%">
                        City:</td>
                    <td class="content" width="40%">
            <asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" width="10%">
                        State:</td>
                    <td class="content" width="40%">
            <asp:Label ID="stateLabel" runat="server" Text='<%# Bind("state") %>'></asp:Label></td>
                    <td class="prompt" width="10%">
                        ZIP:</td>
                    <td class="content" width="40%">
            <asp:Label ID="zipLabel" runat="server" Text='<%# Bind("zip") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" width="10%">
                        Country:</td>
                    <td class="content" width="40%">
            <asp:Label ID="countryLabel" runat="server" Text='<%# Bind("country") %>'></asp:Label></td>
                    <td class="prompt" width="10%">
                        Email:</td>
                    <td class="content" width="40%">
            <asp:Label ID="emailLabel" runat="server" Text='<%# Bind("email") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" width="10%">
                        Website:</td>
                    <td class="content" width="40%">
            <asp:Label ID="websiteLabel" runat="server" Text='<%# Bind("website") %>'></asp:Label></td>
                    <td class="prompt" width="10%">
                        Icon URL:</td>
                    <td class="content" width="40%">
            <asp:Label ID="iconUrlLabel" runat="server" Text='<%# Bind("iconUrl") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" width="10%">
                        Tel:</td>
                    <td class="content" width="40%">
            <asp:Label ID="telephoneLabel" runat="server" Text='<%# Bind("telephone") %>'></asp:Label></td>
                    <td class="prompt" width="10%">
                        Fax:</td>
                    <td class="content" width="40%">
            <asp:Label ID="faxLabel" runat="server" Text='<%# Bind("fax") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" width="10%">
                        Discount:</td>
                    <td class="content" width="40%">
                        <asp:Label ID="lbDiscount" runat="server" Text='<%# Eval("discount") %>'></asp:Label>
                        off</td>
                    <td class="prompt" width="10%">
                        Status:</td>
                    <td class="content" width="40%">
            <asp:Label ID="statusLabel" runat="server" Text='<%# Bind("status") %>'></asp:Label></td>
                </tr>
            </table>
            </div>
            
        </ItemTemplate>
    </asp:FormView>

</asp:Content>

