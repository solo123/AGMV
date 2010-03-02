<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="DestinationIcon" Title="Untitled Page" Codebehind="DestinationIcon.aspx.cs" %>
<%@ Register Src="../Controls/PicSelectorCtl.ascx" TagName="PicSelectorCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ObjectDataSource ID="DestinationDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDestinationList" TypeName="com.Omei.DLL.DS_DestinationsTableAdapters.DestListTableAdapter" UpdateMethod="Update">
        <UpdateParameters>
            <asp:Parameter Name="titlePic" Type="Int32" />
            <asp:Parameter Name="Original_DestinationID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>



    <asp:Literal ID="lbScript" runat="server"></asp:Literal>
    
    <asp:GridView ID="lstDestinations" runat="server" AllowPaging="True" AllowSorting="True" 
        AutoGenerateColumns="False" DataKeyNames="DestinationID" 
        DataSourceID="DestinationDataset" 
        SkinID="DataList" Width="100%" 
        OnRowCreated="lstDestinations_RowCreated" 
        OnDataBound="lstDestinations_DataBound"          
        >
        <Columns>
            <asp:TemplateField HeaderText="Edit" ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                        Text="Update"></asp:LinkButton><br /><br />
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancel"></asp:LinkButton>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                        Text="Edit"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DestinationID" HeaderText="ID" InsertVisible="False"
                ReadOnly="True" SortExpression="DestinationID" />
            <asp:TemplateField HeaderText="aa">
                <EditItemTemplate>
                    <asp:Image ID="Image1" Height=75px Width=100px ImageUrl='<%# Eval("titlePic", "~/OmeiWeb/images/upload/destinationPics/DestTn_{0}.jpg") %>' runat="server" />
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("titlePic") %>' Width=45px></asp:TextBox>
                    <br />
                    <uc1:PicSelectorCtl ID="PicSelectorCtl1" DestinationId='<%# Eval("DestinationId") %>' runat="server" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" ImageUrl='<%# Eval("titlePic", "~/OmeiWeb/images/upload/destinationPics/DestTn_{0}.jpg") %>' Height=30px Width=40px runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DestinationName" HeaderText="Name" SortExpression="DestinationName" ReadOnly="True" />
            <asp:BoundField DataField="DestinationName_cn" HeaderText="Name_cn" SortExpression="DestinationName_cn" ReadOnly="True" />
            <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" ReadOnly="True" />
            <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" ReadOnly="True" />
            <asp:BoundField DataField="country" HeaderText="Country" SortExpression="country" ReadOnly="True" />
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" ReadOnly="True" >
                <ItemStyle Width="40px" />
            </asp:BoundField>
            
        </Columns>
    </asp:GridView>
    
    
</asp:Content>

