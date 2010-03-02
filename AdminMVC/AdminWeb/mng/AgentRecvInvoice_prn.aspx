<%@ Page Language="C#" MasterPageFile="~/PrintMaster.master" AutoEventWireup="true" 
    Theme="themePrint" Inherits="AgentRecvInvoice_prn" Title="Print Agent Receive Invoice" Codebehind="AgentRecvInvoice_prn.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="680" cellpadding="0" cellspacing="0">
    <tr>
        <td width="50%" align="left">
            <span class="head01">OMEI TRAVEL(USA) INC</span><br />
            <span class="head02">
                240 Grand street, 3<sup>rd</sup> floor <br />
                New York, NY 10002<br />
                Tel: (212)219-1218<br />
                Fax: (212)219-8112<br />
                Email: accounting@omeitravel.com<br />
                </span>
                <br />
                
                
                <table  width="300" cellpadding="4" cellspacing="0" border="0" class="InfoBox">
                    <tr>
                        <td><b>Bill To:</b><asp:Label ID="lbAgentName" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td height="1" bgcolor="black"></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lbAgentAddress" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Tel:<asp:Label ID="lbAgentTel" runat="server" Text=""></asp:Label>
                        &nbsp;Fax:<asp:Label ID="lbAgentFax" runat="server" Text=""></asp:Label>
                        </td>
                        
                    </tr>
                </table>
                

                

        </td>        
        <td width="50%" align="right" valign="top">
            <span class="head01">INVOICE</span><br />
            <table width="200" border="1" cellpadding=4 cellspacing=0 class="InfoBox">
                <tr>
                    <td align="center">Date</td>
                    <td align="center">Invoice#</td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lbCreateDate" runat="server" Text=""></asp:Label></td>
                    <td align="center">
                        <asp:Label ID="lbInvoiceNumber" runat="server" CssClass="head01" Text=""></asp:Label></td>
                </tr>
            </table>
            
        </td>
    </tr>
    <tr><td colspan="2" height="16"></td></tr>
    <tr>
        <td colspan="2">
        <asp:GridView ID="lstAgentOrders" runat="server" SkinID="DataTable" Width="100%"  CellPadding="2"
        AutoGenerateColumns="False" DataSourceID="AgentOrderDataset" ShowFooter="True" 
        OnRowDataBound="lstAgentOrders_RowDataBound" GridLines="Horizontal" >
        <Columns>
            <asp:TemplateField HeaderText="ID#" SortExpression="orderID">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                <ItemTemplate>
                    <asp:Label ID="Label1" CssClass="head02" runat="server" Text='<%# Bind("orderID") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lbInv" runat="server" Text='<%# Eval("agentInv") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tour Name">
                <HeaderStyle Width="244px" HorizontalAlign="Left" />
                <ItemTemplate>
                    <asp:Label ID="lbTourName" runat="server" Text='<%# Eval("tourName") %>' /><br />
                    <asp:Label ID="lbTourName_cn" runat="server" Text='<%# Eval("tourName_cn") %>' /> 
                    <asp:Label ID="lbSubTitle" runat="server" Text='<%# Eval("subTitle") %>' />
                    <br />
                    Departure:<asp:Label ID="lbStartDate" runat="server" Text='<%# Eval("startDate","{0:d}") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    Total:
                </FooterTemplate>
                <FooterStyle CssClass="head01" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Customer" SortExpression="username">
                <HeaderStyle Width="130px" HorizontalAlign="Left" />
                <ItemTemplate>
                    <asp:Label ID="lbCustomerName" runat="server" Text='<%# Eval("username") %>' />
                    <br />
                    <asp:Literal ID="lbNumAdult" runat="server" Text='<%# Eval("numberAdult") %>' /> Adult 
                    <asp:Literal ID="lbNumChild" runat="server" Text='<%# Eval("numberChild") %>' /> Child
                    <asp:Literal ID="lbNumFree" runat="server" Text='<%# Eval("numberFree") %>' /> Free
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotAdult" runat="server"  /> Adult 
                    <asp:Label ID="lbTotChild" runat="server" /> Child
                    <asp:Label ID="lbTotFree" runat="server" /> Free
                </FooterTemplate>
                
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Amount">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle Width="75px" HorizontalAlign="Right" Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="lbFare" runat="server" Text='<%# Eval("actualAmount") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotFare" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Commission">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle Width="85px" HorizontalAlign="Right" Wrap="False" CssClass="compacText" />
                <ItemTemplate>
                    <asp:Label ID="lbCommission" runat="server" Text='<%# Eval("agentCmt") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotCommission" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Net Total" SortExpression="agentReceivable">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle Width="80px" HorizontalAlign="Right" Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="lbAgentReceivable" runat="server" Text='<%# Eval("agentCredit") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotAgentReceivable" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        </td>
    </tr>
    <tr>
        <td colspan="2"><p align="left" class="head02">Make all checks payable to O'Mei Travel (USA),Inc.<br />
        Thank you for your business!</p></td>
    </tr>
</table>
<br />
<asp:ObjectDataSource ID="AgentOrderDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetAgentRecvInvoiceOrders" TypeName="com.Omei.BLL.Admin.AgentOrderBiz">
    <SelectParameters>
        <asp:QueryStringParameter Name="recvID" QueryStringField="recv" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
</asp:Content>

