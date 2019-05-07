using System;
using System.Collections.Generic;
using System.Text;
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
     }
}
