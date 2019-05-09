using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;

namespace XamarinLab.Models
{
     public static class AppState
     {
          public static User CurrentUser { get; set; }
          public static (Color color, string colorName) RoleColor { get; set; }
          public static int CurrentAccessLevel { get; set; }
     }
}
