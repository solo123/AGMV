<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="FlightEdit" Title="Untitled Page" Codebehind="FlightEdit.aspx.cs" %>

<%@ Register Assembly="Infragistics2.WebUI.WebCombo.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<%@ Register Src="../Controls/TypeSelectorCtl.ascx" TagName="TypeSelectorCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:FormView ID="fvFlight" runat="server" DataKeyNames="flightId" DataSourceID="FlightDataset" Width="100%" OnItemDeleted="fvFlight_ItemDeleted" OnItemInserted="fvFlight_ItemInserted" OnItemCreated="fvFlight_ItemCreated">
        <EditItemTemplate>
        <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update">
            </asp:LinkButton></li><li><asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li></ul><div style="clear:both"></div>
            </div>
            <table width="100%">
                <tr>
                    <td width="150">
                        ID:</td>
                    <td>
            <asp:Label ID="flightIdLabel1" runat="server" Text='<%# Eval("flightId") %>'></asp:Label>
                        </td>
                </tr>
                <tr>
                    <td>
                        From:</td>
                    <td><igcmbo:webcombo id="seleAirportFrom" runat="server" backcolor="White" bordercolor="Silver"
                            borderstyle="Solid" borderwidth="1px" datasourceid="AirportDataset" datavaluefield="airportCode" DataTextField="airportCode"
                            forecolor="Black" selbackcolor="DarkBlue" selforecolor="White" version="4.00" ComboTypeAhead="Suggest" Editable="True" 
                            EnableXmlHTTP="True" Width="140px" DisplayValue=''  >
                        <Columns>
                            <igtbl:UltraGridColumn BaseColumnName="airportCode" Key="airportCode" AllowResize="Free">
                                <header title="Code" caption="Code"></header>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn BaseColumnName="name" Key="name" AllowResize="Free">
                                <header title="Airport Name" caption="Airport">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                            </igtbl:UltraGridColumn>
                        </Columns>
                        <ExpandEffects ShadowColor="LightGray" />
                        <DropDownLayout RowHeightDefault="20px" Version="4.00" BaseTableName="" AllowColSizing="Free" AllowRowSizing="Free" DropdownHeight="225px" DropdownWidth="300px" RowSelectors="No" RowSizing="Free" 
                            SortCaseSensitiveDefault="False" 
                            AutoGenerateColumns="False">
                            <FrameStyle Cursor="Default" BackColor="Silver" BorderWidth="2px" BorderStyle="Ridge" Font-Names="Verdana" Font-Size="10pt" Height="225px" Width="300px">
                            </FrameStyle>
                            <HeaderStyle BackColor="LightGray" BorderStyle="Solid" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Middle">
                                <Padding Left="3px" Right="3px" />
                                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                            </HeaderStyle>
                            <RowAlternateStyle BackColor="#E9E9F7">
                            </RowAlternateStyle>
                            <RowStyle BackColor="White" BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid" Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Left">
                                <Padding Left="5px" Right="5px" />
                                <BorderDetails WidthLeft="0px" WidthTop="0px" />
                            </RowStyle>
                            <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
                        </DropDownLayout>
                    </igcmbo:WebCombo>
                        </td>
                </tr>
                <tr>
                    <td>
                        To:</td>
                    <td ><igcmbo:webcombo id="seleAirportTo" runat="server" backcolor="White" bordercolor="Silver"
                            borderstyle="Solid" borderwidth="1px" datasourceid="AirportDataset" datavaluefield="airportCode" DataTextField="airportCode"
                            forecolor="Black" selbackcolor="DarkBlue" selforecolor="White" version="4.00" ComboTypeAhead="Suggest" Editable="True" 
                            EnableXmlHTTP="True" Width="140px" DisplayValue=''  >
                        <Columns>
                            <igtbl:UltraGridColumn BaseColumnName="airportCode" Key="airportCode" AllowResize="Free">
                                <header title="Code" caption="Code"></header>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn BaseColumnName="name" Key="name" AllowResize="Free">
                                <header title="Airport Name" caption="Airport">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                            </igtbl:UltraGridColumn>
                        </Columns>
                        <ExpandEffects ShadowColor="LightGray" />
                        <DropDownLayout RowHeightDefault="20px" Version="4.00" BaseTableName="" AllowColSizing="Free" AllowRowSizing="Free" DropdownHeight="225px" DropdownWidth="300px" RowSelectors="No" RowSizing="Free" 
                            SortCaseSensitiveDefault="False" 
                            AutoGenerateColumns="False">
                            <FrameStyle Cursor="Default" BackColor="Silver" BorderWidth="2px" BorderStyle="Ridge" Font-Names="Verdana" Font-Size="10pt" Height="225px" Width="300px">
                            </FrameStyle>
                            <HeaderStyle BackColor="LightGray" BorderStyle="Solid" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Middle">
                                <Padding Left="3px" Right="3px" />
                                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                            </HeaderStyle>
                            <RowAlternateStyle BackColor="#E9E9F7">
                            </RowAlternateStyle>
                            <RowStyle BackColor="White" BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid" Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Left">
                                <Padding Left="5px" Right="5px" />
                                <BorderDetails WidthLeft="0px" WidthTop="0px" />
                            </RowStyle>
                            <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
                        </DropDownLayout>
                    </igcmbo:WebCombo>
            </td>
                </tr>
                <tr>
                    <td>
                        Airline:</td>
                    <td><igcmbo:webcombo id="seleAirline" runat="server" backcolor="White" bordercolor="Silver"
                            borderstyle="Solid" borderwidth="1px" datasourceid="AirlineDataset" datavaluefield="airlineCode" DataTextField="airlineCode"
                            forecolor="Black" selbackcolor="DarkBlue" selforecolor="White" version="4.00" ComboTypeAhead="Suggest" Editable="True" 
                            EnableXmlHTTP="True" Width="140px" DisplayValue=''  >
                        <Columns>
                            <igtbl:UltraGridColumn BaseColumnName="airlineCode" Key="airlineCode" AllowResize="Free">
                                <header title="Code" caption="Code"></header>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn BaseColumnName="name" Key="name" AllowResize="Free">
                                <header title="Airline" caption="Airline">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                            </igtbl:UltraGridColumn>
                        </Columns>
                        <ExpandEffects ShadowColor="LightGray" />
                        <DropDownLayout RowHeightDefault="20px" Version="4.00" BaseTableName="" AllowColSizing="Free" AllowRowSizing="Free" DropdownHeight="225px" DropdownWidth="300px" RowSelectors="No" RowSizing="Free" 
                            SortCaseSensitiveDefault="False" 
                            AutoGenerateColumns="False">
                            <FrameStyle Cursor="Default" BackColor="Silver" BorderWidth="2px" BorderStyle="Ridge" Font-Names="Verdana" Font-Size="10pt" Height="225px" Width="300px">
                            </FrameStyle>
                            <HeaderStyle BackColor="LightGray" BorderStyle="Solid" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Middle">
                                <Padding Left="3px" Right="3px" />
                                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                            </HeaderStyle>
                            <RowAlternateStyle BackColor="#E9E9F7">
                            </RowAlternateStyle>
                            <RowStyle BackColor="White" BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid" Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Left">
                                <Padding Left="5px" Right="5px" />
                                <BorderDetails WidthLeft="0px" WidthTop="0px" />
                            </RowStyle>
                            <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
                        </DropDownLayout>
                    </igcmbo:WebCombo>
            </td>
            
                </tr>
                <tr>
                    <td>
                        Flight#</td>
                    <td>
            <asp:TextBox ID="flightTextBox" runat="server" Text='<%# Bind("flight") %>'>
            </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="flightTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td>
                        Round trip:</td>
                    <td>
            <asp:CheckBox ID="roundTripCheckBox" runat="server" Checked='<%# Bind("roundTrip") %>' /></td>
                </tr>
                <tr>
                    <td>
                        non stop:</td>
                    <td>
            <asp:CheckBox ID="nonStopCheckBox" runat="server" Checked='<%# Bind("nonStop") %>' /></td>
                </tr>
                <tr>
                    <td>
                        Price adult:</td>
                    <td>
            <asp:TextBox ID="priceAdultTextBox" runat="server" Text='<%# Bind("priceAdult") %>'>
            </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="priceAdultTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Invalid price!" ControlToValidate="priceAdultTextBox" Display="Dynamic" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
                        
                        </td>
                </tr>
                <tr>
                    <td>
                        Price child:</td>
                    <td>
            <asp:TextBox ID="priceChildTextBox" runat="server" Text='<%# Bind("priceChild") %>'>
            </asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="priceChildTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Invalid price!" ControlToValidate="priceChildTextBox" Display="Dynamic" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
            </td>
                </tr>
                <tr>
                    <td>
                        Status:</td>
                    <td>
                        <uc1:TypeSelectorCtl ID="TypeSelectorCtl1" TypeName="FlightStatus" SelectedValue='<%# Bind("status") %>' runat="server" />
            </td>
                </tr>
                <tr>
                    <td>
                        Notes:</td>
                    <td>
            <asp:TextBox ID="notesTextBox" runat="server" Text='<%# Bind("notes") %>' Rows="4" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
            </table>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update">
            </asp:LinkButton></li><li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li></ul><div style="clear:both"></div>
            </div>
        </EditItemTemplate>
        <InsertItemTemplate>
        <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton></li>
                    <li><a href="FlightsList.aspx">Cancel</a>
                    </li>
                </ul><div style="clear:both"></div>
            </div>
            <table width="100%">
                <tr>
                    <td width="150">
                        From:</td>
                    <td>
            <asp:TextBox ID="airportFromTextBox" runat="server" Text='<%# Bind("airportFrom") %>'>
            </asp:TextBox><input type="button" onclick="openWindow('AirportCode.aspx',600, 500, 'Airport Code', 'yes')" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="airportFromTextBox"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="airportFromTextBox"
                        Display="Dynamic" ErrorMessage="Invalid airport code!" OnServerValidate="AirportCode_ServerValidate"
                        SetFocusOnError="True"></asp:CustomValidator></td>
                </tr>
                <tr>
                    <td>
                        To:</td>
                    <td>
            <asp:TextBox ID="airportToTextBox" runat="server" Text='<%# Bind("airportTo") %>'>
            </asp:TextBox><input type="button" onclick="openWindow('AirportCode.aspx',600, 500, 'Airport Code', 'yes')" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="airportToTextBox"
                            Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="airportToTextBox"
                            Display="Dynamic" ErrorMessage="Invalid airport code!" OnServerValidate="AirportCode_ServerValidate"
                            SetFocusOnError="True"></asp:CustomValidator></td>
                </tr>
                <tr>
                    <td>
                        Airline:</td>
                    <td>
            <asp:TextBox ID="airlineTextBox" runat="server" Text='<%# Bind("airline") %>'>
            </asp:TextBox><input type="button" onclick="openWindow('AirlineCode.aspx',600, 500, 'Airline Code', 'yes')" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="airlineTextBox"
                            Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="airlineTextBox"
                            Display="Dynamic" ErrorMessage="Invalid airport code!" OnServerValidate="AirlineCode_ServerValidate"
                            SetFocusOnError="True"></asp:CustomValidator>
            </td>
                </tr>
                <tr>
                    <td>
                        Flight#</td>
                    <td>
            <asp:TextBox ID="flightTextBox" runat="server" Text='<%# Bind("flight") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="flightTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
                </tr>
                <tr>
                    <td>
                        Round trip:</td>
                    <td>
            <asp:CheckBox ID="roundTripCheckBox" runat="server" Checked='<%# Bind("roundTrip") %>' /></td>
                </tr>
                <tr>
                    <td>
                        non-stop:</td>
                    <td>
            <asp:CheckBox ID="nonStopCheckBox" runat="server" Checked='<%# Bind("nonStop") %>' /></td>
                </tr>
                <tr>
                    <td>
                        Price adult:</td>
                    <td>
            <asp:TextBox ID="priceAdultTextBox" runat="server" Text='<%# Bind("priceAdult") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="priceAdultTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Invalid price!" ControlToValidate="priceAdultTextBox" Display="Dynamic" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
            </td>
                </tr>
                <tr>
                    <td>
                        Price child:</td>
                    <td>
            <asp:TextBox ID="priceChildTextBox" runat="server" Text='<%# Bind("priceChild") %>'>
            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="priceChildTextBox" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Invalid price!" ControlToValidate="priceChildTextBox" Display="Dynamic" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
            </td>
                </tr>
                <tr>
                    <td>
                        Status:</td>
                    <td><uc1:TypeSelectorCtl ID="TypeSelectorCtl1" TypeName="FlightStatus" SelectedValue='<%# Bind("status") %>' runat="server" /></td>
                </tr>
                <tr>
                    <td>
                        Notes:</td>
                    <td>
            <asp:TextBox ID="notesTextBox" runat="server" Text='<%# Bind("notes") %>' Rows="4" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
                </tr>
            </table>
            <div class="toolbox listButtons">
                <ul>
                    <li><asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton></li>
                    <li><a href="FlightsList.aspx">Cancel</a>
                    </li>
                </ul><div style="clear:both"></div>
            </div>
        </InsertItemTemplate>
        <ItemTemplate>
        <div class="toolbox listButtons">
                <ul>
                    <li><a href="FlightsList.aspx">&lt;&lt;Back</a></li><li><asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                Text="Edit">
            </asp:LinkButton></li><li><asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Delete"
                Text="Delete">
            </asp:LinkButton></li></ul><div style="clear:both"></div>
            </div>
            <table style="width: 100%">
                <tr>
                    <td width="150">
                        ID:</td>
                    <td>
            <asp:Label ID="flightIdLabel" runat="server" Text='<%# Eval("flightId") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        From:</td>
                    <td>
            <asp:Label ID="airportFromLabel" runat="server" Text='<%# Bind("airportFrom") %>'>
            </asp:Label></td>
                </tr>
                <tr>
                    <td>
                        To:</td>
                    <td>
            <asp:Label ID="airportToLabel" runat="server" Text='<%# Bind("airportTo") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Airline:</td>
                    <td>
            <asp:Label ID="airlineLabel" runat="server" Text='<%# Bind("airline") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Flight#</td>
                    <td>
            <asp:Label ID="flightLabel" runat="server" Text='<%# Bind("flight") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Round trip:</td>
                    <td>
            <asp:CheckBox ID="roundTripCheckBox" runat="server" Checked='<%# Bind("roundTrip") %>'
                Enabled="false" /></td>
                </tr>
                <tr>
                    <td>
                        non-stop:</td>
                    <td>
            <asp:CheckBox ID="nonStopCheckBox" runat="server" Checked='<%# Bind("nonStop") %>'
                Enabled="false" /></td>
                </tr>
                <tr>
                    <td>
                        Price adult:</td>
                    <td>
            <asp:Label ID="priceAdultLabel" runat="server" Text='<%# Bind("priceAdult") %>'>
            </asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Price child:</td>
                    <td>
            <asp:Label ID="priceChildLabel" runat="server" Text='<%# Bind("priceChild") %>'>
            </asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Status:</td>
                    <td>
            <asp:Label ID="statusLabel" runat="server" Text='<%# Bind("status") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Notes:</td>
                    <td>
            <asp:Label ID="notesLabel" runat="server" Text='<%# Bind("notes") %>'></asp:Label></td>
                </tr>
            </table>
            <div class="toolbox listButtons">
                <ul>
                    <li><a href="FlightsList.aspx">&lt;&lt;Back</a></li><li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                Text="Edit">
            </asp:LinkButton></li><li><asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                Text="Delete">
            </asp:LinkButton></li></ul><div style="clear:both"></div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    &nbsp;
   
    
    
    
    <asp:ObjectDataSource ID="FlightDataset" runat="server" DeleteMethod="DeleteFlight" InsertMethod="AddFlight"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetFlight" TypeName="com.Omei.BLL.Admin.FlightBiz"
        UpdateMethod="UpdateFlight" OnUpdating="FlightDataset_Updating">
        <DeleteParameters>
            <asp:Parameter Name="Original_flightId" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="original_flightId" Type="Int32" />
            <asp:Parameter Name="airportFrom" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="airportTo" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="airline" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="flight" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="roundTrip" Type="Boolean" />
            <asp:Parameter Name="nonStop" Type="Boolean" />
            <asp:Parameter Name="priceAdult" Type="Decimal" />
            <asp:Parameter Name="priceChild" Type="Decimal" />
            <asp:Parameter Name="notes" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="status" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="flightId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="airportFrom" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="airportTo" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="airline" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="flight" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="roundTrip" Type="Boolean" />
            <asp:Parameter Name="nonStop" Type="Boolean" />
            <asp:Parameter Name="priceAdult" Type="Decimal" />
            <asp:Parameter Name="priceChild" Type="Decimal" />
            <asp:Parameter Name="notes" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="status" Type="Int32" />
        </InsertParameters>
    </asp:ObjectDataSource>


<asp:ObjectDataSource ID="AirportDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="SearchAirport" TypeName="com.Omei.BLL.Admin.AirportBiz">
        <SelectParameters>
            <asp:Parameter Name="airport" Type="String" ConvertEmptyStringToNull="false" DefaultValue="" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="AirlineDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="SearchAirline" TypeName="com.Omei.BLL.Admin.AirlineBiz">
        <SelectParameters>
            <asp:Parameter Name="airline" Type="String" ConvertEmptyStringToNull="false" DefaultValue="" />
        </SelectParameters>
    </asp:ObjectDataSource>


</asp:Content>

