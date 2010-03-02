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

public partial class Destinations : System.Web.UI.Page
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

    #region 鼠標單擊行選中
    protected void lstDestinations_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //行选择
        GridViewRow row = e.Row;
        if (row != null && row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('DestinationEdit.aspx?id=" + DataBinder.Eval(row.DataItem, "destinationId") + "')");
        }
    }
    #endregion

}
