using API.Model.Entities;
using API.Model.Repositories;
using API.Web.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Net;
using System.Web.Http;
using WebAPI.web.Models;

namespace WebAPI.web.Controllers
{
    
    [Route("api/login")]
    public class LoginController: ControllerBase  
    {

        private static Logger _logger = LogManager.GetCurrentClassLogger();


        [HttpGet]
        [Route("echoping")]
        public IActionResult EchoPing()
        {
            _logger.Info("Test service");
            return Ok(true);
        }


        [HttpPost]
        [Route("authenticate")]
        public IActionResult Authenticate(LoginRequest login)
        {
            try
                {
                    if (login == null)
                        return StatusCode(StatusCodes.Status400BadRequest);

                if (!ModelState.IsValid)
                    {
                        _logger.Error("Wrong username or password");
                    }


                    if(string.IsNullOrEmpty(login.Platform))
                    {
                        login.Platform = "Unknown";
                    }

                    bool isCredentialValid = false;
                    try
                    {
                        //isCredentialValid = Membership.ValidateUser(login.UserName, login.Password);
                        _logger.Info("Credentials: {0}", isCredentialValid.ToString());
                    }
                    catch (Exception ex)
                    {
                        _logger.Error("Excepcion: {0}", ex.ToString());
                        return StatusCode(StatusCodes.Status500InternalServerError);
                    }
            
           
                    if (isCredentialValid)
                    {
                        
                        var token = TokenGenerator.GenerateTokenJwt(login.UserName, "");
                        _logger.Info("Token: {0}", token);

                        UserModel userModel = new UserModel();
                        userModel.UserName = login.UserName;
                        userModel.Token = token;
                        userModel.Platform = login.Platform;
                        userModel.PhoneId = login.PhoneId;

                        TokenRepository data = new TokenRepository();

                        //lo creo porque no existe, es un nuevo Login
                        data.CreateTokenForUser(userModel);

                        LoginResponse resp = new LoginResponse()
                        {
                            Ok = true,
                            PropertyId = "",
                            Token = token
                        };
                        _logger.Info("Login Ok para {0}", login.UserName);
                        return Ok(resp);
                    }
                    else
                    {
                        _logger.Error("Login no autorizado para el usuario: {0} y clave: {1}", login.UserName, login.Password);
                        return Unauthorized();
                    }
                }
        catch (Exception ex)
        {
            _logger.Error("Error: {0}", ex.ToString());
            return StatusCode(StatusCodes.Status500InternalServerError); ;
        }
        }
    }
}
