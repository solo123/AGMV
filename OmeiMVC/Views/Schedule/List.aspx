<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<OmeiWebModel.V_schedule>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
OmeiTravel.com - Schedules
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <table style="width: 100%" cellpadding="4" cellspacing="0" border="0">
        <tr>
            <td class="tab-bottom" style="width: 2.5%">&nbsp;
            </td>
            <td class="tab-white" style="width: 10%;" align="center">
                Tours
            </td>
            <td style="width: 1.5%" class="tab-bottom">&nbsp;</td>
            <td class="tab-pass" style="width: 10%;  background-color: #e4eee0" align="center">
                Schedule</td>
            <td class="tab-bottom" style="width: 76%;">&nbsp;
            </td>
        </tr>
        <tr>
            <td class="box-no-top" colspan="5" style="background-color: #e4eee0" align="center">
                <br />

<%
    bool m_alt = false;
    int m_dt = DateTime.Now.AddDays(-10).DayOfYear;
     %>
     
    <table cellspacing="0" cellpadding="4" width="100%" rules="all" border="0" 
        style="border-width:0px;border-collapse:collapse;">
        <thead>
            <tr style="color:White;background-color:#5C8E4B;">
                <th style="background-color:#355C2F;">Schedule ID</th>
                <th>Tour name</th>
                <th style="background-color:#355C2F;">Price(Adult/Child)</th>
                <th>Order</th>
            </tr>
        </thead>
        <tbody>
<% 
    foreach (var item in Model)
    {
        if (item.startDate.DayOfYear != m_dt)
        {
            m_alt = false;
            // day seperator
            %>
            <tr><td colspan='4'>&nbsp;</td></tr>
            <tr><td colspan='4'><span style='background-color:#C8E0C0; border: solid 1px #5C8E4B; padding: 2px 6px 4px 6px;'>
                Departure Date:<%=item.startDate.ToShortDateString()%> </span></td>
            </tr>
            <tr><td colspan='4' height='1' style='background-color:#5C8E4B;'></td></tr>
            <%
    }
     %>
        <tr <%=m_alt?"class='alt'":"" %>>
            <td><%=item.scheduleId%></td>
            <td><%=item.TourName%> <%=OmeiMVC.Controllers.OmeiTools.GetDayNightText(item.TourDay, "en")%>
            <%
    if (item.subTitle.Length > 1)
    { %>
            (<%=item.subTitle%>)
        <%
    } %>
            </td>
            <td> $<%=item.priceAdult%> / $<%=item.priceChild%>
            </td>
            <td>
            <%
    int maxSeats = item.maxSeats;
    if (maxSeats == 0) maxSeats = 57;
    if (maxSeats - item.bookCustomers - item.actualCustomers > 3)
    {
        %>
                <img src='images/lang/ordernow.gif' style='cursor: pointer;' alt='order' 
                    onclick='DoOrder("<%=item.scheduleId %>")' />
        <%
    }
    else
    {
        %>
        <font color='red'>Full</font>
        <%
    }
        %>
            </td>
        </tr>
     <% } %>
        </tbody>
    </table>
    <hr />

                <br />
            </td>
        </tr>
    </table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

