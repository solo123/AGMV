<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="OrderPrice" Title="Untitled Page" Codebehind="OrderPrice.aspx.cs" %>

<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            
        </ul>
    <div style="clear:both"></div></div>

    


    <asp:FormView ID="fvOrderPrice" runat="server" DataKeyNames="orderId" DataSourceID="OrderPriceDataset">
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>            
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update" />
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="Cancel" />
                    </li>
                </ul>
            <div style="clear:both"></div></div>
            <table cellpadding="6" cellspacing="0" border=0 width="100%">
                <tr>
                    <td bgcolor="darkgreen" nowrap="nowrap" style="color: white" align="center">
                        Ó††ÎÌ–:<br />
                        <asp:Label ID="lbOrderId" runat="server" Font-Bold="True" Text='<%# Eval("orderId") %>' Font-Size="14pt" ></asp:Label></td>
                    <td width="100%">
                        <uc1:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" ScheduleId='<%# Eval("scheduleId") %>' />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="darkgreen" colspan="2" height="1">
                    </td>
                </tr>
            </table>
            
            <table cellpadding="6" cellspacing="0" border="0" width="100%">
                <tr>
                    <td>Price Adult:</td>
                    <td><asp:TextBox ID="priceAdultTextBox" runat="server" Text='<%# Bind("priceAdult") %>' /></td>
                </tr>
                <tr>
                    <td>Price Child:</td>
                    <td><asp:TextBox ID="priceChildTextBox" runat="server" Text='<%# Bind("priceChild") %>' /></td>
                </tr>
            </table>
        </EditItemTemplate>
        <ItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>            
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                            Text="Edit" />
                    </li>
                </ul>
            <div style="clear:both"></div></div>
            <table cellpadding="6" cellspacing="0" border=0 width="100%">
                <tr>
                    <td bgcolor="darkgreen" nowrap="nowrap" style="color: white" align="center">
                        Ó††ÎÌ–:<br />
                        <asp:Label ID="lbOrderId" runat="server" Font-Bold="True" Text='<%# Eval("orderId") %>' Font-Size="14pt" ></asp:Label></td>
                    <td width="100%">
                        <uc1:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" ScheduleId='<%# Eval("scheduleId") %>' />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="darkgreen" colspan="2" height="1">
                    </td>
                </tr>
            </table>
            
            <table cellpadding="6" cellspacing="0" border="0" width="100%">
                <tr>
                    <td>Price Adult:</td>
                    <td><asp:Label ID="priceAdultLabel" runat="server" Text='<%# Bind("priceAdult") %>' /></td>
                </tr>
                <tr>
                    <td>Price Child:</td>
                    <td><asp:Label ID="priceChildLabel" runat="server" Text='<%# Bind("priceChild") %>' /></td>
                </tr>
            </table>
        </ItemTemplate>
    
    
    </asp:FormView>
    <asp:ObjectDataSource ID="OrderPriceDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetOrderPrice" TypeName="com.Omei.BLL.Admin.AdminOrderBiz" UpdateMethod="UpdateOrderPrice">
        <UpdateParameters>
            <asp:Parameter Name="original_orderID" Type="Int32" />
            <asp:Parameter Name="priceAdult" Type="Decimal" />
            <asp:Parameter Name="priceChild" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="orderID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

