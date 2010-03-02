<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="CreditDetail" Title="Untitled Page" Codebehind="CreditDetail.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="toolbox listButtons">
    <ul>
        <li><asp:Button ID="btnBack" runat="server" Text="<< 返囬" Visible="False" OnClick="btnBack_Click" /></li>
        <li><asp:Label ID="txtToolMessage" runat="server" ForeColor="Red"></asp:Label></li>
    </ul><div style="clear:both"></div>
</div>    
    
    
    <asp:SqlDataSource ID="SqlCreditDataset" runat="server" ConnectionString="<%$ ConnectionStrings:Connection String %>" SelectCommand="SELECT * FROM [CreditCard] WHERE ([orderId] = @orderId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="orderId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="fvCredit" runat="server" DataSourceID="SqlCreditDataset" DataKeyNames="crId">
        <EditItemTemplate>
            crId:
            <asp:Label ID="crIdLabel1" runat="server" Text='<%# Eval("crId") %>'></asp:Label><br />
            orderId:
            <asp:TextBox ID="orderIdTextBox" runat="server" Text='<%# Bind("orderId") %>'>
            </asp:TextBox><br />
            firstName:
            <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'>
            </asp:TextBox><br />
            lastName:
            <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'>
            </asp:TextBox><br />
            cardType:
            <asp:TextBox ID="cardTypeTextBox" runat="server" Text='<%# Bind("cardType") %>'>
            </asp:TextBox><br />
            cardNumber:
            <asp:TextBox ID="cardNumberTextBox" runat="server" Text='<%# Bind("cardNumber") %>'>
            </asp:TextBox><br />
            validDate:
            <asp:TextBox ID="validDateTextBox" runat="server" Text='<%# Bind("validDate") %>'>
            </asp:TextBox><br />
            csc:
            <asp:TextBox ID="cscTextBox" runat="server" Text='<%# Bind("csc") %>'>
            </asp:TextBox><br />
            address:
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>'>
            </asp:TextBox><br />
            city:
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>'>
            </asp:TextBox><br />
            state:
            <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>'>
            </asp:TextBox><br />
            zip:
            <asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>'>
            </asp:TextBox><br />
            country:
            <asp:TextBox ID="countryTextBox" runat="server" Text='<%# Bind("country") %>'>
            </asp:TextBox><br />
            status:
            <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>'>
            </asp:TextBox><br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update">
            </asp:LinkButton>
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
        </EditItemTemplate>
        <InsertItemTemplate>
            orderId:
            <asp:TextBox ID="orderIdTextBox" runat="server" Text='<%# Bind("orderId") %>'>
            </asp:TextBox><br />
            firstName:
            <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'>
            </asp:TextBox><br />
            lastName:
            <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'>
            </asp:TextBox><br />
            cardType:
            <asp:TextBox ID="cardTypeTextBox" runat="server" Text='<%# Bind("cardType") %>'>
            </asp:TextBox><br />
            cardNumber:
            <asp:TextBox ID="cardNumberTextBox" runat="server" Text='<%# Bind("cardNumber") %>'>
            </asp:TextBox><br />
            validDate:
            <asp:TextBox ID="validDateTextBox" runat="server" Text='<%# Bind("validDate") %>'>
            </asp:TextBox><br />
            csc:
            <asp:TextBox ID="cscTextBox" runat="server" Text='<%# Bind("csc") %>'>
            </asp:TextBox><br />
            address:
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>'>
            </asp:TextBox><br />
            city:
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>'>
            </asp:TextBox><br />
            state:
            <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>'>
            </asp:TextBox><br />
            zip:
            <asp:TextBox ID="zipTextBox" runat="server" Text='<%# Bind("zip") %>'>
            </asp:TextBox><br />
            country:
            <asp:TextBox ID="countryTextBox" runat="server" Text='<%# Bind("country") %>'>
            </asp:TextBox><br />
            status:
            <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>'>
            </asp:TextBox><br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton>
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
        </InsertItemTemplate>
        <ItemTemplate>
            crId:
            <asp:Label ID="crIdLabel" runat="server" Text='<%# Eval("crId") %>'></asp:Label><br />
            orderId:
            <asp:Label ID="orderIdLabel" runat="server" Text='<%# Bind("orderId") %>'></asp:Label><br />
            firstName:
            <asp:Label ID="firstNameLabel" runat="server" Text='<%# Bind("firstName") %>'></asp:Label><br />
            lastName:
            <asp:Label ID="lastNameLabel" runat="server" Text='<%# Bind("lastName") %>'></asp:Label><br />
            cardType:
            <asp:Label ID="cardTypeLabel" runat="server" Text='<%# Bind("cardType") %>'></asp:Label><br />
            cardNumber:
            <asp:Label ID="cardNumberLabel" runat="server" Text='<%# Bind("cardNumber") %>'>
            </asp:Label><br />
            validDate:
            <asp:Label ID="validDateLabel" runat="server" Text='<%# Bind("validDate") %>'></asp:Label><br />
            csc:
            <asp:Label ID="cscLabel" runat="server" Text='<%# Bind("csc") %>'></asp:Label><br />
            address:
            <asp:Label ID="addressLabel" runat="server" Text='<%# Bind("address") %>'></asp:Label><br />
            city:
            <asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>'></asp:Label><br />
            state:
            <asp:Label ID="stateLabel" runat="server" Text='<%# Bind("state") %>'></asp:Label><br />
            zip:
            <asp:Label ID="zipLabel" runat="server" Text='<%# Bind("zip") %>'></asp:Label><br />
            country:
            <asp:Label ID="countryLabel" runat="server" Text='<%# Bind("country") %>'></asp:Label><br />
            status:
            <asp:Label ID="statusLabel" runat="server" Text='<%# Bind("status") %>'></asp:Label><br />
        </ItemTemplate>
    </asp:FormView>
</asp:Content>

