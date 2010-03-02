<%@ Page Language="C#" Theme="" AutoEventWireup="true" Inherits="LeftMenu" Codebehind="LeftMenu.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <META HTTP-EQUIV="Window-target" CONTENT="_top"> 
    <title>OmeiTravel.com</title>
    <link href="Images/leftMenu.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" language="javascript">
        var lastActiveMenuItem = null;
        function MenuClick(item)
        {
            if ( item!=null && item.parentElement!=null && item.parentElement.tagName=="TD")
            {
                if ( lastActiveMenuItem != null )
                    lastActiveMenuItem.className = "";
                    
                item.parentElement.className = "selected";
                lastActiveMenuItem = item.parentElement;
            }
        }
        
        function hidetoc()
        {
          top.fstMain.cols = "1,*";
          top.fraTop.document.all("showtoc").innerHTML = "<img src='Images/res/showtoc.gif' />Show TOC";
        }
        
        function enter(sender) 
        {
            if(window.event && window.event.keyCode == 13) 
            {
                if (sender!=null)
                {
                    if(sender.id=="txtOrderID") QuickGoOrder();
                    if(sender.id=="txtScheduleID") QuickGoSchedule();
                }
                return false; 
            } else
                return true;
        }
        
        function QuickGoOrder()
        {
            QuickGo("OrderDetail.aspx", "txtOrderID");
        }
        function QuickGoSchedule()
        {
            QuickGo("BusSeats.aspx", "txtScheduleID");
        }
        function QuickGo(pageUrl, txtId)
        {
            var t = document.getElementById(txtId);
            if ( t ==null ) return;
            
            if ( t.value=="" ) 
                t.focus();
            else {
                top.ContentFrame.location = pageUrl + "?id=" + t.value;
                t.select();
            }
        }

    </script>
</head>
<body background="Images/res/background.png">
    <form id="form1" runat="server">
    <table cellpadding=0 cellspacing=0 border=0 width="100%" >
        <tr bgcolor="#cccccc">
            <td width="100%"></td>
            <td align=right>
                <img src="Images/res/synctoc1.gif" onclick="window.location.reload(true);" />&nbsp;&nbsp;</td>
            <td align=right>
                <img src="Images/res/hidetoc1.gif" style="CURSOR: hand" onclick=hidetoc(); alt="Hide TOC" title="Hide TOC" /></td>
            <td>&nbsp;&nbsp;</td>
        </tr>
    </table>
    <br />
    <table width="95%">
        <tr>
            <td class=leftMenu>
                <H1>Quick Go</H1>
                <DIV>
                    <table width="95%" cellpadding="2" cellspacing="2">
                        <tr>
                            <td>
                                Order ID:<br />
                                <input id="txtOrderID" type="text" style="width:60px;" onkeypress="return enter(this)" />
                                <input id="Button1" type="button" value="Go" onclick="QuickGoOrder();" />
                            </td>
                       </tr>
                        <tr>
                            <td>
                                Schedule ID:<br />
                                <input id="txtScheduleID" type="text" style="width:60px;" onkeypress="return enter(this)" />
                                <input id="Button2" type="button" value="Go" onclick="QuickGoSchedule();" />
                            </td>
                       </tr>
                        
                    </table>
                </DIV>
            </td>        
        </tr>
        <tr>
            <td class="leftMenu">
            <H1>Sub menu</H1>
                <DIV>
                    <asp:Repeater ID="Repeater1"  runat="server" DataSourceID="SubMenuDataset">
                        <HeaderTemplate>
                            <table width="95%" cellpadding="2" cellspacing="2">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("menuTitle").ToString() == "hr" ? "<tr><td><hr /></td></tr>" : "<tr><td>»<a OnClick='MenuClick(this);' hidefocus=hideFocus unselectable=on href='" + Eval("contentUrl") + "' target='ContentFrame'>" + Eval("menuTitle") + "</a></td></tr>"%>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </DIV>
            </td>
        </tr>
    </table>
    
    
        <asp:ObjectDataSource ID="SubMenuDataset" runat="server" SelectMethod="GetSubMenuData"
            TypeName="com.Omei.BLL.Admin.AdminMenuBiz" OldValuesParameterFormatString="original_{0}">
            <SelectParameters>
                <asp:QueryStringParameter Name="parentId" QueryStringField="pid" Type="Int32" />
                <asp:Parameter Name="userRole" Type="String" />
                <asp:Parameter Name="userPos" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </form>
</body>
</html>
