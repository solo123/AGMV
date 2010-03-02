<%@ Page Language="C#" Theme="" AutoEventWireup="true" Inherits="Top" Codebehind="Top.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>OmeiTravel.com</title>
    <link href="Images/tab.css" rel="stylesheet" type="text/css" />
    <link href="Images/leftMenu.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" language="javascript">
        var lastActiveMenuItem = null;
        function MenuClick(item)
        {
            //debugger;
            if ( item!=null && item.parentElement!=null && item.parentElement.tagName=="LI")
            {
                if ( lastActiveMenuItem != null )
                {
                    // if same as lastActive, don't refresh leftmenu by return false;
                    if ( lastActiveMenuItem == item.parentElement && top.ContentFrame!=null )
                    {
                        lastActiveMenuItem.className = "selected";
                        return false;
                    }
                    
                    // clear contentFrame
                    top.ContentFrame.location = "Blank.aspx";
                    
                    // clear last active tab
                    lastActiveMenuItem.className = "";
                }
                    
                // Set lastActiveMenuItem and class change to "selected"
                lastActiveMenuItem = item.parentElement;
                lastActiveMenuItem.className = "selected";
            }
            return true;
        }
        function showtoc()
        {
          top.fstMain.cols = "152,*";
          document.all("showtoc").innerHTML = "";
        }
    </script>
</head>
<body background="Images/res/backhead.gif">
    <form id="form1" runat="server">
    <div align="right">
        <table cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td nowrap>
                    歡迎<asp:Label ID="txtUsername" runat="server" Font-Bold="True"></asp:Label>！</td>
                <td>&nbsp;|&nbsp;</td>
                <td nowrap>
                    <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click">Logout</asp:LinkButton>
                    
                </td>
                <td width="30">&nbsp;</td>
            </tr>
        </table>
    </div>
    
    <DIV id=nav>
        <UL class=tab>
            <LI class=home style="width:80px;">
                <span id="showtoc" onclick="showtoc();" style="font-size:8px; text-decoration:underline; padding:6px 4px 0px 4px"></span> &nbsp;</LI>
            <LI class=home>
                <A href="default.htm"><IMG alt="" src="Images/res/home.gif">Home</A>&nbsp;
            </LI>
            <asp:Repeater ID="mainMenu" runat="server" DataSourceID="MenuDataset">
                <HeaderTemplate></HeaderTemplate>
                <FooterTemplate></FooterTemplate>
                <ItemTemplate>
                    <LI>
                        <asp:HyperLink ID="HyperLink1" hidefocus="hideFocus" unselectable="on"  OnClick="return MenuClick(this);" NavigateUrl='<%# Eval("leftmenuUrl") %>' Target="fraLeft" runat="server"><%# Eval("menuTitle") %></asp:HyperLink>
                    </LI>
                </ItemTemplate>
            </asp:Repeater>
        </UL>
    </DIV>
    
    <asp:ObjectDataSource ID="MenuDataset" runat="server" 
        SelectMethod="GetMainMenuData"
        TypeName="com.Omei.BLL.Admin.AdminMenuBiz">
        <SelectParameters>
            <asp:Parameter Name="userRole" Type="String" />
            <asp:Parameter Name="userPos" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </form>
            
</body>
</html>
