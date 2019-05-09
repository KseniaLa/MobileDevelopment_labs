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
                         Id = item.Object.Id,
                         Name = item.Object.Name,
                         Description = item.Object.Description,
                         CreatedDate = item.Object.CreatedDate,
                         ExpirationDate = item.Object.ExpirationDate,
                         Priority = item.Object.Priority,
                         Color = item.Object.Color,
                         Role = item.Object.Role
                    }).ToList();
          }

          public static async void AddTask(Task task)
          {
               await Firebase.Child("Tasks").PostAsync(task);
          }

          public static async void DeleteTask(string taskId)
          {
               var toDeleteTask = (await Firebase
                    .Child("Tasks")
                    .OnceAsync<Task>()).FirstOrDefault(a => a.Object.Id == taskId);

               if (toDeleteTask != null)
               {
                    await Firebase.Child("Tasks").Child(toDeleteTask.Key).DeleteAsync();
               }
          }
     }
}
