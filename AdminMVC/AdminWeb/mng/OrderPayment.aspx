<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Page_OrderPayment" Title="歐美旅遊-訂單信息" Codebehind="OrderPayment.aspx.cs" %>
<%@ Register Src="../WebParts/OrderInfoCtl.ascx" TagName="OrderInfoCtl" TagPrefix="uc1" %>
<%@ Register Src="../WebParts/PaymentCtl.ascx" TagName="PaymentCtl" TagPrefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li><a href="OrderDetail.aspx">&lt;&lt;返回</a></li>
            <li><asp:Label ID="txtToolMessage" runat="server" ForeColor="Red"></asp:Label></li>
        </ul>
    <div style="clear:both"></div></div>

    <uc1:OrderInfoCtl ID="OrderInfoCtl1" runat="server" />

    <fieldset class="PaymentDiv">
        <uc2:PaymentCtl ID="PaymentCtl1" AfterPayment="AfterPayment" runat="server" />
    </fieldset>

</asp:Content>

