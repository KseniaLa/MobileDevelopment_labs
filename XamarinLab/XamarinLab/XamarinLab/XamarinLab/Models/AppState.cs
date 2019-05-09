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

          public static Dictionary<Xamarin.Forms.Color, string> Colors = new Dictionary<Xamarin.Forms.Color, string>
          {
               {Xamarin.Forms.Color.Blue, "Blue"},
               {Xamarin.Forms.Color.Crimson, "Crimson"},
               {Xamarin.Forms.Color.DarkGreen, "DarkGreen"},
               {Xamarin.Forms.Color.Yellow, "Yellow"},
               {Xamarin.Forms.Color.Red, "Red"},
               {Xamarin.Forms.Color.HotPink, "HotPink"},
               {Xamarin.Forms.Color.Orange, "Orange"},
          };
     }
}
