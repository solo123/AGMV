<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_NotesCtl" Codebehind="NotesCtl.ascx.cs" %>

<asp:ObjectDataSource ID="NotesDataset" runat="server" SelectMethod="GetNotes" TypeName="com.Omei.BLL.Admin.AdminNotesBiz" OnSelecting="NotesDataset_Selecting" OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="refid" Type="Int32" />
        <asp:Parameter Name="notesType" Type="Object" />
        <asp:Parameter DefaultValue="1" Name="status" Type="Byte" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:Panel ID="plAddNotes"  runat="server" Visible="false">
    <p>
        <asp:TextBox ID="txtNotes" runat="server" Rows="3" TextMode="MultiLine" Width="95%" ValidationGroup="AddNotesGroup"></asp:TextBox><br />
        <asp:Label ID="txtRefId" runat="server"></asp:Label>
        <asp:Button ID="btnAdd" runat="server" Text="Add notes" OnClick="btnAdd_Click" ValidationGroup="AddNotesGroup" Enabled='<%# PageLogic.CheckActionAuth("auth_NotesNew") %>' />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNotes"
            Display="Dynamic" ErrorMessage="Please input Notes first." SetFocusOnError="True"
            ValidationGroup="AddNotesGroup"></asp:RequiredFieldValidator>
    </p>
</asp:Panel>
<asp:LinkButton ID="btnShowAdd" runat="server" OnClick="btnShowAdd_Click" Enabled='<%# PageLogic.CheckActionAuth("auth_NotesNew") %>'>Add notes?</asp:LinkButton>&nbsp;&nbsp;
<asp:CheckBox ID="chkShowAll" runat="server" Text="顯示所有說明(包括已刪除)" AutoPostBack="True" OnCheckedChanged="chkShowAll_CheckedChanged" ValidationGroup="AddNotesGroup" />&nbsp;
<hr />
<asp:DataList ID="lstNotes" runat="server" 
    DataKeyField="notesId" Width="100%" 
    OnItemDataBound="lstNotes_ItemDataBound" 
    OnEditCommand="lstNotes_EditCommand" 
    OnUpdateCommand="lstNotes_UpdateCommand" 
    OnCancelCommand="lstNotes_CancelCommand" DataSourceID="NotesDataset" >
    <ItemTemplate>
        <table width="100%" cellpadding="6" cellspacing="0" border="0">
            <tr>
                <td><asp:LinkButton ID="btnEdit" runat="server" CommandName="edit" Enabled='<%# PageLogic.CheckActionAuth("auth_NotesEdit") %>' Visible="False">Edit</asp:LinkButton>
                </td>
                <td align="right">Notes by <asp:Label ID="usernameLabel" runat="server" Text='<%# Eval("username") %>' Font-Bold="True"></asp:Label>
        at
        <asp:Label ID="notesDateLabel" runat="server" Text='<%# Eval("notesDate") %>' Font-Italic="True"></asp:Label>
                </td>
            </tr>
            <tr><td colspan="2">
                <asp:Label ID="notesLabel" runat="server" Text='<%# Eval("notes") %>'></asp:Label>
            </td></tr>
        </table>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="update" Enabled='<%# PageLogic.CheckActionAuth("auth_NotesEdit") %>'>Update</asp:LinkButton>&nbsp;
        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="cancel">Cancel</asp:LinkButton>
        &nbsp;
        <asp:CheckBox ID="chkStatus" runat="server" Text="標誌(選中后才顯示)" Checked='<%# Eval("status") %>' />
        <asp:TextBox ID="txtMyNotes" runat="server" Width="90%" Text='<%# Eval("notes") %>' Rows="4" TextMode="MultiLine"></asp:TextBox><br />
    </EditItemTemplate>
</asp:DataList>
