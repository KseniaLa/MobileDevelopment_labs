using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Firebase.Database;
using Firebase.Database.Query;
using Task = XamarinLab.Models.Task;

namespace XamarinLab.Helpers
{
     class FirebaseHelper
     {
          private readonly FirebaseClient firebase;

          public FirebaseHelper()
          {
               firebase = new FirebaseClient("https://lab4ksenia.firebaseio.com/");
          }

          public async Task<List<Task>> GetAllTasks()
          {
               // await firebase
               //     .Child("Tasks")
               //     .PostAsync(new Task() { Description = "hello", Name = "ksenia"});

               //var t = (await firebase
               //     .Child("Tasks")
               //     .OnceAsync<Task>(TimeSpan.FromSeconds(10))).ToList();

               return (await firebase
                    .Child("Tasks")
                    .OnceAsync<Task>()).Select(item => new Task
                    {
                         Name = item.Object.Name,
                         Description = item.Object.Description
                    }).ToList();
          }
     }
}
