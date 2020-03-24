 using System.ComponentModel.DataAnnotations;

namespace WebAPI.web.Models
{
    public class LoginRequest
    {
        [Required]
        public string UserName { get; set; }

        [Required]
        public string Password { get; set; }

        public string Platform { get; set; }


        /// <summary>
        /// Phone token identifier
        /// </summary>
        public string PhoneId { get; set; }

    }
}