using System;
using System.Collections.Generic;
using System.Text;

namespace XamarinLab.Models
{
     public class Role
     {
          public string Id { get; set; }
          public string Name { get; set; }
          public int PriviledgeLevel { get; set; }

          public int RedColor { get; set; }
          public int GreenColor { get; set; }
          public int BlueColor { get; set; }
     }
}
