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

using com.Omei.BLL.Admin;
using com.Omei.OmeiAdminData;
using com.Omei.OmeiDataSet;

public partial class Controls_NotesCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    #region  Ù–‘: Refid, NNotesType
    public int Refid
    {
        get
        {
            if (ViewState["Notes_refid"] == null)
                return 0;
            else 
                return (int)ViewState["Notes_refid"];
        }
        set
        {
            ViewState["Notes_refid"] = value;
            txtRefId.Text = "("+ value.ToString() +")";
            lstNotes.DataBind();
        }
    }

    public NotesType NNotesType
    {
        get
        {
            if (ViewState["Notes_notestype"] == null)
                return NotesType.N_A;
            else
                return (NotesType)ViewState["Notes_notestype"];
        }
        set { ViewState["Notes_notestype"] = value; }
    }
    #endregion

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        int refid = this.Refid;
        NotesType notesType = this.NNotesType;

        AdminNotesBiz biz = new AdminNotesBiz();
        D_Notes dn = new D_Notes();
        D_LoginUserInfo ei = Session["LoginUserInfo"] as D_LoginUserInfo;

        dn.notesId = -1;
        dn.userId = ei.userId;
        dn.notes = txtNotes.Text;
        dn.refid = refid;
        dn.notesType = notesType;
        dn.status = true;
        biz.UpdateNotes(dn);

        btnShowAdd.Visible = true;
        plAddNotes.Visible = false;
        lstNotes.DataBind();
    }
    protected void lstNotes_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        /*
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType==ListItemType.AlternatingItem)
        {
            DataRowView dv = e.Item.DataItem as DataRowView;
            DS_Notes.NotesTblRow row = dv.Row as DS_Notes.NotesTblRow;
            ((LinkButton)e.Item.FindControl("btnEdit")).Visible = (row.userId == ((D_LoginUserInfo)Session["LoginUserInfo"]).userId);

            if (row.status)
                e.Item.CssClass = "notes";
            else
                e.Item.CssClass = "notes_deleted";

        }
        */
    }
    protected void lstNotes_EditCommand(object source, DataListCommandEventArgs e)
    {
        lstNotes.EditItemIndex = e.Item.ItemIndex;
        lstNotes.DataBind();
    }
    protected void lstNotes_UpdateCommand(object source, DataListCommandEventArgs e)
    {
        int notesId = (int)lstNotes.DataKeys[e.Item.ItemIndex];
        string notes = ((TextBox)e.Item.FindControl("txtMyNotes")).Text;
        int status = 0;
        if (((CheckBox)e.Item.FindControl("chkStatus")).Checked)
            status = 1;
        AdminNotesBiz biz = new AdminNotesBiz();
        biz.UpdateNotes(notesId, ((D_LoginUserInfo)Session["LoginUserInfo"]).userId, notes, status);
        
        lstNotes.EditItemIndex = -1;
        lstNotes.DataBind();
    }
    protected void lstNotes_CancelCommand(object source, DataListCommandEventArgs e)
    {
        lstNotes.EditItemIndex = -1;
        lstNotes.DataBind();
    }
    protected void NotesDataset_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        int refid = this.Refid;
        byte nt = Convert.ToByte(this.NNotesType);

        NotesDataset.SelectParameters["refid"].DefaultValue = refid.ToString();
        NotesDataset.SelectParameters["NotesType"].DefaultValue = nt.ToString();
    }
    protected void chkShowAll_CheckedChanged(object sender, EventArgs e)
    {
        NotesDataset.SelectParameters["status"].DefaultValue = (chkShowAll.Checked ? "0" : "1");

        lstNotes.DataBind();
    }
    protected void btnShowAdd_Click(object sender, EventArgs e)
    {
        btnShowAdd.Visible = false;
        plAddNotes.Visible = true;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        btnShowAdd.Visible = true;
        plAddNotes.Visible = false;
    }
}
