﻿<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ChangePasswordPage" Title="Untitled Page" Codebehind="ChangePassword.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <div>
        <table class="detail_view" width="500">
            <tr>
                <td colspan=2><h1>
                    修改我的密码</h1></td>
            </tr>
            <tr>
                <td align="right" nowrap="noWrap">
                    输入原密码:</td>
                <td align="left">
                    <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" MaxLength="15"></asp:TextBox></td>
            </tr>
            <tr>
                <td align=right>输入新密码:</td>
                <td align=left>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td><asp:TextBox ID="txtPassword" runat="server" ValidationGroup="GrpChangePassword" TextMode="Password" MaxLength="15"></asp:TextBox>
                        
                        </td>
                        <td>&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword"
                        Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"
                        ValidationGroup="GrpChangePassword"></asp:RequiredFieldValidator></td>
                        <td><TABLE cellSpacing=0 cellPadding=0 border=0>
                    <TBODY>
                    <TR>
                      <TD vAlign=top noWrap width=0><FONT 
                        face="Arial, sans-serif" size=-1><A 
                        href="javascript:var popup=window.open('PasswordHelp.html', 'PasswordHelp', 'width=600,height=600,location=no,menubar=no,status=no,toolbar=no,scrollbars=yes,resizable=yes');">密码强度：</A> 
                        </FONT></TD>
                      <TD vAlign=top noWrap><FONT face="Arial, sans-serif" 
                        color=#808080 size=-1><B>
                        <DIV id=passwdRating></DIV></B></FONT></TD></TR>
                    <TR>
                      <TD height=3></TD></TR>
                    <TR>
                      <TD colSpan=2 id="passwdBarDiv" width="180">
                        <TABLE id=passwdBar cellSpacing=0 cellPadding=0 
                        width=180 bgColor=#ffffff border=0>
                          <TBODY>
                          <TR>
                            <TD id=posBar width=0% bgColor=#e0e0e0 
height=4></TD>
                            <TD id=negBar bgColor=white
                            height=4></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
                        </td>
                    </tr>
                </table>
                
                
                
                
                
                
                
                    </td>
            </tr>
            <tr>
                <td align=right nowrap="noWrap">再次输入密码:</td>
                <td align=left><asp:TextBox ID="txtPassword1" runat="server" ValidationGroup="GrpChangePassword" TextMode="Password" MaxLength="15"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPassword1"
                        Display="Dynamic" ErrorMessage="* Please input new password again" SetFocusOnError="True"
                        ValidationGroup="GrpChangePassword"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword"
                        ControlToValidate="txtPassword1" Display="Dynamic" ErrorMessage="Two password not same."
                        SetFocusOnError="True" ValidationGroup="GrpChangePassword"></asp:CompareValidator></td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td align="left">
                    <asp:Button ID="btnChangePwd" runat="server" Text="Change password" OnClick="btnChangePwd_Click" ValidationGroup="GrpChangePassword" />
                    <asp:Label ID="lbPwdMsg" runat="server" ForeColor="Red"></asp:Label></td>
            </tr>
        </table>
    </div>

<script type="text/javascript" src="Images/PasswordStrength.js" />
</asp:Content>

