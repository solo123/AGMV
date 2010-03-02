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

public partial class DestinationIcon : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region Sort Image
    protected void lstDestinations_RowCreated(object sender, GridViewRowEventArgs e)
    {

        // Use the RowType property to determine whether the 
        // row being created is the header row. 
        if (e.Row.RowType == DataControlRowType.Header)
        {
            // Call the GetSortColumnIndex helper method to determine
            // the index of the column being sorted.
            int sortColumnIndex = GetSortColumnIndex();

            if (sortColumnIndex != -1)
            {
                // Call the AddSortImage helper method to add
                // a sort direction image to the appropriate
                // column header. 
                AddSortImage(sortColumnIndex, e.Row);
            }
        }
    }

    // This is a helper method used to determine the index of the
    // column being sorted. If no column is being sorted, -1 is returned.
    private int GetSortColumnIndex()
    {

        // Iterate through the Columns collection to determine the index
        // of the column being sorted.
        foreach (DataControlField field in lstDestinations.Columns)
        {
            if (field.SortExpression == lstDestinations.SortExpression)
            {
                return lstDestinations.Columns.IndexOf(field);
            }
        }

        return -1;
    }

    // This is a helper method used to add a sort direction
    // image to the header of the column being sorted.
    private void AddSortImage(int columnIndex, GridViewRow headerRow)
    {

        // Create the sorting image based on the sort direction.
        Image sortImage = new Image();
        if (lstDestinations.SortDirection == SortDirection.Ascending)
        {
            sortImage.ImageUrl = "~/Images/res/sortAscending.gif";
            sortImage.AlternateText = "Ascending Order";
        }
        else
        {
            sortImage.ImageUrl = "~/Images/res/sortDescending.gif";
            sortImage.AlternateText = "Descending Order";
        }

        // Add the image to the appropriate header cell.
        headerRow.Cells[columnIndex].Controls.Add(sortImage);

    }

    #endregion

    protected void lstDestinations_DataBound(object sender, EventArgs e)
    {
        int i = lstDestinations.EditIndex;
        if (i >= 0)
        {
            string id = lstDestinations.Rows[i].FindControl("TextBox1").ClientID;
            lbScript.Text = "<script language=javascript>function SetVal(val){ document.all." + id + ".value=val; }</script>";
        }
    }
}
