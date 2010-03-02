using System.Collections.Generic;
using System.Linq;

using OmeiEDM;
namespace com.Omei.OmeiModel
{
    public class DestinationService
    {
        private OmeiDestinationEntity _ent = new OmeiDestinationEntity();

        public IEnumerable<EDM_Destination> ListDestinations()
        {
            return _ent.EDM_DestinationSet.OrderBy(d=>d.country).ThenBy(d=>d.state).ThenBy(d=>d.city).ToList();
        }

        public EDM_Destination GetDestinationByID(int id)
        {
            EDM_Destination dest = 
                (from c in _ent.EDM_DestinationSet
                 where c.DestinationID==id
                 select c).First();
            return dest;
        }

        public bool SaveDestinationDetail(EDM_Destination destination)
        {
            try
            {
                var dest = GetDestinationByID(destination.DestinationID);
                _ent.ApplyPropertyChanges(dest.EntityKey.EntitySetName, destination);
                _ent.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

    }
}
