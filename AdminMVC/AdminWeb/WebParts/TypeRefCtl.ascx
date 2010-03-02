<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_TypeRefCtl" Codebehind="TypeRefCtl.ascx.cs" %>

<asp:ObjectDataSource ID="typeRefDataset" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllListValue" 
        TypeName="com.Omei.BLL.Admin.TypeRefBiz">
        <SelectParameters>
            <asp:Parameter Name="listClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
<asp:ObjectDataSource ID="typeRefDetailDataset" runat="server" InsertMethod="AddListValue"
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetListValueByID" TypeName="com.Omei.BLL.Admin.TypeRefBiz"
    UpdateMethod="UpdateListValue" DeleteMethod="DeleteListValue">
    <UpdateParameters>
        <asp:Parameter Name="listTitle" Type="String" />
        <asp:Parameter Name="listValue" Type="String" />
        <asp:Parameter Name="status" Type="Int32" />
        <asp:Parameter Name="original_tid" Type="Int32" />
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="tid" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:Parameter Name="listClass" Type="String" />
        <asp:Parameter Name="listTitle" Type="String" />
        <asp:Parameter Name="listValue" Type="String" />
        <asp:Parameter Name="status" Type="Int32" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="original_tid" Type="Int32" />
    </DeleteParameters>
</asp:ObjectDataSource>
<asp:FormView ID="fvTypeRef" runat="server" DataSourceID="typeRefDetailDataset" OnItemInserted="fvTypeRef_ItemInserted" OnItemInserting="fvTypeRef_ItemInserting" OnItemUpdated="fvTypeRef_ItemUpdated" DataKeyNames="tid" OnItemDeleted="fvTypeRef_ItemDeleted">
    <ItemTemplate>
        <table cellpadding=4 cellspacing=0 class=detail_view width="300">
            <tr>
                <td width="80">
                    ID:</td>
                <td>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("tid") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Value:</td>
                <td>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("listValue") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Title:</td>
                <td>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("listTitle") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Status:</td>
                <td>
                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("status") %>'></asp:Label></td>
            </tr>
        </table>
        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton>&nbsp;
        <asp:LinkButton ID="btnAdd" runat="server" CommandName="New">Add</asp:LinkButton>&nbsp;
        <asp:LinkButton ID="btnDel" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Delete cannot be recover. \n\nAre you sure to DELETE it?');">Del</asp:LinkButton>
    </ItemTemplate>
    
    <EditItemTemplate>
        <table cellpadding=4 cellspacing=0 class=detail_view width="300">
            <tr>
                <td width="80">
                    ID:</td>
                <td>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("tid") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Value:</td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("listValue") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Title:</td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("listTitle") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Status:</td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("status") %>'></asp:TextBox></td>
            </tr>
        </table>
        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update">Update</asp:LinkButton>&nbsp;
        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel">Cancel</asp:LinkButton>
    </EditItemTemplate>
    
    <InsertItemTemplate>
        <table cellpadding=4 cellspacing=0 class=detail_view width="300">
            <tr>
                <td colspan="2">
                    New item:</td>
            </tr>
            <tr>
                <td>
                    Value:</td>
                <td>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("listValue") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Title:</td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("listTitle") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Status:</td>
                <td>
                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("status") %>'></asp:TextBox></td>
            </tr>
        </table>
        <asp:LinkButton ID="btnSave" runat="server" CommandName="Insert">Save</asp:LinkButton>&nbsp;
        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel">Cancel</asp:LinkButton>    
    </InsertItemTemplate>
</asp:FormView>
&nbsp;
<br />
    <asp:GridView ID="lstTypes" runat="server" AutoGenerateColumns="False"
        DataSourceID="typeRefDataset" SkinID="DataList" DataKeyNames="tid" Width="100%" OnSelectedIndexChanged="lstTypes_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowSelectButton="True">
                <ItemStyle Wrap="False" Width="5%" />
            </asp:CommandField>
            <asp:BoundField DataField="listValue" HeaderText="Value" SortExpression="listValue" >
                <ItemStyle Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="listTitle" HeaderText="Title" SortExpression="listTitle" >
                <ItemStyle Width="85%" />
            </asp:BoundField>
            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" >
                <ItemStyle Width="5%" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            ( Empty )&nbsp;
        </EmptyDataTemplate>
    </asp:GridView>
