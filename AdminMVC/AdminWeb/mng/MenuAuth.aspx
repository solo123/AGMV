<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="MenuAuth" Title="Untitled Page" Codebehind="MenuAuth.aspx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc3" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:ObjectDataSource ID="RolesDataset" runat="server" SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter"
    OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="Role" Name="listClass" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
Role:<uc3:DataSelector ID="lstRole" runat="server"
    DataSourceID="RolesDataset" DataTextField="listTitle" DataValueField="listValue" 
    DefaultValue="-1" NoSelectPrompt="--Please select role--" AutoPostBack="true"  />
    <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="javascript:GetSelectedResult(); return confirm('Are you sure to save authorization?');" OnClick="btnSave_Click" />
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label><br /> 
    
<div class="ContentBox">
    <asp:Literal ID="txtMenu" runat="server"></asp:Literal>
</div>

    <asp:HiddenField ID="hdMenuSelected" runat="server" />
    <asp:HiddenField ID="hdActionSelected" runat="server" />

<script type="text/javascript">
function GetSelectedResult()
{
    var result = "";
    if ( Results!=null && Results.length>1 )
    {
        SetHiddenValue(Results[0], GetArrayResult("menu_" , ChkMenus));
        SetHiddenValue(Results[1], GetArrayResult("action_" , ChkActions));
    }
}
function SetHiddenValue(fieldName, val)
{
    var hd = document.getElementById(fieldName);
    if(hd!=null)
    {
        hd.value = val;
    }
}
function GetArrayResult(pre, arr)
{
    var result = "";
    if (arr != null)
    {
        for (var i = 0; i < arr.length; i++)
        {
            var cb = document.getElementById(pre + arr[i]);
            if ( cb!=null)
            {
                if(cb.checked)
                {
                    result += arr[i]  + ",";
                }
            }
        }
    }
    return result;
}
</script>
    
</asp:Content>

