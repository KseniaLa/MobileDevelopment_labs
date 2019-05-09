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
     class TaskHelper
     {
          private static readonly FirebaseClient Firebase;

          static TaskHelper()
          {
               Firebase = new FirebaseClient("https://lab4ksenia.firebaseio.com/");
          }

          public static async Task<List<Task>> GetAllTasks()
          {
               return (await Firebase
                    .Child("Tasks")
                    .OnceAsync<Task>()).Select(item => new Task
                    {
                         Name = item.Object.Name,
                         Description = item.Object.Description,
                         CreatedDate = item.Object.CreatedDate,
                         ExpirationDate = item.Object.ExpirationDate,
                         Priority = item.Object.Priority,
                         Color = item.Object.Color
                    }).ToList();
          }

          public static async void AddTask(Task task)
          {
               await Firebase.Child("Tasks").PostAsync(task);
          }
     }
}
