using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiDataSet
{
    public class D_CreditCardInfo
    {
        public int crId, orderId;
        public string firstName, lastName;
        public string cardType, cardNumber;
        public string validDate, csc;
        public string address, city, state, zip, country;
        public byte status;
        public decimal amount, serviceFee, totalAmount;
        public DateTime orderDate, payDate;
        public int customerId;

        public D_CreditCardInfo()
        {
            crId = orderId = 0;
            firstName = lastName = cardType = cardNumber =
                validDate = csc =
                address = city = state = zip = country = "";
            status = 0;

            amount = serviceFee = totalAmount = 0;
            orderDate = payDate = new DateTime(1900, 1, 1);

            customerId = 0;
        }
    }
}
