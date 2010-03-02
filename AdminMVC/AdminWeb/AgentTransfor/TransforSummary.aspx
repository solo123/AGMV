<%@ Page Language="C#" MasterPageFile="../public/AdminContent.master" AutoEventWireup="true" CodeBehind="TransforSummary.aspx.cs" 
Inherits="AdminWeb.AgentTransfor.TransforSummary" Title="O'mei - Agent Invoice Match" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>Please select an agent:</h2>

    <asp:GridView ID="lstTransforSum" runat="server" AutoGenerateColumns="False" 
        DataSourceID="TransforSumDataset" SkinID="NormalDataList">
        <Columns>
            <asp:BoundField DataField="agentID" HeaderText="Agent#">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="companyName" HeaderText="Agent" />
            <asp:BoundField DataField="cnt" HeaderText="Count">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="amount" DataFormatString="{0:N2}" HeaderText="Balance">
                <ItemStyle HorizontalAlign="Right" Width="120px" />
            </asp:BoundField>
            <asp:BoundField DataField="discount" DataFormatString="{0:N}%" HeaderText="Discount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="maxcredit" DataFormatString="{0:N2}" HeaderText="Max Credit">
                <ItemStyle HorizontalAlign="Right" Width="120px" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="TransforSumDataset" runat="server" 
        OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetAgentTransforSum" TypeName="com.Omei.BLL.Admin.IMMatchBiz">
    </asp:ObjectDataSource>



</asp:Content>
