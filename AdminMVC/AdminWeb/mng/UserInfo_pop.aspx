<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminPopup.master" AutoEventWireup="true" Inherits="UserInfo_pop" Title="Untitled Page" Codebehind="UserInfo_pop.aspx.cs" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Src="../Controls/CountrySelector.ascx" TagName="CountrySelector" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">
function CustomerSelected(info)
{
    if ( info==null || info.length<1 )
        alert("选中客户信息为空，请重新选择。");

    if ( typeof this.parent.GotCustomerInfo != 'undefined' && this.parent.GotCustomerInfo !=null ){
        //document.getElementById('detail_div').style.visibility='hidden';
        this.parent.GotCustomerInfo(info);
    } 
    else
        alert(info);
}
</script>

<asp:ObjectDataSource ID="UserInfoDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetUserDetail" TypeName="com.Omei.BLL.Admin.AdminUserBiz"
        UpdateMethod="UpdateUserDetail" InsertMethod="InsertUserDetail" OnInserted="UserInfoDataset_Inserted" >
        <UpdateParameters>
            <asp:Parameter Name="Original_userId" Type="Int32" />
            <asp:Parameter Name="firstName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="lastName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="address" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="zip" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="homePhone" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="cellPhone" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="walkyPhone" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="email" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="status" Type="Byte" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="userId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    <InsertParameters>
        <asp:Parameter Name="firstName" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="lastName" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="address" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="zip" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="homePhone" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="cellPhone" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="walkyPhone" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="email" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="status" Type="Byte" />
    </InsertParameters>
    </asp:ObjectDataSource>
    
<div id="detail_div"> 
    <asp:FormView ID="fvUserInfo" runat="server" DataKeyNames="userId" DataSourceID="UserInfoDataset" Width="100%" 
    OnDataBound="fvUserInfo_DataBound" >
        <EditItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update">
            </asp:LinkButton></li><li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li></ul>
        <div style="clear:both"></div></div>


userId:
            <asp:Label ID="userIdLabel" runat="server" CssClass="head01" Text='<%# Eval("userId") %>'></asp:Label><br />
            <table class="detail_view" width="100%" style="border:solid 1px darkgreen;" cellpadding="4" cellspacing="0">
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap" width="15%">
                        First name:
                    </td>
                    <td class="content" width="35%">
            <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'>
            </asp:TextBox></td>
                    <td align="left" class="prompt" nowrap="nowrap" width="15%">
                        Last name:</td>
                    <td class="content" width="35%">
            <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Address:</td>
                    <td class="content" colspan="3">
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' Width="300px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        City:
                    </td>
                    <td class="content">
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' Width="60px"></asp:TextBox></td>
                    <td align="left" class="prompt" nowrap="nowrap">
                        State:</td>
                    <td class="content" nowrap="noWrap">
            <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' Width="60px"></asp:TextBox>
                        zip:&nbsp;
            <asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>' Width="60px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Country:
                    </td>
                    <td class="content" colspan="3">
                        <uc1:CountrySelector ID="CountrySelector1" runat="server" 
                            CountryCode='<%# Bind("country") %>' Lang=0 />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap" colspan="4" height="1" bgcolor="darkgreen">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Tel:
                    </td>
                    <td class="content">

                        <igtxt:WebMaskEdit ID="WebMaskEdit1" runat="server" InputMask="(###) ###-####" Value='<%# Bind("homePhone") %>' >
                        </igtxt:WebMaskEdit>
            
            </td>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Mobile:</td>
                    <td class="content">
            <asp:TextBox ID="cellPhoneTextBox" runat="server" Text='<%# Bind("cellPhone") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Walky:</td>
                    <td class="content">
            <asp:TextBox ID="walkyPhoneTextBox" runat="server" Text='<%# Bind("walkyPhone") %>'>
            </asp:TextBox></td>
                    <td>
                    </td>
                    <td class="content">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap" colspan="4" bgcolor="darkgreen" height="1">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Email:</td>
                    <td class="content">
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' Width="95%"></asp:TextBox></td>
                <td class=prompt>
                    Status:</td>
                    <td class="prompt" nowrap="nowrap" align="left">
                        <asp:DropDownList ID="lstStatus" runat="server" SelectedValue='<%# Bind("status") %>'>
                            <asp:ListItem Value="0">hiden</asp:ListItem>
                            <asp:ListItem Value="1">show</asp:ListItem>
                            <asp:ListItem Value="2">Web</asp:ListItem>
                            <asp:ListItem Value="3">other</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>        
        </EditItemTemplate>
        <InsertItemTemplate>
<div class="toolbox listButtons">
            <ul>
                <li><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton></li><li><asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li></ul>
        <div style="clear:both"></div></div>
        
userId:
            <asp:Label ID="userIdLabel" runat="server" CssClass="head01" Text='<%# Eval("userId") %>'></asp:Label><br />
            <table class="detail_view" width="100%" style="border:solid 1px darkgreen;" cellpadding="4" cellspacing="0">
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap" width="15%">
                        First name:
                    </td>
                    <td class="content" width="35%">
            <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ErrorMessage="*" ControlToValidate="firstNameTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                      </td>
                    <td align="left" class="prompt" nowrap="nowrap" width="15%">
                        Last name:</td>
                    <td class="content" width="35%">
            <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Address:</td>
                    <td class="content" colspan="3">
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' Width="300px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        City:
                    </td>
                    <td class="content">
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' Width="60px"></asp:TextBox></td>
                    <td align="left" class="prompt" nowrap="nowrap">
                        State:</td>
                    <td class="content" nowrap="noWrap">
            <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' Width="60px"></asp:TextBox>
                        zip:&nbsp;
            <asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>' Width="60px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Country:
                    </td>
                    <td class="content" colspan="3">
                        <uc1:CountrySelector ID="CountrySelector1" runat="server" 
                            CountryCode='<%# Bind("country") %>' Lang=0 />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap" colspan="4" height="1" bgcolor="darkgreen">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Tel:
                    </td>
                    <td class="content">
            <asp:TextBox ID="homePhoneTextBox" runat="server" Text='<%# Bind("homePhone") %>'>
            </asp:TextBox></td>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Mobile:</td>
                    <td class="content">
            <asp:TextBox ID="cellPhoneTextBox" runat="server" Text='<%# Bind("cellPhone") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Walky:</td>
                    <td class="content">
            <asp:TextBox ID="walkyPhoneTextBox" runat="server" Text='<%# Bind("walkyPhone") %>'>
            </asp:TextBox></td>
                    <td>
                    </td>
                    <td class="content">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap" colspan="4" bgcolor="darkgreen" height="1">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Email:</td>
                    <td class="content">
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' Width="95%"></asp:TextBox></td>
                <td class=prompt>
                    Status:</td>
                    <td class="prompt" nowrap="nowrap" align="left">
                        <asp:DropDownList ID="lstStatus" runat="server" SelectedValue='<%# Bind("status") %>'>
                            <asp:ListItem Value="0">hiden</asp:ListItem>
                            <asp:ListItem Value="1" Selected=true>show</asp:ListItem>
                            <asp:ListItem Value="2">Web</asp:ListItem>
                            <asp:ListItem Value="3">other</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>         
        </InsertItemTemplate>
        <ItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                
                <li>
                    <asp:HyperLink ID="lnkSearch" NavigateUrl="SearchCustomer_pop.aspx" runat="server">Search</asp:HyperLink>
                </li>
                <li><asp:HyperLink ID="lnkSelect" runat="server" NavigateUrl="">Select this</asp:HyperLink></li>
                <li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                Text="Edit"></asp:LinkButton></li><li><asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                Text="New"></asp:LinkButton></li></ul>
        <div style="clear:both"></div></div>

            userId:
            <asp:Label ID="userIdLabel" runat="server" CssClass="head01" Text='<%# Eval("userId") %>'></asp:Label><br />
            <table class="detail_view" width="100%" style="border:solid 1px darkgreen;" cellpadding="4" cellspacing="0">
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap" width="15%">
                        First name:
                    </td>
                    <td class="content" width="35%">
                        <asp:Label ID="firstNameLabel" runat="server" Text='<%# Bind("firstName") %>'></asp:Label></td>
                    <td align="left" class="prompt" nowrap="nowrap" width="15%">
                        Last name:</td>
                    <td class="content" width="35%">
                        <asp:Label ID="lastNameLabel" runat="server" Text='<%# Bind("lastName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Address:</td>
                    <td class="content" colspan="3">
                        <asp:Label ID="addressLabel" runat="server" Text='<%# Bind("address") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        City:
                    </td>
                    <td class="content">
                        <asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>'></asp:Label></td>
                    <td align="left" class="prompt" nowrap="nowrap">
                        State:</td>
                    <td class="content" nowrap="noWrap">
                        <asp:Label ID="stateLabel" runat="server" Text='<%# Bind("state") %>'></asp:Label>
                        zip:
                        <asp:Label ID="zipLabel" runat="server" Text='<%# Bind("zip") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Country:
                    </td>
                    <td class="content" colspan="3">
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("country") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" class="prompt" nowrap="nowrap" colspan="4" height="1" bgcolor="darkgreen">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Tel:
                    </td>
                    <td class="content">
                        <asp:Label ID="homePhoneLabel" runat="server" Text='<%# Bind("homePhone") %>'></asp:Label></td>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Mobile:</td>
                    <td class="content">
                        <asp:Label ID="cellPhoneLabel" runat="server" Text='<%# Bind("cellPhone") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Walky:</td>
                    <td class="content">
                        <asp:Label ID="walkyPhoneLabel" runat="server" Text='<%# Bind("walkyPhone") %>'></asp:Label></td>
                    <td>
                    </td>
                    <td class="content">
                    </td>
                </tr>
                <tr>
                    <td align="right" class="prompt" nowrap="nowrap" colspan="4" bgcolor="darkgreen" height="1">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="prompt" nowrap="nowrap">
                        Email:</td>
                    <td class="content">
                        <asp:Label ID="emailLabel" runat="server" Text='<%# Bind("email") %>'></asp:Label></td>
                    <td>Status:</td>
                    <td class="prompt" nowrap="nowrap">
                        
                        <asp:Label ID="lbStatus" runat="server" CssClass="content" Text='<%# OmeiStatus.GetOmeiStatusText("UserStatus",Eval("status"),"en") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>

</div>     
</asp:Content>

