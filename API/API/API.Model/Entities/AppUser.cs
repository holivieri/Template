using Microsoft.AspNetCore.Identity;
using System;
using System.ComponentModel.DataAnnotations;

namespace API.Model.Entities
{
    public class AppUser: IdentityUser<Guid>
    {

        [Required, StringLength(25)]
        public string FirstName { get; set; }

        [Required, StringLength(25)]
        public string LastName { get; set; }
        public string FullName { get { return $"{FirstName} {LastName}"; } }

        public string Token { get; set; }
        public string Platform { get; set; }
        public string DeviceId { get; set; }
    }
}
