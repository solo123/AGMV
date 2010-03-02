using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiDataSet
{
    public class D_OrderInfo
    {
        public int OrderId;
        public int ScheduleId;
        public string Pickup;
        public int NumAdult, NumChild;
        public decimal NumRoom;
        public decimal PriceAdult, PriceChild;
        public decimal ServicePercent, Fare, ServiceFee, TotalAmount, ActureAmount;
        public int MemberId;
        public string FirstName, LastName;
        public string ContactPhone;
        public string Address, City, State, Country, Zip;
        public string PayMode;
        public string Email;
        public byte Status;
        public string notes;

        public D_OrderInfo()
        {
            OrderId = ScheduleId = 
                NumAdult = NumChild = 
                MemberId = 0;

            Pickup = FirstName = LastName = ContactPhone = 
                Address = City = State = Country = Zip = 
                PayMode = Email = notes = "";

            NumRoom = 
                PriceAdult = PriceChild = 
                ServicePercent = ServiceFee = Fare = 
                TotalAmount = ActureAmount = 0;

            Status = 0;
        }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Order id:");
            sb.Append(OrderId);
            sb.Append("\n--------------------------------------");
            sb.Append("\n\t\tSchedule id:");
            sb.Append(ScheduleId);
            sb.Append("\n\n\tOrder info:");
            sb.Append("\n\t-----------");
            sb.Append("\n\t\tAdult: ");
            sb.Append(NumAdult);
            sb.Append(" X $");
            sb.Append(PriceAdult.ToString());
            sb.Append("\n\t\tChild: ");
            sb.Append(NumChild);
            sb.Append(" X $");
            sb.Append(PriceChild.ToString());
            sb.Append("\n\t\t# of room:");
            sb.Append(NumRoom.ToString());

            sb.Append("\n\t\tCard type: ");
            sb.Append(PayMode);
            sb.Append("\n\t\tSubtotal: $");
            sb.Append(Fare.ToString());
            sb.Append("\n\t\tService fee: $");
            sb.Append(ServiceFee.ToString());
            sb.Append("\n\t\tTotal: $");
            sb.Append(TotalAmount.ToString());
            sb.Append("\n\n\tCustomer info:");
            sb.Append("\n\t---------------");
            sb.Append("\n\t\tCustomer name:");
            sb.Append(FirstName);
            sb.Append('.');
            sb.Append(LastName);
            sb.Append("\n\t\tAddress: ");
            sb.Append(Address);
            sb.Append("\n\t\tCity:");
            sb.Append(City);
            sb.Append(" State:");
            sb.Append(State);
            sb.Append(" ZIP:");
            sb.Append(Zip);
            sb.Append(" Country:");
            sb.Append(Country);
            sb.Append("\n\n\t\tContact phone:");
            sb.Append(ContactPhone);
            sb.Append("\n\t\tEmail:");
            sb.Append(Email);
            sb.Append("\n--------------end of order -----------\n");

            return sb.ToString();
        }
    }
}
