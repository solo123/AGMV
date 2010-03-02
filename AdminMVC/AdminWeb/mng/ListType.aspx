<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ListType" 
Title="O'Mei - Lists" Codebehind="ListType.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	    
    <p>
    <asp:DropDownList ID="seleList" runat="server" DataSourceID="TypeNamesDataset" DataTextField="listClass" AutoPostBack="true" DataValueField="listClass" />
    </p>
    <asp:GridView ID="lstTypes" runat="server" DataSourceID="typeRefDataset" AutoGenerateColumns="False" DataKeyNames="tid" SkinID="DataList">
        <Columns>
            <asp:BoundField DataField="tid" HeaderText="tid" InsertVisible="False" ReadOnly="True"
                SortExpression="tid" />
            <asp:BoundField DataField="listClass" HeaderText="Class" SortExpression="listClass" />
            <asp:BoundField DataField="listValue" HeaderText="Value" SortExpression="listValue" />
            <asp:BoundField DataField="listTitle" HeaderText="Prompt" SortExpression="listTitle" />
            <asp:BoundField DataField="listTitle_cn" HeaderText="Prompt_cn" SortExpression="listTitle_cn" />
            <asp:BoundField DataField="listStyle" HeaderText="Style" SortExpression="listStyle" />
            <asp:BoundField DataField="listBack" HeaderText="Background" SortExpression="listBack" />
            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
            <asp:CommandField SelectText="修改" ShowSelectButton="True" />
        </Columns>
    </asp:GridView>

    <asp:ObjectDataSource ID="typeRefDataset" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetStatusByClass" 
        TypeName="com.Omei.BLL.Admin.TypeRefBiz" DeleteMethod="DeleteOmeiStatus">
        <SelectParameters>
            <asp:ControlParameter ControlID="seleList" DefaultValue="SelectValue" Name="listClass"
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="original_tid" Type="Int32" />
            </DeleteParameters>
    </asp:ObjectDataSource>
    
    <hr />
<div id="edit_win">
    <asp:FormView ID="fvTypeRef" runat="server" DataSourceID="typeRefDetailDataset" 
        DataKeyNames="tid" BackColor="#C8E0C0" Width="600px" >
        <ItemTemplate>
            <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton></li>
                <li><asp:LinkButton ID="btnDel" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Delete cannot be recover. \n\nAre you sure to DELETE it?');">Del</asp:LinkButton></li>
                <li><asp:LinkButton ID="btnAdd" runat="server" CommandName="New" Text="Add" /></li>
                <li>If changed, please click <asp:LinkButton ID="btnReload" Text="Reload" runat="server" OnClick="btnReload_Click" /></li>
            </ul>
        <div style="clear:both"></div></div>
        <table class="detail_view" cellpadding="4" cellspacing="0">
            <tr>
                <td class="prompt">Class:</td>
                <td class="content"><asp:Label ID="lbTypeName" runat="server" Text='<%# Eval("listClass") %>' /></td>
            </tr>
            <tr>
                <td class="prompt">Value:</td>
                <td class="content"><asp:Label ID="lbValue" runat="server" Text='<%# Eval("listValue") %>' /></td>
            </tr>
            <tr>
                <td class="prompt">Prompt:</td>
                <td><asp:Label ID="lbTitle" runat="server" Text='<%# Eval("listValue") %>'  />
                </td>
            </tr>
        </table>
    </ItemTemplate>
    
    <EditItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update">Update</asp:LinkButton></li>
                <li><asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel">Cancel</asp:LinkButton></li>
            </ul>
        <div style="clear:both"></div></div>
        <table cellpadding=4 cellspacing=0 class=detail_view >
            <tr>
                <td nowrap="noWrap">
                    ID:</td><td><asp:Label ID="Label1" runat="server" Text='<%# Eval("tid") %>' Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Class:</td><td><asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("listClass") %>' Width="100px"></asp:TextBox></td>
            </tr>
            <tr>    
                <td>
                    Value:</td><td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("listValue") %>' Width="50px"></asp:TextBox></td>
                
            </tr><tr>    
                <td>
                    Prompt:</td><td><asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("listTitle") %>' Width="150px"></asp:TextBox>
            &nbsp;/&nbsp;
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("listTitle_cn") %>' Width="150px"></asp:TextBox></td>
            </tr><tr>    
                <td>Style:</td><td><asp:TextBox ID="txtStyle" runat="server" Text='<%# Bind("listStyle") %>' Width="150px" /></td>
            </tr><tr>    
                <td>Background:</td><td><asp:TextBox ID="txtBack" runat="server" Text='<%# Bind("listBack") %>' Width="100px" /></td>
            </tr><tr>    
                <td>
                    Status:</td><td><asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("status") %>' Width="30px"></asp:TextBox></td>
            </tr>
        </table>
        
    </EditItemTemplate>
    
    <InsertItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="btnSave" runat="server" CommandName="Insert">Add</asp:LinkButton>
                </li><li><a href="TypeRef.aspx">Cancel</a></li>
            </ul>
        <div style="clear:both"></div></div>
        <table cellpadding=4 cellspacing=0 class=detail_view width="300">
            <tr>
                <td nowrap="nowrap" colspan=2>
                    <b>New item</b></td>
            </tr>
            <tr>    
                <td>
                    Class:</td><td><asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("listClass") %>' Width="100px"></asp:TextBox></td>
            </tr>
            <tr>    
                <td>
                    Value:</td><td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("listValue") %>' Width="50px"></asp:TextBox></td>
            </tr><tr>    
                <td>
                    Prompt:</td><td><asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("listTitle") %>' Width="150px"></asp:TextBox>
            &nbsp;/&nbsp;
                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("listTitle_cn") %>' Width="150px"></asp:TextBox></td>
            </tr><tr>    
                <td>Style:</td><td><asp:TextBox ID="txtStyle" runat="server" Text='<%# Bind("listStyle") %>' Width="150px" /></td>
            </tr><tr>    
                <td>Background color:</td><td><asp:TextBox ID="txtBack" runat="server" Text='<%# Bind("listBack") %>' Width="100px" /></td>
            </tr>
            
        </table>
           
    </InsertItemTemplate>
</asp:FormView>
</div>
<asp:ObjectDataSource ID="TypeNamesDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.TypeNameListTableAdapter" DeleteMethod="DeleteTypes">
    <DeleteParameters>
        <asp:Parameter Name="listClass" Type="String" />
    </DeleteParameters>
</asp:ObjectDataSource>
    
<asp:ObjectDataSource ID="typeRefDetailDataset" runat="server" InsertMethod="AddOmeiStatus"
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetStatusByID" TypeName="com.Omei.BLL.Admin.TypeRefBiz"
    UpdateMethod="UpdateOmeiStatus" DeleteMethod="DeleteOmeiStatus">
    <UpdateParameters>
        <asp:Parameter Name="original_tid" Type="Int32" />
        <asp:Parameter Name="listClass" Type="String" />
        <asp:Parameter Name="listTitle" Type="String" />
        <asp:Parameter Name="listTitle_cn" Type="String" />
        <asp:Parameter Name="listValue" Type="String" />
        <asp:Parameter Name="listStyle" Type="String" />
        <asp:Parameter Name="listBack" Type="String" />
        <asp:Parameter Name="status" Type="Int32" />
    </UpdateParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="lstTypes" DefaultValue="0" Name="tid"
            PropertyName="SelectedDataKey.Value" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:Parameter Name="listClass" Type="String" />
        <asp:Parameter Name="listTitle" Type="String" />
        <asp:Parameter Name="listTitle_cn" Type="String" />
        <asp:Parameter Name="listValue" Type="String" />
        <asp:Parameter Name="listStyle" Type="String" />
        <asp:Parameter Name="listBack" Type="String" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="original_tid" Type="Int32" />
    </DeleteParameters>
</asp:ObjectDataSource>

</asp:Content>

