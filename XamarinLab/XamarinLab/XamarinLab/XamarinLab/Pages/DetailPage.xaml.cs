using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using XamarinLab.Enums;
using XamarinLab.Helpers;
using XamarinLab.Models;
using Task = XamarinLab.Models.Task;

namespace XamarinLab.Pages
{
     [XamlCompilation(XamlCompilationOptions.Compile)]
     public partial class DetailPage : ContentPage
     {
          private Task _task;

          public DetailPage(object item)
          {
               InitializeComponent();

               if (AppState.CurrentAccessLevel >= 2)
               {
                    ToolbarItems.Add(new ToolbarItem
                    {
                         Text = "Close Task",
                         Command = new Command(CloseTask),
                    });
               }

               if (!(item is Task task)) return;

               _task = task;

               if (AppState.Colors.ContainsValue(task.Color))
               {
                    RoleColorBox.Color = AppState.Colors.First(x => x.Value == task.Color).Key;
               }
               else
               {
                    RoleColorBox.Color = Color.AliceBlue;
               }

               NameLabel.Text = task.Name;
               DescriptionEditor.Text = task.Description;
               PriorityLabel.Text = $"Priority: {GetPriorityTest(task.Priority)}";
               RoleLabel.Text = $"Role: {task.Role}";
               CreatedDateLabel.Text = task.CreatedDate.ToString("g");
               ExpirationDateLabel.Text = task.CreatedDate.ToString("g");

               if (task.ExpirationDate < DateTime.Now)
               {
                    OutdatedLabel.IsVisible = true;
               }
          }

          private string GetPriorityTest(int priority)
          {
               switch ((TaskLevels)priority)
               {
                    case TaskLevels.Low: return "Low";
                    case TaskLevels.Medium: return "Medium";
                    case TaskLevels.High: return "High";
                    case TaskLevels.Critical: return "Critical";
                    default: return "Undefined";
               }
          }

          private async void CloseTask()
          {
               TaskHelper.DeleteTask(_task.Id);

               await DisplayAlert("Success", "Task was closed", "OK");

               await Navigation.PopModalAsync();
          }
     }
}