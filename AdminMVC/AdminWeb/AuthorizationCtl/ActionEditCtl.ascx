<%@ Control Language="C#" AutoEventWireup="true" Inherits="AuthorizationCtl_ActionEditCtl" Codebehind="ActionEditCtl.ascx.cs" %>
<asp:FormView ID="fvAction" runat="server" DataKeyNames="actionID" DataSourceID="ActionDataset" OnItemDeleted="fvAction_ItemDeleted" OnItemInserted="fvAction_ItemInserted" OnItemUpdated="fvAction_ItemUpdated">
    <EditItemTemplate>
        <table cellpadding=2 cellspacing=2 border=0 class="detail_view">
            <tr>
                <td nowrap class="prompt">ID:</td>
                <td class="content"><asp:Label ID="actionIDLabel1" runat="server" Text='<%# Eval("actionID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap class="prompt">Action Name:</td>
                <td class="content"><asp:Label ID="actionNameTextBox" runat="server" Text='<%# Eval("actionName") %>'>
        </asp:Label></td>
            </tr>
            <tr>
                <td nowrap class="prompt">Item Type:</td>
                <td class="content"><asp:TextBox ID="itemTypeTextBox" runat="server" Text='<%# Bind("itemType") %>'>
        </asp:TextBox></td>
            </tr>
            <tr>
                <td nowrap class="prompt">Menu ID:</td>
                <td class="content"><asp:TextBox ID="menuIDTextBox" runat="server" Text='<%# Bind("menuID") %>'>
        </asp:TextBox></td>
            </tr>
            <tr>
                <td nowrap class="prompt">Show Order:</td>
                <td class="content"><asp:TextBox ID="showOrderTextBox" runat="server" Text='<%# Bind("showOrder") %>'>
        </asp:TextBox></td>
            </tr>
            <tr>
                <td nowrap class="prompt">Description:</td>
                <td class="content"><asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>'>
        </asp:TextBox></td>
            </tr>
        </table> <br />

        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
            Text="Update">
        </asp:LinkButton>
        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
            Text="Cancel">
        </asp:LinkButton>&nbsp;&nbsp;
        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="Delete"
            Text="Delete" OnClientClick="javascript:return confirm('Delete cannot be recover\n\nAre you sure?')" />
    </EditItemTemplate>
    <ItemTemplate>
        <table cellpadding=2 cellspacing=2 border=0 class="detail_view">
            <tr>
                <td nowrap choff="prompt">ID:</td>
                <td class="content"><asp:Label ID="actionIDLabel" runat="server" Text='<%# Eval("actionID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap choff="prompt">Action Name:</td>
                <td class="content"><asp:Label ID="actionNameLabel" runat="server" Text='<%# Eval("actionName") %>'>
        </asp:Label></td>
            </tr>
            <tr>
                <td nowrap choff="prompt">Item Type:</td>
                <td class="content"><asp:Label ID="itemTypeLabel" runat="server" Text='<%# Eval("itemType") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap choff="prompt">Menu ID:</td>
                <td class="content"><asp:Label ID="menuIDLabel" runat="server" Text='<%# Eval("menuID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap choff="prompt">Show Order:</td>
                <td class="content"><asp:Label ID="showOrderLabel" runat="server" Text='<%# Eval("showOrder") %>'></asp:Label></td>
            </tr>
            <tr>
                <td nowrap choff="prompt">Description:</td>
                <td class="content"><asp:Label ID="descriptionLabel" runat="server" Text='<%# Eval("description") %>'>
        </asp:Label></td>
            </tr>
        </table>
        <br />
        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
            Text="Edit">
        </asp:LinkButton>
    </ItemTemplate>
</asp:FormView>
<asp:ObjectDataSource ID="ActionDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetActionByID" TypeName="com.Omei.BLL.Admin.ActionAuthorization"
    UpdateMethod="UpdateAction" DeleteMethod="DeleteAction">
    <UpdateParameters>
        <asp:Parameter Name="description" Type="String" />
        <asp:Parameter Name="itemType" Type="Int32" />
        <asp:Parameter Name="menuID" Type="Int32" />
        <asp:Parameter Name="showOrder" Type="Int32" />
        <asp:Parameter Name="original_actionID" Type="Int32" />
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="actionID" Type="Int32" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="original_actionID" Type="Int32" />
    </DeleteParameters>
</asp:ObjectDataSource>
