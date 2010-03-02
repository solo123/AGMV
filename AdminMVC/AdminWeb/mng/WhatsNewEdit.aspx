<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_WhatsNewEdit" Title="歐美旅遊-脩改最新消息" Codebehind="WhatsNewEdit.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
    <asp:FormView
        ID="fvWhatsnew" runat="server" DataKeyNames="newsId" DataSourceID="WhatsNewDataset" OnItemUpdating="fvWhatsnew_ItemUpdating">
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="更新">
            </asp:LinkButton>
            </li>
                    <li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="取消">
            </asp:LinkButton></li>
                </ul>
            <div style="clear:both"></div></div>

<table style="width: 100%">
    <tr>
        <td align="left" valign="top">ID:<asp:Label ID="newsIdLabel1" runat="server" Text='<%# Eval("newsId") %>'></asp:Label></td>
        <td align="right" valign="top"> 上次更新:<asp:Label ID="txtUpdateUser" runat="server" Text='<%# Eval("updateuser") %>'></asp:Label>
于<asp:Label ID="txtLastUpdate" runat="server" Text='<%# Eval("lastupdate") %>' ></asp:Label></td>
    </tr>
    <tr>
        <td class="edit_en" width="50%" valign="top">
            <table width="100%">
                <tr>
                    <td>Title:<br />
                        <asp:TextBox ID="txtTitle" runat="server" Width="95%" Text='<%# Bind("title") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="textBlock">Description:<br />
                    <asp:TextBox ID="txtDescription" runat="server" Rows="8" TextMode="MultiLine" Width="95%" Text='<%# Bind("description") %>'></asp:TextBox></td>
                </tr>
            </table>
        </td>
        
        <td class="edit_cn" width="50%" valign="top">
            <table width="100%">
                <tr>
                    <td>標題:<br />
                    <asp:TextBox ID="txtTitle_cn" runat="server" Width="95%" Text='<%# Bind("title_cn") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="textBlock">內容:<br />
                        <asp:TextBox ID="txtDescription_cn" runat="server" Rows="8" TextMode="MultiLine" Width="95%" Text='<%# Bind("description_cn") %>'></asp:TextBox></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="edit_en" colspan="2" style="height: 75px" valign="top">
            <asp:DropDownList ID="lstStatus" runat="server" SelectedValue='<%# Bind("status") %>'>
                <asp:ListItem Text="有傚" Value="1"></asp:ListItem>
                <asp:ListItem Text="無傚" Value="0"></asp:ListItem>
            </asp:DropDownList>    
</td>
    </tr>
</table>
        </EditItemTemplate>
       
        <ItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                Text="编辑" Enabled='<%# PageLogic.CheckActionAuth("auth_WhatsNewEdit") %>'>
            </asp:LinkButton></li>
                </ul>
            <div style="clear:both"></div></div>
            newsId:
            <asp:Label ID="newsIdLabel" runat="server" Text='<%# Eval("newsId") %>'></asp:Label><br />
            <table class="detail_view" width="100%">
                <tr>
                    <td class="prompt" width="50%">
                        title:<br />
            <asp:Label ID="titleLabel" runat="server" Text='<%# Bind("title") %>' CssClass="content"></asp:Label></td>
                    <td class="prompt" width="50%">
                        標題:<br />
            <asp:Label ID="title_cnLabel" runat="server" Text='<%# Bind("title_cn") %>' CssClass="content"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt textBlock">
                        Description:<asp:Label ID="descriptionLabel" runat="server" Text='<%# Bind("description") %>' CssClass="content"></asp:Label></td>
                    <td class="prompt textBlock">
                        說明:<br />
            <asp:Label ID="description_cnLabel" runat="server" Text='<%# Bind("description_cn") %>' CssClass="content"></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt">
                        Status:<asp:Label ID="statusLabel" runat="server" Text='<%# Bind("status") %>' CssClass="content"></asp:Label></td>
                    <td class="prompt">
                    </td>
                </tr>
                <tr>
                    <td class="prompt" colspan="2">
                        Last update by:<asp:Label ID="updateuserLabel" runat="server" Text='<%# Bind("updateuser") %>' CssClass="content"></asp:Label>
                        on
            <asp:Label ID="lastupdateLabel" runat="server" Text='<%# Bind("lastupdate") %>' CssClass="content"></asp:Label></td>
                </tr>
            </table>
            
        </ItemTemplate>
        
        <InsertItemTemplate>
<div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="btnInsert" runat="server" CausesValidation="True" CommandName="Insert"
                Text="添加" Enabled='<%# PageLogic.CheckActionAuth("auth_WhatsNewNew") %>'>
            </asp:LinkButton>
            </li>
                    <li><asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="取消">
            </asp:LinkButton></li>
                </ul>
            <div style="clear:both"></div></div>

<table style="width: 100%">
    <tr>
        <td align="left" valign="top">ID:<asp:Label ID="newsIdLabel1" runat="server" Text='<%# Eval("newsId") %>'></asp:Label></td>
        <td align="right" valign="top"> 上次更新:<asp:Label ID="txtUpdateUser" runat="server" Text='<%# Eval("updateuser") %>'></asp:Label>
于<asp:Label ID="txtLastUpdate" runat="server" Text='<%# Eval("lastupdate") %>' ></asp:Label></td>
    </tr>
    <tr>
        <td class="edit_en" style="width: 50%; height: 74px" valign="top">
            <table style="width: 100%">
                <tr>
                    <td style="width: 398px">Title:<br />
                        <asp:TextBox ID="txtTitle" runat="server" Width="95%" Text='<%# Bind("title") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 398px">Description:<br />
                    <asp:TextBox ID="txtDescription" runat="server" Rows="8" TextMode="MultiLine" Width="95%" Text='<%# Bind("description") %>'></asp:TextBox></td>
                </tr>
            </table>
        </td>
        
        <td class="edit_cn" style="width: 50%" valign="top">
            <table style="width: 100%">
                <tr>
                    <td>標題:<br />
                    <asp:TextBox ID="txtTitle_cn" runat="server" Width="95%" Text='<%# Bind("title_cn") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td>內容:<br />
                        <asp:TextBox ID="txtDescription_cn" runat="server" Rows="8" TextMode="MultiLine" Width="95%" Text='<%# Bind("description_cn") %>'></asp:TextBox></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="edit_en" colspan="2" style="height: 75px" valign="top">
            <asp:DropDownList ID="lstStatus" runat="server" SelectedValue='<%# Bind("status") %>'>
                <asp:ListItem Text="有傚" Value="1"></asp:ListItem>
                <asp:ListItem Text="無傚" Value="0"></asp:ListItem>
            </asp:DropDownList>    
</td>
    </tr>
</table>        
        </InsertItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="WhatsNewDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="com.Omei.DLL.DS_WhatsNewTableAdapters.WhatsNewDetailTableAdapter"
        UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="title" Type="String" />
            <asp:Parameter Name="title_cn" Type="String" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="description_cn" Type="String" />
            <asp:Parameter Name="status" Type="Int32" />
            <asp:Parameter Name="userId" Type="String" />
            <asp:Parameter Name="original_newsId" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="newsId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <br />&nbsp;

</asp:Content>

