<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<OmeiWebModel.Tour>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
OmeiTravel.com - Tours
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<br />
    <table style="width: 100%" cellpadding="4" cellspacing="0" border="0">
        <tr>
            <td class="tab-bottom" style="width: 2.5%">&nbsp;
            </td>
            <td class="tab-pass" style="width: 10%; background-color: #e4eee0" align="center">
                Bus tour</td>
            <td style="width: 1.5%" class="tab-bottom">&nbsp;</td>
            <td class="tab-white" style="width: 10%" align="center">
                <%= Html.ActionLink("Schedules", "list/bus", "schedule")%>
            </td>
            <td class="tab-bottom" style="width: 76%">&nbsp;
            </td>
        </tr>
        <tr>
            <td class="box-no-top" colspan="5" style="background-color: #e4eee0" align="center">
                <br />


    
<%
    string m_imagePath = "";
    string m_detailPageUrl = "/tour/detail/";
    bool isAltStyle = true;
    bool openTag = false;
    int day = 0;
%>    
    <table border="0" cellspacing="0" cellpadding="4" width="100%">
        <tbody>
<%    
    
    foreach (var item in Model)
    {
        if (item.TourDay > day)
        {
            // write a new day seperator
            day = item.TourDay;

            if (openTag)
            {
                Response.Write("\n<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
            }

            Response.Write("<tr><td colspan='6' align='left' height='38' class='head02'> -- ");
            if (day > 3)
            {
                Response.Write("4 and more days tour --</td></tr>");
                day = 10000;
            }
            else
            {
                Response.Write(string.Format("{0} days tour -- </td></tr>", day));
            }
            openTag = false;
        }

        if (!openTag)
        {
            Response.Write(string.Format("\n\n<tr{0}>", isAltStyle? " class='tab-row-alt' ": ""));
            isAltStyle = !isAltStyle;
        }
        else
        {
            Response.Write("<td><img src='");
            Response.Write(m_imagePath);
            Response.Write("PageImg/space.gif' width=50 height=5 /></td>");
        }
%>
        <td width="46" valign="top">
            <img src='<%=m_imagePath %>upload/TourPics/TourPic_<%=item.TourID %>.jpg' width="45" height="34"
                style="border-color:white;border-width:1px;border-style:Solid;" alt="" />
        </td>
        <td width="6" valign="top">
            . 
        </td>
        <td width="250" align="left" class="commonList">
            <a href='<%=m_detailPageUrl %><%=item.TourID %>'>
                <%=item.TourName %> <%=OmeiMVC.Controllers.OmeiTools.GetDayNightText(item.TourDay, "en")%>
            </a><br />
            Adult:$<%=item.priceAdult%> Child:$<%=item.priceChild%>
        </td>
<%            
        if (openTag) Response.Write("</tr>");
        openTag = !openTag;
    }

    // footer
    if (openTag)
    {
        Response.Write("\n<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
    }
     %>
        </tbody>
    </table>


                <br />
            </td>
        </tr>
    </table>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

