using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using Microsoft.IdentityModel.Tokens;
using NLog;
using WebApi.DataAccess;

namespace WebApi.Web.Controllers
{
    /// <summary>
    /// Esto verifica que el token sea valido
    /// </summary>
    internal class TokenValidationHandler : DelegatingHandler
    {
        private static Logger _logger = LogManager.GetCurrentClassLogger();


        private static bool TryRetrieveToken(HttpRequestMessage request, out string token)
        {
            token = null;
            IEnumerable<string> authzHeaders;
            if (!request.Headers.TryGetValues("Authorization", out authzHeaders) || authzHeaders.Count() > 1)
            {
                return false;
            }
            var bearerToken = authzHeaders.ElementAt(0);
            //_logger.Info("Obtengo Token: {0}", bearerToken);

            token = bearerToken.StartsWith("Bearer ") ? bearerToken.Substring(7) : bearerToken;

            if (!CheckTokenInDb(token)) return false;

            //_logger.Info("El token esta Ok en la bd");
            return true;
        }

        private static bool CheckTokenInDb(string token)
        {
            //_logger.Info("CheckTokenInDb");
            //Veo si el token esta en la base, si lo elimine, tengo que invalidar al usuario para que se vuelva a loguear
            SQLDataAccess sql = new SQLDataAccess();
            return sql.CheckIfTokenExists(token);
        }



        protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            HttpStatusCode statusCode;
            string token;

            
            if (!TryRetrieveToken(request, out token))
            {
                statusCode = HttpStatusCode.Unauthorized;
                return base.SendAsync(request, cancellationToken);
            }

            try
            {
                var secretKey = ConfigurationManager.AppSettings["JWT_SECRET_KEY"];
                var audienceToken = ConfigurationManager.AppSettings["JWT_AUDIENCE_TOKEN"];
                var issuerToken = ConfigurationManager.AppSettings["JWT_ISSUER_TOKEN"];
                var securityKey = new SymmetricSecurityKey(System.Text.Encoding.Default.GetBytes(secretKey));

                SecurityToken securityToken;
                var tokenHandler = new System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler();
                TokenValidationParameters validationParameters = new TokenValidationParameters()
                {
                    ValidAudience = audienceToken,
                    ValidIssuer = issuerToken,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    LifetimeValidator = this.LifetimeValidator,
                    IssuerSigningKey = securityKey
                };

                Thread.CurrentPrincipal = tokenHandler.ValidateToken(token, validationParameters, out securityToken);
                HttpContext.Current.User = tokenHandler.ValidateToken(token, validationParameters, out securityToken);

                return base.SendAsync(request, cancellationToken);
            }
            catch (SecurityTokenValidationException)
            {
                statusCode = HttpStatusCode.Unauthorized;
            }
            catch (Exception)
            {
                statusCode = HttpStatusCode.InternalServerError;
            }

            return Task<HttpResponseMessage>.Factory.StartNew(() => new HttpResponseMessage(statusCode) { });
        }

        public bool LifetimeValidator(DateTime? notBefore, DateTime? expires, SecurityToken securityToken, TokenValidationParameters validationParameters)
        {
            //Hago que el token no se venza nunca. Si quiero vencerlo, lo borro de la tabla "RefreshTokens" y
            //obligo al usuario a re-loguearse
            //_logger.Info("El token nunca expira");
            return true;
            //if (expires != null)
            //{
            //    if (DateTime.UtcNow < expires) return true;
            //}
            //return false;
        }
    }
}