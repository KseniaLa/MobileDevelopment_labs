using System;
using System.Collections.Generic;
using System.Text;

namespace XamarinLab.Models
{
    public class Task
    {
         public string Id { get; set; }
         public string Name { get; set; }
         public string Description { get; set; }
         public int Priority { get; set; }
         public DateTime CreatedDate { get; set; }
         public DateTime ExpirationDate { get; set; }
         public string Color { get; set; }
         public string Role { get; set; }
         public string RoleId { get; set; }
    }
}
