using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Firebase.Database;
using Firebase.Database.Query;
using XamarinLab.Enums;
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
                         PriviledgeText = GetPriviledgeText(item.Object.PriviledgeLevel),
                         Color = item.Object.Color
                    }).ToList();
          }

          public static async void AddRole(Role role)
          {
               await Firebase.Child("Roles").PostAsync(role);
          }

          private static string GetPriviledgeText(int id)
          {
               switch ((AccessLevels) id)
               {
                    case AccessLevels.ReadOnly:
                         return "Read Only";
                    case AccessLevels.CreateOnly:
                         return "Can create tasks";
                    case AccessLevels.CanCreateClose:
                         return "Can create and close tasks";
                    case AccessLevels.CanCreateRoles:
                         return "Can create/close tasks and manage roles";
                    default: return "Undefined";
               }
          }
     }
}
