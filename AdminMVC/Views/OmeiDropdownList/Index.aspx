<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <title>O'Mei - Dropdown Lists</title>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Dropdown Lists</h2>
    
    <p>
        Please select:
        <select id="seleType" onchange="javascript:alert('selected')">
            <option value="AgentOrders">AgentOrders</option>
            <option value="AgentPaymentMethod">AgentPaymentMethod</option>
            <option value="bookmarkStatus">bookmarkStatus</option>
            <option value="BusType">BusType</option>
            <option value="CompanyStatus">CompanyStatus</option>
            <option value="CompanyType" selected="selected">CompanyType</option>
            <option value="CreditCard">CreditCard</option>
            <option value="Discount">Discount</option>
            <option value="FlightStatus">FlightStatus</option>
            <option value="InvoiceMatchStatus">InvoiceMatchStatus</option>
            <option value="InvoiceStatus">InvoiceStatus</option>
            <option value="LogType">LogType</option>
            <option value="MenuType">MenuType</option>
            <option value="OrderStatus">OrderStatus</option>
            <option value="PaymentMethod">PaymentMethod</option>
            <option value="PaymentReason">PaymentReason</option>
            <option value="PickUp">PickUp</option>
            <option value="Position">Position</option>
            <option value="Role">Role</option>
            <option value="ScheduleStatus">ScheduleStatus</option>
            <option value="TicketType">TicketType</option>
            <option value="TourFee">TourFee</option>
            <option value="TourStatus">TourStatus</option>
            <option value="TourType">TourType</option>
            <option value="UserStatus">UserStatus</option>
            <option value="VoucherStatus">VoucherStatus</option>
            <option value="WebSite">WebSite</option>
        </select>
    </p>
    
    <table cellpadding="4" cellspacing="0" class="DataList">
        <thead>
            <tr class="list_head">
                <td>ID#</td>
                <td>Class</td>
                <td>Value</td>
                <td>Prompt</td>
                <td>Prompt_cn</td>
                <td>Style</td>
                <td>Backgound</td>
                <td>Status</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>ID#</td>
                <td>Class</td>
                <td>Value</td>
                <td>Prompt</td>
                <td>Prompt_cn</td>
                <td>Style</td>
                <td>Backgound</td>
                <td>Status</td>
            </tr>
        </tbody>
    </table>
    
    <div>
        edit win
    </div>

</asp:Content>

