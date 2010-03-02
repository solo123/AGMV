<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_DestinationPics" Title="歐美旅遊-景點照片" Codebehind="DestinationPics.aspx.cs" %>

<%@ Register Src="../Controls/UploadPicCtl.ascx" TagName="UploadPicCtl" TagPrefix="uc2" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>
<%@ Register Src="../Controls/UploadPicCtl.ascx" TagName="UploadPicCtl" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp;
    
    <asp:ObjectDataSource ID="PhotoListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetPhotoList" TypeName="com.Omei.DLL.DS_PhotoListTableAdapters.PhotosTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
        <SelectParameters>
            <asp:QueryStringParameter Name="relateId" Type="Int32" QueryStringField="id" />
            <asp:Parameter Name="picType" Type="Int32" DefaultValue=1 />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_picId" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="title" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="title_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="status" Type="Byte" />
            <asp:Parameter Name="picOrder" Type="Int32" />
            <asp:Parameter Name="Original_picId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="title" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="title_cn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="status" Type="Int32" />
            <asp:Parameter Name="picOrder" Type="Int32" />
            <asp:Parameter Name="picType" Type="Int32" DefaultValue=1 />
            <asp:QueryStringParameter Name="relateId" Type="Int32" QueryStringField="id" />
        </InsertParameters>
    </asp:ObjectDataSource>

    
    <asp:Label CssClass="head02" ID="lbDestinationName" runat="server" />&nbsp;
    <asp:LinkButton ID="btnNew" runat="server" OnClick="btnNew_Click">Add New Photo</asp:LinkButton>
    <hr />
    
    <asp:DataList ID="lstPics" runat="server" DataKeyField="picId" RepeatColumns="7" CellPadding="2" CellSpacing="2" DataSourceID="PhotoListDataset" OnSelectedIndexChanged="lstPics_SelectedIndexChanged">
        <ItemTemplate>
            <asp:LinkButton ID="btnPhotoSelected" runat="server" CommandArgument='<%# Eval("picId") %>'
                CommandName="Select">
                Photo ID:<%# Eval("picId") %> <br />
                <%# Eval("title") %> <br />
                <%# Eval("title_cn")%>
            </asp:LinkButton>
            <br />
            <asp:ImageButton ID="ImageButton1" runat="server" BorderColor="Black" BorderStyle="Solid"
                BorderWidth="1px" CommandArgument='<%# Eval("picId") %>' CommandName="Select"
                ImageUrl='<%# Eval("picId", "~/OmeiWeb/images/upload/destinationPics/DestTn_{0}.jpg") %>'
                Height="75px" Width="100px" />
        </ItemTemplate>
        <SelectedItemStyle BackColor="Yellow" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
    </asp:DataList>


    <asp:FormView ID="fvPicDetail" runat="server" DataKeyNames="picId" DataSourceID="PhotoListDataset" 
        Width="100%" 
        OnItemUpdated="fvPicDetail_ItemUpdated">
        <EditItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li class="head02">[Edit Photo:<asp:Literal ID="lbPicId" Text='<%# Eval("picId") %>' runat="server"></asp:Literal>] </li>
                <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update" ValidationGroup="DestPhotoUpdateGroup" Enabled='<%# PageLogic.CheckActionAuth("auth_DestinationPicsEdit") %>'></asp:LinkButton></li>
                <li>
                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel">Cancel</asp:LinkButton></li>
                
                
            </ul><div style="clear:both"></div>
        </div>
            <table width="100%" cellpadding=2 cellspacing=2 border=0>
                <tr>
                    <td>Title:</td>
                    <td><asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' /></td>
                    <td>图片标题：</td>
                    <td><asp:TextBox ID="title_cnTextBox" runat="server" Text='<%# Bind("title_cn") %>' /></td>
                </tr>
                <tr>
                    <td>
                        Order:</td>
                    <td>
            <asp:TextBox ID="picOrderTextBox" runat="server" Text='<%# Bind("picOrder") %>' ValidationGroup="DestPhotoUpdateGroup"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="picOrderTextBox"
                            Display="Dynamic" ErrorMessage="必須是數字" Operator="DataTypeCheck" SetFocusOnError="True"
                            Type="Integer" ValidationGroup="DestPhotoUpdateGroup"></asp:CompareValidator></td>
                    <td>
                        Status:</td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="1">有效</asp:ListItem>
                            <asp:ListItem Value="0">无效</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <uc3:UploadPicCtl ID="uploadPicCtl" runat="server" 
                             SaveToExtension=".jpg"
                             AllowPictureType=".jpg"
                             PhotoSaveToPath="~/OmeiWeb/images/upload/destinationPics"
                             PhotoWidth=500 PhotoHeight=375
                             ThumbSaveToPath="~/OmeiWeb/images/upload/destinationPics"
                             ThumbWidth=100 ThumbHeight=75
                             PhotoSaveToName='<%# Eval("picId", "DestPic_{0}") %>'
                             ThumbSaveToName='<%# Eval("picId", "DestTn_{0}") %>'
                        />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert" Enabled='<%# PageLogic.CheckActionAuth("auth_DestinationPicsNew") %>' ValidationGroup="DestPhotoInsertGroup"></asp:LinkButton></li>
                    <li><asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li>
                </ul><div style="clear:both"></div>
            </div>
            
            新增图片:
            <br />
            <table style="width: 100%" cellpadding=2 cellspacing=2 border=0>
                <tr>
                    <td>
                                        Title:</td>
                    <td>
            <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                                        圖片標題:</td>
                    <td>
            <asp:TextBox ID="title_cnTextBox" runat="server" Text='<%# Bind("title_cn") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Order:</td>
                    <td>
            <asp:TextBox ID="picOrderTextBox" runat="server" Text='<%# Bind("picOrder") %>' ValidationGroup="DestPhotoInsertGroup"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="picOrderTextBox"
                            Display="Dynamic" ErrorMessage="必須是數字" Operator="DataTypeCheck" SetFocusOnError="True"
                            Type="Integer" ValidationGroup="DestPhotoInsertGroup"></asp:CompareValidator></td>
                </tr>
                <tr>
                    <td>
                        Status:</td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="1">有效</asp:ListItem>
                            <asp:ListItem Value="0">无效</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text='<%# Eval("picId", "Edit Photo:{0}") %>' Enabled='<%# PageLogic.CheckActionAuth("auth_DestinationPicsEdit") %>' /></li>
                    <li><asp:LinkButton ID="btnDel" runat="server" Text="Delete" CommandName="Delete" Enabled='<%# PageLogic.CheckActionAuth("auth_DestinationPicsDel") %>'
                        OnClientClick="javascript:return confirm('刪除操作不能恢復!\n\n如果您是需要此數據不顯示在網站上，可以通過調整狀態標誌達到目的。\n\n您確認還是要刪除嗎？');"></asp:LinkButton>
                </li>
                </ul><div style="clear:both"></div>
            </div>
        </ItemTemplate>
    </asp:FormView>


<script language=javascript type="text/javascript">
    function prepareUpload(picId)
    {
        var frm = document.all.frmUploadPhoto;
        if ( frm!=null)
        {
            frm.width = 640;
            frm.height = 440;
            frm.src = "DestinationPicUpload.aspx?id=" + picId;
        }
        
    }
</script>
</asp:Content>

