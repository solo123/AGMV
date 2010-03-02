using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Collections.Generic;
using com.Omei.BLL.Authenticate;

public partial class Admin_RoleList : AdminList
{
    protected void Page_Load(object sender, EventArgs e)
    {
        base.EditPageUrl = "RoleList.aspx";

        if (!Page.IsPostBack)
        {
            if (Request.QueryString["id"] == null)
                panelEdit.Visible = false;
            else
            {
                panelEdit.Visible = true;
                int roleId = int.Parse(Request.QueryString["id"]);
                ViewState["roleId"] = roleId;

                if (roleId == 0)
                {
                    txtRoleId.Text = "{����}";
                    txtRoleId.ForeColor = System.Drawing.Color.Red;
                    txtRole.Text = "";
                    btnDelete.Visible = false;
                }
                else
                {
                    UserBiz biz = new UserBiz();
                    txtRoleId.Text = roleId.ToString();
                    txtRoleId.ForeColor = System.Drawing.Color.DarkBlue;
                    txtRole.Text = biz.GetRoleNameById(roleId);
                    btnDelete.Visible = true;
                }
            }
        }
    }
    
    private void ToolsCommandHandler(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        switch (btn.CommandName)
        {
            case "Add":
                Server.Transfer("UserEdit.aspx?id=-1");
                break;
        }
    }
    protected void lstRoles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        base.RowOnMouseOverEvent(e.Row, "roleId");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if ((int)ViewState["roleId"] == 0)
        {
            OmeiRole biz = new OmeiRole();
            biz.AddRole(txtRole.Text);
        }
        else
        {
            UserBiz biz = new UserBiz();
            biz.UpdateRoleName((int)ViewState["roleId"], txtRole.Text);
        }

    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if ((int)ViewState["roleId"] <= 0) return;

        OmeiRole biz = new OmeiRole();
        UserBiz ubiz = new UserBiz();
        string roleName = ubiz.GetRoleNameById((int)ViewState["roleId"]);
        int roleMem = biz.GetUsersInRole(roleName).Length;
        if (roleMem > 0)
        {
            txtMessage.Text = string.Format("��ɫ[{0}]��߀��{1}���Ñ������܄h����", roleName, roleMem);
            txtMessage.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            biz.DeleteRole(roleName);
            txtMessage.Text = string.Format("��ɫ[{0}]�фh����",roleName);
            txtMessage.ForeColor = System.Drawing.Color.DarkGreen;
        }

    }
}
