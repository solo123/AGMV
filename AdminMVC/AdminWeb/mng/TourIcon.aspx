<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="TourIcon" Title="Untitled Page" Codebehind="TourIcon.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:ObjectDataSource ID="TourListDataset" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetTourList" TypeName="com.Omei.DLL.DS_ToursTableAdapters.tourListTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="selectTourType" DefaultValue="99" Name="tourType"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    
    <asp:DropDownList ID="selectTourType" runat="server" AutoPostBack="True" 
        >
        <asp:ListItem Value="0">請選擇類型</asp:ListItem>
        <asp:ListItem Value="1">巴士團</asp:ListItem>
        <asp:ListItem Value="2">飛機團</asp:ListItem>
        <asp:ListItem Value="3">遊輪</asp:ListItem>
    </asp:DropDownList>
        &nbsp;
    
    <hr />
    
    <asp:GridView ID="lstTours" runat="server" AutoGenerateColumns="False" DataKeyNames="TourID"
        DataSourceID="TourListDataset" Width="100%" SkinID="DataList" AllowPaging="True" AllowSorting="True" OnRowDataBound="lstTours_RowDataBound"
        >
        <Columns>
            <asp:CommandField SelectText="" ShowSelectButton="True" UpdateImageUrl="~/Images/master/white.gif" />
            <asp:BoundField DataField="TourID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="TourID" />
            <asp:ImageField DataImageUrlField="TourID" DataImageUrlFormatString="~/OmeiWeb/images/upload/TourPics/TourPic_{0}.jpg">
            </asp:ImageField>
            <asp:BoundField DataField="TourName" HeaderText="Name" SortExpression="TourName" />
            <asp:BoundField DataField="TourName_cn" HeaderText="名稱" SortExpression="TourName_cn" />
            <asp:TemplateField HeaderText="Day &amp; Night" SortExpression="TourDay">
                <ItemStyle Wrap="False" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Literal ID="lbDay" runat="server" Text='<%# Eval("TourDay") %>'></asp:Literal>Days
                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="weekly" HeaderText="weekly" SortExpression="weekly" />
            <asp:TemplateField HeaderText="Type" SortExpression="tourType">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourType",Eval("tourType"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourType",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    
    <iframe id="frmUploadPhoto" width=0 height=0 scrolling=no frameborder=no src=""></iframe>

<script language=javascript type="text/javascript">
    var lastSelect = null;
    function prepareUpload(newLine, tourId)
    {
        if ( lastSelect==newLine ) return;
        
        if ( newLine.tagName!=null && newLine.tagName=="TR" ){
            if (lastSelect!=null )
                lastSelect.className = "list_item";
            
            lastSelect = newLine;
            lastSelect.className ="list_item_select";
            //lastSelect.style.backgroundColor='Yellow';
            
            
            var frm = document.all.frmUploadPhoto;
            if ( frm!=null)
            {
                frm.width = 640;
                frm.height = 200;
                frm.src = "TourPicUpload.aspx?id=" + tourId;
            }
        }
        
    }
</script>

</asp:Content>

