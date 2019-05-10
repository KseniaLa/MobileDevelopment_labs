using System;
using System.Collections.Generic;
using System.Text;
using Realms;

namespace XamarinLab.Models
{
    public class Setting : RealmObject
    {
         [PrimaryKey]
         public int SettingId { get; set; }
         public bool IsDarkTheme { get; set; }
     }
}
