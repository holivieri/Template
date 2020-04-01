using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Protocols;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Configuration;
using System.Security.Claims;
using System.Security.Cryptography;

namespace WebAPI.web.Controllers
{
    /// <summary>
    /// JWT Token generator class using "secret-key"
    /// more info: https://self-issued.info/docs/draft-ietf-oauth-json-web-token.html
    /// </summary>
    internal static class TokenGenerator
    {
       // private static IConfiguration _configuration { get; }

        public static string GenerateTokenJwt(string email, string propertyId, IConfiguration configuration)
        {
            // appsetting for Token JWT

            //_configuration.GetValue<string>("MailOptions:SMTP");
            var secretKey = configuration.GetValue<string>("Token:JWT_SECRET_KEY"); 
            var audienceToken = configuration.GetValue<string>("Token:JWT_AUDIENCE_TOKEN");
            var issuerToken = configuration.GetValue<string>("Token:JWT_ISSUER_TOKEN"); 
            var expireTime = configuration.GetValue<string>("Token:JWT_EXPIRE_MINUTES"); 

            var securityKey = new SymmetricSecurityKey(System.Text.Encoding.Default.GetBytes(secretKey));
            var signingCredentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256Signature);

            // create a claimsIdentity
            ClaimsIdentity claimsIdentity = new ClaimsIdentity(new[] {
                                                                    new Claim("EmailAddress", email),
                                                                    new Claim("PropertyID", propertyId)
                                            });

            // create token to the user
            var tokenHandler = new System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler();
            var jwtSecurityToken = tokenHandler.CreateJwtSecurityToken(
                audience: audienceToken,
                issuer: issuerToken,
                subject: claimsIdentity,
                notBefore: DateTime.UtcNow,
                expires: DateTime.UtcNow.AddMinutes(Convert.ToInt32(expireTime)),
                signingCredentials: signingCredentials);

            var jwtTokenString = tokenHandler.WriteToken(jwtSecurityToken);
            return jwtTokenString;
        }

        public static string GenerateRefreshToken()
        {
            var randomNumber = new byte[32];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(randomNumber);
                return Convert.ToBase64String(randomNumber);
            }
        }

    }
}