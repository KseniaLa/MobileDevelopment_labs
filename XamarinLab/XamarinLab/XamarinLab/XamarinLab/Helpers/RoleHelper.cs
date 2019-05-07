using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Firebase.Database;
using Firebase.Database.Query;
using XamarinLab.Models;
using Task = XamarinLab.Models.Task;

namespace XamarinLab.Helpers
{
    public class RoleHelper
    {
         private static readonly FirebaseClient Firebase;

         static RoleHelper()
         {
              Firebase = new FirebaseClient("https://lab4ksenia.firebaseio.com/");
         }

          public static async Task<List<Role>> GetAllRoles()
          {
               return (await Firebase
                    .Child("Roles")
                    .OnceAsync<Role>()).Select(item => new Role
                    {
                         Name = item.Object.Name,
                         Id = item.Object.Id,
                         PriviledgeLevel = item.Object.PriviledgeLevel,
                         RedColor = item.Object.RedColor,
                         GreenColor = item.Object.GreenColor,
                         BlueColor = item.Object.BlueColor
                    }).ToList();
          }

          public static async void AddRole(Role role)
         {
              await Firebase.Child("Roles").PostAsync(role);
         }
     }
}
