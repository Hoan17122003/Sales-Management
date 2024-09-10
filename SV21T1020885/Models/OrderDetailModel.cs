using NuGet.Common;
using SV21T1020885.DomainModels;

namespace SV21T1020885.Web.Models
{
    public class OrderDetailModel
    {
        public Order Order { get; set; }
        public List<OrderDetail> Details { get; set; }

    }
}
