<%@ Control Language="C#" AutoEventWireup="true" Inherits="AuthorizationCtl_MenuItemEditCtl" Codebehind="MenuItemEditCtl.ascx.cs" %>
<%@ Register Src="../Controls/TypeSelectorCtl.ascx" TagName="TypeSelectorCtl" TagPrefix="uc2" %>
<asp:FormView ID="fvMenuItem" runat="server" DataKeyNames="menuID" DataSourceID="MenuItemDataset" OnItemDeleted="fvMenuItem_ItemDeleted" OnItemInserted="fvMenuItem_ItemInserted" OnItemUpdated="fvMenuItem_ItemUpdated">
    <EditItemTemplate>
        <table>
            <tr>
                <td>
        ID:
                </td>
                <td>
        <asp:Label ID="menuIDLabel1" runat="server" Font-Bold=true Text='<%# Eval("menuID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Parent ID:</td>
                <td>
        <asp:TextBox ID="parentIDTextBox" runat="server" Text='<%# Bind("parentID") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Title:
                </td>
                <td>
        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Description:
                </td>
                <td>
        <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' Rows="3" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td nowrap=nowrap>
                    Navigate Url:</td>
                <td>
        <asp:TextBox ID="navigateUrlTextBox" runat="server" Text='<%# Bind("navigateUrl") %>' Rows="3" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Page name:</td>
                <td><asp:TextBox ID="txtPageName" runat="server" Text='<%# Bind("pageName") %>' /></td>
            </tr>
            <tr>
                <td>
                    Menu Order:</td>
                <td>
        <asp:TextBox ID="menuOrderTextBox" runat="server" Text='<%# Bind("menuOrder") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Status:</td>
                <td>
        <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Menu Type:</td>
                <td>
                <uc2:TypeSelectorCtl ID="TypeSelectorCtl1" runat="server" TypeName="MenuType" SelectedValue='<%# Bind("menuType") %>' />
                </td>
            </tr>
        </table>
        <br />
        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
            Text="Update"></asp:LinkButton>
        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
            Text="Cancel"></asp:LinkButton>
    </EditItemTemplate>
    <ItemTemplate>
        <table cellpadding="2" cellspacing="2" class="detailView">
            <tr>
                <td>
                    ID:
                </td><td><asp:Label ID="menuIDLabel" Font-Bold=true runat="server" Text='<%# Eval("menuID") %>'></asp:Label></td>
                    
            </tr>
            <tr>
                <td>Title:</td><td><asp:Label ID="titleLabel" runat="server" Text='<%# Bind("title") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap="nowrap" class="prompt">
                    Parent ID:</td>
                <td nowrap="nowrap" class="content">
        <asp:Label ID="parentIDLabel" runat="server" Text='<%# Bind("parentID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap="nowrap" class="prompt">
                    Description:
                </td>
                <td nowrap="nowrap" class="content">
        <asp:Label ID="descriptionLabel" runat="server" Text='<%# Bind("description") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap="nowrap" class="prompt">
                    Navigate Url:</td>
                <td nowrap="nowrap" class="content">
        <asp:Label ID="navigateUrlLabel" runat="server" Text='<%# Bind("navigateUrl") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>Page name:</td>
                <td><asp:Label ID="txtPageName" runat="server" Text='<%# Eval("pageName") %>' /></td>
            </tr>
            <tr>
                <td nowrap="nowrap" class="prompt">
                    Menu Order:</td>
                <td nowrap="nowrap" class="content">
        <asp:Label ID="menuOrderLabel" runat="server" Text='<%# Bind("menuOrder") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap="nowrap" class="prompt">
                    Status:</td>
                <td nowrap="nowrap" class="content">
        <asp:Label ID="statusLabel" runat="server" Text='<%# Bind("status") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap="nowrap" class="prompt">
                    Menu Type:</td>
                <td nowrap="nowrap" class="content">
        <asp:Label ID="menuTypeLabel" runat="server" Text='<%# Bind("menuType") %>'></asp:Label></td>
            </tr>
        </table>
        <br />
        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton>
        <asp:LinkButton ID="btnAdd" runat="server" CommandName="New">Add</asp:LinkButton>
    </ItemTemplate>
    <InsertItemTemplate>
<table>
            <tr>
                <td colspan=2>
        #New menu item
                </td>
            </tr>
            <tr>
                <td>
                    Parent ID:</td>
                <td>
        <asp:TextBox ID="parentIDTextBox" runat="server" Text='<%# Bind("parentID") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Title:
                </td>
                <td>
        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Description:
                </td>
                <td>
        <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' Rows="3" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td nowrap=nowrap>
                    Navigate Url:</td>
                <td>
        <asp:TextBox ID="navigateUrlTextBox" runat="server" Text='<%# Bind("navigateUrl") %>' Rows="3" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Menu Order:</td>
                <td>
        <asp:TextBox ID="menuOrderTextBox" runat="server" Text='<%# Bind("menuOrder") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Status:</td>
                <td>
        <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Menu Type:</td>
                <td>
        <asp:TextBox ID="menuTypeTextBox" runat="server" Text='<%# Bind("menuType") %>'></asp:TextBox></td>
            </tr>
        </table>
        <br />
        <asp:LinkButton ID="AddButton" runat="server" CausesValidation="True" CommandName="Insert"
            Text="Add"></asp:LinkButton>
        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
            Text="Cancel"></asp:LinkButton>    
    </InsertItemTemplate>
</asp:FormView>
<asp:ObjectDataSource ID="MenuItemDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetMenuItemByID" TypeName="com.Omei.BLL.Admin.AdminMenuBiz" UpdateMethod="UpdateMenuItem" InsertMethod="AddMenuItem" OnInserting="MenuItemDataset_Inserting">
    <UpdateParameters>
        <asp:Parameter Name="original_menuID" Type="Int32" />
        <asp:Parameter Name="parentID" Type="Int32" />
        <asp:Parameter Name="title" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="pageName" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="menuOrder" Type="Int32" />
        <asp:Parameter Name="navigateUrl" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="status" Type="Int32" />
        <asp:Parameter Name="menuType" Type="Int32" />
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="menuID" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:Parameter Name="parentID" Type="Int32" />
        <asp:Parameter Name="title" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="pageName" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="menuOrder" Type="Int32" />
        <asp:Parameter Name="navigateUrl" Type="String" ConvertEmptyStringToNull=false />
        <asp:Parameter Name="status" Type="Int32" />
        <asp:Parameter Name="menuType" Type="Int32" />
    </InsertParameters>
</asp:ObjectDataSource>


