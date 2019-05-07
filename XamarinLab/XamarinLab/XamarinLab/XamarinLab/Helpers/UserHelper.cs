using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Firebase.Database;
using Firebase.Database.Query;
using XamarinLab.Models;

namespace XamarinLab.Helpers
{
     public class UserHelper
     {
          private static readonly FirebaseClient Firebase;

          static UserHelper()
          {
               Firebase = new FirebaseClient("https://lab4ksenia.firebaseio.com/");
          }

          public static async void AddUser(User user)
          {
               await Firebase.Child("Users").PostAsync(user);
          }

          public static async Task<User> GetUserByCredentials(string login, string password)
          {
               return (await Firebase
                    .Child("Users")
                    .OnceAsync<User>()).Select(item => new User
                    {
                         Login = item.Object.Login,
                         Password = item.Object.Password,
                         RoleId = item.Object.RoleId
                    }).FirstOrDefault(x => x.Login == login && x.Password == password);
          }
     }
}
