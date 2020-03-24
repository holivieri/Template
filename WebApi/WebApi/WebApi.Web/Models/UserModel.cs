using System;
using System.Collections.Generic;

namespace WebApi.Web.Models
{
    public class UserModel
    {
        public string UserName { get; set; }
        public string Token { get; set; }
        public string Platform { get; set; }

        /// <summary>
        /// We could use this for pushNotifications
        /// </summary>
        public string PhoneId { get; set; }
    }
}
