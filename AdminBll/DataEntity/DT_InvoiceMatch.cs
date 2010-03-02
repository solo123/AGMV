using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.BLL.Admin.DataEntity
{
    public class DT_InvoiceMatch
    {
        public int MatchID { get; set; }
        public int AgentID { get; set; }
        public decimal Amount { get; set; }
        public decimal Cost { get; set; }
        public decimal Profit { get; set; }
        public decimal Tax { get; set; }

        public int Operator { get; set; }
        public string AgentInv { get; set; }
        public string Notes { get; set; }
        public int PaymentMethod { get; set; }

        public string MatchOrders { get; set; }
        public DateTime MatchDate { get; set; }
        public int Status { get; set; }

        public List<DT_InvoiceMatchOrder> Orders { get; set; }

        public DT_InvoiceMatch()
        {
            Orders = new List<DT_InvoiceMatchOrder>();
        }
    }

    public class DT_InvoiceMatchOrder
    {
        public int OrderID { get; set; }
        public decimal Cost { get; set; }

        public DT_InvoiceMatchOrder(int orderID, decimal cost)
        {
            OrderID = orderID;
            Cost = cost;
        }
    }
}
