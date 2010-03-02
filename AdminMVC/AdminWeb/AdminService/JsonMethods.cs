using System.Collections.Generic;
using System.Data;
using System.Text;
public static class JsonMethods
{
    private static List<Dictionary<string, object>>
        RowsToDictionary(DataTable table)
    {
        List<Dictionary<string, object>> objs =
            new List<Dictionary<string, object>>();
        foreach (DataRow dr in table.Rows)
        {
            Dictionary<string, object> drow = new Dictionary<string, object>();
            for (int i = 0; i < table.Columns.Count; i++)
            {
                drow.Add(table.Columns[i].ColumnName, dr[i]);
            }
            objs.Add(drow);
        }

        return objs;
    }

    public static Dictionary<string, object> ToJson(DataTable table)
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add(table.TableName, RowsToDictionary(table));
        return d;
    }

    public static Dictionary<string, object> ToJson(DataSet data)
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        foreach (DataTable table in data.Tables)
        {
            d.Add(table.TableName, RowsToDictionary(table));
        }
        return d;
    }

    public static string DsToJson(DataSet ds)
    {
        // {tables: [ {table:tb1, rows: [{field1:value1, field2:value2, field3:value3}, .].. ]}
        StringBuilder sb = new StringBuilder();
        sb.Append("{tables:[");
        foreach (DataTable dt in ds.Tables)
        {
            sb.Append(DtToJson(dt));
            sb.Append(",");
        }
        sb.Remove(sb.Length-1, 1);
        sb.Append("]}");
        return sb.ToString();
    }

    /// <summary>
    /// [{field1:val1,field2:val2...},...]
    /// </summary>
    /// <param name="dt"></param>
    /// <returns></returns>
    public static string DtToJson(DataTable dt)
    {
        if (dt == null) return "";

        StringBuilder sb = new StringBuilder();
        sb.Append("[");
        foreach (DataRow row in dt.Rows)
        {
            sb.Append("{");
            foreach (DataColumn dc in dt.Columns)
            {
                sb.Append(dc.ColumnName);
                sb.Append(": '");
                sb.Append(row[dc]);
                sb.Append("',");
            }
            sb.Remove(sb.Length - 1, 1);
            sb.Append("},");
        }
        sb.Remove(sb.Length - 1, 1);
        sb.Append("]");
        return sb.ToString();
    }

}