<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="CreditCardList" Title="Untitled Page" Codebehind="CreditCardList.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="SearchBlock">
        <table>
            <tr>
                <td nowrap=nowrap>
                    &nbsp;<asp:DropDownList ID="lstIsWebOrder" runat="server">
                        <asp:ListItem Value="1">Web orders</asp:ListItem>
                        <asp:ListItem Value="0">Not web orders</asp:ListItem>
                    </asp:DropDownList></td>
                <td nowrap="nowrap">
                    <asp:DropDownList ID="lstPaymode" runat="server">
                        <asp:ListItem Value="2">Payed and no pay</asp:ListItem>
                        <asp:ListItem Value="1">Payed</asp:ListItem>
                        <asp:ListItem Value="0">Not pay</asp:ListItem>
                    </asp:DropDownList></td>
                <td nowrap=nowrap>
                        Date from:<uc1:DateInputCtl ID="dateFrom" runat="server" />
                    &nbsp;&nbsp;
                        to:<uc1:DateInputCtl ID="dateTo" runat="server" />
                    &nbsp;&nbsp;

                        <asp:Button ID="btnGo" runat="server" Text="Go" />                
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="CCListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="com.Omei.DLL.DS_CreditCardsTableAdapters.CreditCardListTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="lstIsWebOrder" Name="IsWebOrder" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="lstPaymode" Name="paymode" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="dateFrom" Name="orderStartDate" PropertyName="DateValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="dateTo" Name="orderEndDate" PropertyName="DateValue"
                Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    
    <asp:GridView ID="lstCCList" runat="server" AutoGenerateColumns="False" DataSourceID="CCListDataset" AllowPaging="True" PageSize="100" SkinID="DataList" Width="100%" DataKeyNames="crId" OnRowDataBound="lstCCList_RowDataBound">
        <Columns>
            <asp:BoundField DataField="orderId" HeaderText="orderId" SortExpression="orderId" />
            <asp:BoundField DataField="customerId" HeaderText="customerId" SortExpression="customerId" />
            <asp:BoundField DataField="firstName" HeaderText="firstName" SortExpression="firstName" />
            <asp:BoundField DataField="lastName" HeaderText="lastName" SortExpression="lastName" />
            <asp:BoundField DataField="cardType" HeaderText="cardType" SortExpression="cardType" />
            <asp:BoundField DataField="amount" HeaderText="amount" SortExpression="amount" />
            <asp:BoundField DataField="serviceFee" HeaderText="serviceFee" SortExpression="serviceFee" />
            <asp:BoundField DataField="orderDate" HeaderText="orderDate" SortExpression="orderDate" DataFormatString="{0:d}" HtmlEncode="False" />
            <asp:BoundField DataField="payDate" HeaderText="payDate" SortExpression="payDate" DataFormatString="{0:d}" HtmlEncode="False" />
        </Columns>
    </asp:GridView>
</asp:Content>

