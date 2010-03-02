<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="TourFee" Title="Untitled Page" Codebehind="TourFee.aspx.cs" %>

<%@ Register Src="../Controls/TypeSelectorCtl.ascx" TagName="TypeSelectorCtl" TagPrefix="uc2" %>
<%@ Register Src="../WebParts/TourNameCtl.ascx" TagName="TourNameCtl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:TourNameCtl ID="TourNameCtl1" runat="server" />
    <br />
    
    <asp:GridView ID="lstTourFee" runat="server" AutoGenerateColumns="False" AutoGenerateSelectButton="True" DataSourceID="TourFeeListDataset" OnSelectedIndexChanged="lstTourFee_SelectedIndexChanged" SkinID="DataList" Width="100%" DataKeyNames="tourFeeID">
        <Columns>
            <asp:TemplateField HeaderText="Type" SortExpression="feeType">
                <ItemStyle Width="15%" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourFee", Eval("feeType"), "en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" >
                <ItemStyle Width="70%" />
            </asp:BoundField>
            <asp:BoundField DataField="feeAdult" HeaderText="Adult" />
            <asp:BoundField DataField="feeChild" HeaderText="Child" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="TourFeeListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetTourFeeList" TypeName="com.Omei.DLL.DS_TourFeeTableAdapters.TourFeeTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="tourID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <br />
    <asp:FormView ID="fvTourFee" runat="server" DataSourceID="TourFeeDataset" Width="100%" DataKeyNames="tourFeeID" OnItemInserted="fvTourFee_ItemInserted" OnItemUpdated="fvTourFee_ItemUpdated" OnItemDeleted="fvTourFee_ItemDeleted">
        <EditItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update">
            </asp:LinkButton></li><li>
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
</li>
                </ul>
            <div style="clear:both"></div></div>
            
            <table width="100%">
                <tr>
                    <td width="15%">Type:</td>
                    <td width="85%">
                        <uc2:TypeSelectorCtl ID="TypeSelectorCtl1" TypeName="TourFee" SelectedValue='<%# Bind("feeType") %>' runat="server" />
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">Description:</td>
                    <td><asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td>Adult:</td>
                    <td><asp:TextBox ID="feeTextBox" runat="server" Text='<%# Bind("feeAdult") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="feeTextBox"
                Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="feeTextBox"
                Display="Dynamic" ErrorMessage="invalid input" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Double"></asp:CompareValidator></td>
                </tr>
                <tr>
                    <td>Child:</td>
                    <td><asp:TextBox ID="feeChildTxt" runat="server" Text='<%# Bind("feeChild") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ControlToValidate="feeChildTxt"
                Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="feeChildTxt"
                Display="Dynamic" ErrorMessage="invalid input" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Double"></asp:CompareValidator></td>
                </tr>
            </table>
            
        </EditItemTemplate>
        <InsertItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li>            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton></li><li>
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
</li>
                </ul>
            <div style="clear:both"></div></div>
            <table width="100%">
                <tr>
                    <td>Type:</td>
                    <td>
                        <uc2:TypeSelectorCtl ID="TypeSelectorCtl1" TypeName="TourFee" SelectedValue='<%# Bind("feeType") %>' runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>Description:</td>
                    <td><asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>'>
            </asp:TextBox></td>
                </tr>
                <tr>
                    <td>Adult:</td>
                    <td><asp:TextBox ID="feeTextBox" runat="server" Text='<%# Bind("feeAdult") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="feeTextBox"
                Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="feeTextBox"
                Display="Dynamic" ErrorMessage="invalid input" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Double"></asp:CompareValidator></td>
                </tr>
                <tr>
                    <td>Child:</td>
                    <td><asp:TextBox ID="txtFeeChild" runat="server" Text='<%# Bind("feeChild") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFeeChild"
                Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="txtFeeChild"
                Display="Dynamic" ErrorMessage="invalid input" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Double"></asp:CompareValidator></td>
                </tr>
            </table>

        </InsertItemTemplate>
        <ItemTemplate>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                Text="Edit">
            </asp:LinkButton></li><li><asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                Text="New">
            </asp:LinkButton></li><li><asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                Text="Delete">
            </asp:LinkButton></li></ul>
            <div style="clear:both"></div></div>
            
            <table width="100%">
                <tr>
                    <td width="15%">Type:</td>
                    <td width="85%"><asp:Label ID="feeTypeLabel" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourFee", Eval("feeType"), "en") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td nowrap="noWrap">Description:</td>
                    <td><asp:Label ID="descriptionLabel" runat="server" Text='<%# Bind("description") %>'>
            </asp:Label></td>
                </tr>
                <tr>
                    <td>Adult:</td>
                    <td><asp:Label ID="feeLabel" runat="server" Text='<%# Bind("feeAdult") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>Child:</td>
                    <td><asp:Label ID="Label2" runat="server" Text='<%# Bind("feeChild") %>'></asp:Label></td>
                </tr>
            </table>
            
        </ItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="TourFeeDataset" runat="server" DeleteMethod="DeleteQuery"
        InsertMethod="AddTourFee" OldValuesParameterFormatString="original_{0}" SelectMethod="GetTourFee"
        TypeName="com.Omei.DLL.DS_TourFeeTableAdapters.TourFeeTableAdapter" UpdateMethod="UpdateTourFee">
        <DeleteParameters>
            <asp:Parameter Name="original_tourFeeID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="feeType" Type="Int32" />
            <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="feeAdult" Type="Decimal" />
            <asp:Parameter Name="feeChild" Type="Decimal" />
            <asp:Parameter Name="original_tourFeeID" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:Parameter Name="tourFeeID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="tourID" QueryStringField="id" Type="Int32" />
            <asp:Parameter Name="feeType" Type="Int32" />
            <asp:Parameter Name="description" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="feeAdult" Type="Decimal" />
            <asp:Parameter Name="feeChild" Type="Decimal" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <br />



</asp:Content>

