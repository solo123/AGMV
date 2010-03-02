<%@ Control Language="C#" ClassName="PicSelectorCtl" %>

<script runat="server">
    public int DestinationId
    {
        set
        {
            PicsDataset.SelectParameters["relateId"].DefaultValue = value.ToString();
            lstPics.DataBind();
        }
    }
</script>

<script language=javascript type="text/javascript">
var currentSelectedPic = null;
function selectPic( aDiv, picId )
{
    if ( currentSelectedPic!=aDiv )
    {
        if ( currentSelectedPic!=null )
            currentSelectedPic.className = "normal";
        
        currentSelectedPic = aDiv;
        currentSelectedPic.className = "selected";
        SetVal(picId);
    }
}
</script>

<asp:ObjectDataSource ID="PicsDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetPhotoList" TypeName="com.Omei.DLL.DS_PhotoListTableAdapters.PhotosTableAdapter">
    <SelectParameters>
        <asp:Parameter DefaultValue="" Name="relateId" Type="Int32" />
        <asp:Parameter DefaultValue="1" Name="picType" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<div id="PhotoList">
    <asp:DataList ID="lstPics" runat="server" DataKeyField="picId" DataSourceID="PicsDataset" RepeatColumns="5" RepeatDirection="Horizontal">
        <ItemTemplate>
            <div class="normal" onclick='selectPic(this, <%# Eval("picId") %>);'>
                ID:
                <asp:Label ID="picIdLabel" runat="server" Text='<%# Eval("picId") %>'></asp:Label><br />
                <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>'></asp:Label><br />
                <asp:Label ID="title_cnLabel" runat="server" Text='<%# Eval("title_cn") %>'></asp:Label><br />
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("picId", "~/OmeiWeb/images/upload/destinationPics/DestTn_{0}.jpg") %>' Height="75px" Width="100px" />
            </div>
        </ItemTemplate>
    </asp:DataList>
</div>