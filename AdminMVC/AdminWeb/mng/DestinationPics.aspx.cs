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

using System.IO;
using System.Drawing;

using System.Collections.Generic;
using com.Omei.BLL.Admin;
using com.Omei.DLL;

public partial class Admin_DestinationPics : AdminBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int destID = PageTools.ParseInt(Request.QueryString["id"]);
            if (destID > 0)
            {
                AdminDestinationBiz biz = new AdminDestinationBiz();
                DS_Destinations.DestDetailDataTable dt = biz.GetDestinationDetail(destID);
                if (dt != null)
                {
                    lbDestinationName.Text = "(Dest ID:" + destID.ToString() + ") " + 
                        dt.Rows[0]["DestinationName_cn"].ToString() + " / " + 
                        dt.Rows[0]["DestinationName"].ToString();
                }
            }

            btnNew.Enabled = PageLogic.CheckActionAuth("auth_DestinationPicsNew");
            //PageLogic.CheckActionAuth("auth_DestinationPicsUpload") %>'
        }
    }

    protected void lstPics_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (lstPics.SelectedIndex >= 0)
        {
            fvPicDetail.PageIndex = lstPics.SelectedIndex;
            fvPicDetail.ChangeMode(FormViewMode.ReadOnly);
            fvPicDetail.DataBind();
        }
    }

    protected void fvPicDetail_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        lstPics.DataBind();
    }


    protected void btnNew_Click(object sender, EventArgs e)
    {
        fvPicDetail.ChangeMode(FormViewMode.Insert);
    }
}
