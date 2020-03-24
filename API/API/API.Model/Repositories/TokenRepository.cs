using API.Model.Entities;
using System;


namespace API.Model.Repositories
{
    public class TokenRepository
    {
        public bool CreateTokenForUser(UserModel user)
        {
            //save to db
            return true;
        }
        public bool CheckIfTokenExists(string token)
        {

            return true;
        }
    }
}
