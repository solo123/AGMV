<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_UploadPicCtl" Codebehind="UploadPicCtl.ascx.cs" %>

<table width="100%">

        <!-- photo here -->
        <tr>
            <td>
                
             </td>
        </tr>
        <tr><td><hr /></td></tr>
        <tr>
            <td valign="top">
                <table width="100%">
                    <tr>
                        <td valign="top" width="5%" nowrap>
                            <asp:Panel ID="pnThumbSize" Visible="false" runat="server">
                                <asp:Literal ID="lbThumbWidth" runat="server"></asp:Literal>
                                x
                                <asp:Literal ID="lbThumbHeight" runat="server"></asp:Literal>
                                <br />
                                <asp:Image ID="imgThumbnail" runat="server" BorderColor="Black" BorderStyle="Solid"
                                    BorderWidth="1px" />
                            </asp:Panel>
                        </td>
                        <td valign="top" width="95%" nowrap>
                            <asp:Literal ID="lbPhotoWidth" runat="server"></asp:Literal>
                            x
                            <asp:Literal ID="lbPhotoHeight" runat="server"></asp:Literal>
                            <br />
                            <asp:Image ID="imgPhoto" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" /><br />
                            
                            <asp:FileUpload ID="picUpload" runat="server" />
                            <asp:Button ID="btnUpload" runat="server" Text="Upload Photo" OnClick="btnUpload_Click" />
                            (<asp:Label ID="lbPhotoSaveToName" runat="server" Text="" />)
                            <asp:Label ID="txtUploadMessage" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
                </td>
        </tr>
        <!-- End photo -->
    </table>