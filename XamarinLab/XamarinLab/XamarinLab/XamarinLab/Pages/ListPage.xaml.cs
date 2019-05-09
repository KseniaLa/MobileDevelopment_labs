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
     public partial class ListPage : ContentPage
     {
          public List<Task> Tasks { get; set; }

          public ListPage()
          {
               InitializeComponent();

               if (AppState.CurrentAccessLevel < 1)
               {
                    AddTaskButton.IsVisible = false;
               }
          }

          private async void untapItem(object sender, ItemTappedEventArgs e)
          {
               await Navigation.PushModalAsync(new NavigationPage(new DetailPage(e.Item)));
               ((ListView)sender).SelectedItem = null;
          }

          protected override async void OnAppearing()
          {
               base.OnAppearing();
               var tasks = await TaskHelper.GetAllTasks();

               if (AppState.FilterByPriority)
               {
                    tasks = tasks.Where(t => t.Priority == AppState.Priority).ToList();
               }

               if (AppState.FilterByRole)
               {
                    tasks = tasks.Where(t => t.RoleId == AppState.RoleId).ToList();
               }

               if (AppState.FilterByDate)
               {
                    tasks = tasks.Where(t => t.ExpirationDate.Date == AppState.Date.Date).ToList();
               }

               var critical = tasks.Where(t => t.Priority == (int)TaskLevels.Critical).ToList();
               var other = tasks.Where(t => t.Priority < (int)TaskLevels.Critical).ToList();
               other.Sort((a, b) =>
               {
                    if (a.CreatedDate > b.CreatedDate)
                         return 1;
                    if (a.CreatedDate < b.CreatedDate)
                         return -1;
                    return 0;
               });

               critical.AddRange(other);

               Tasks = critical;
               TaskList.ItemsSource = Tasks;
          }

          private async void Button_OnClicked(object sender, EventArgs e)
          {
               await Navigation.PushModalAsync(new NavigationPage(new AddTaskPage()));
          }
     }
}