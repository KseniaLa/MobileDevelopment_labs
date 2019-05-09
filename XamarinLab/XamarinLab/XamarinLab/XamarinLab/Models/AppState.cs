using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;

namespace XamarinLab.Models
{
     public static class AppState
     {
          public static User CurrentUser { get; set; }
          public static Color RoleColor { get; set; }
     }
}
