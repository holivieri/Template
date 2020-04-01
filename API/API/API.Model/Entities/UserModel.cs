using System;

namespace API.Model.Entities
{
    public class UserModel
    {
        public string UserName { get; set; }
        public string Token { get; set; }
        public string Platform { get; set; }
        public string DeviceId { get; set; }
    }
}
