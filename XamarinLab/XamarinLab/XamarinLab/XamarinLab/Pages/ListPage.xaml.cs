using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using XamarinLab.Helpers;
using Task = XamarinLab.Models.Task;

namespace XamarinLab.Pages
{
     public partial class ListPage : ContentPage
     {
          public List<Task> Tasks { get; set; }

          public ListPage()
          {
               InitializeComponent();
          }

          private async void untapItem(object sender, ItemTappedEventArgs e)
          {
               await Navigation.PushModalAsync(new DetailPage(e.Item));
               ((ListView)sender).SelectedItem = null;
          }

          protected override async void OnAppearing()
          {
               base.OnAppearing();
               Tasks = await TaskHelper.GetAllTasks();
               TaskList.ItemsSource = Tasks;
          }

          private async void Button_OnClicked(object sender, EventArgs e)
          {
               await Navigation.PushModalAsync(new AddTaskPage());
          }
     }
}