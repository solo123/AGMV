using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace com.Omei.OmeiModel
{
    public class DAO
    {
        public string ErrorMessage;
        public int ErrorCode;

        public DAO()
        {
            ErrorCode = 0;
            ErrorMessage = "";
        }
    
        public bool FillDataSet(DataSet ds, string tableName, string sql, SqlParameter[] para)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(sql);

            if ( para!=null) cmd.Parameters.AddRange(para);
            db.LoadDataSet(cmd, ds, tableName);
            return true;
        }
        public bool FillDataSet(DataSet ds, string tableName, string storeProcedure, SqlParameter[] para, bool isStoreProcedure)
        {
            if (!isStoreProcedure)
                return FillDataSet(ds, tableName, storeProcedure, para);

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetStoredProcCommand(storeProcedure);

            if (para != null) cmd.Parameters.AddRange(para);
            db.LoadDataSet(cmd, ds, tableName);
            return true;
        }

        public DataSet ExecuteDataSet(string sql, SqlParameter[] para)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(sql);
            if (para != null) cmd.Parameters.AddRange(para);
            DataSet ds = db.ExecuteDataSet(cmd);

            return ds;
        }

        public int ExecuteNoQuery(string sql, SqlParameter[] para)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(sql);
            if (para != null) cmd.Parameters.AddRange(para);
            int i = db.ExecuteNonQuery(cmd);
            return i;
        }
        public int ExecuteNoQuery(string storeprocedure, SqlParameter[] para, bool isStoreProcedure)
        {
            if (!isStoreProcedure)
                return ExecuteNoQuery(storeprocedure, para);

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetStoredProcCommand(storeprocedure);
            if (para != null) cmd.Parameters.AddRange(para);
            int i = db.ExecuteNonQuery(cmd);
            return i;


        }

        /* jimmy - 2007-07-22 不能用，还需调试。
        public object ExecuteWithReturn(string sql, SqlParameter[] para)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(sql);
            if (para != null) cmd.Parameters.AddRange(para);

            SqlParameter paraOut = new SqlParameter();
            paraOut.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(paraOut);

            db.ExecuteNonQuery(cmd);
            return paraOut;
        }
        */
        public object ExecuteScalar(string sql, SqlParameter[] para)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(sql);
            if (para != null) cmd.Parameters.AddRange(para);
            object o = db.ExecuteScalar(cmd);
            return o;
        }

        public IDataReader ExecuteReader(string sql, SqlParameter[] para)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(sql);
            if (para != null) cmd.Parameters.AddRange(para);
            return db.ExecuteReader(cmd);
        }
    }
}
