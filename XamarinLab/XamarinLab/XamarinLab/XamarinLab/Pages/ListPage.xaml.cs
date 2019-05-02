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
          public string[] Phones { get; set; }

          private ListView taskList = new ListView();

          public ListPage()
          {
               InitializeComponent();

               taskList.ItemTapped += untapItem;

               taskList.HasUnevenRows = true;

               taskList.ItemTemplate = new DataTemplate(() =>
               {
                    Label titleLabel = new Label {FontSize = 18};
                    titleLabel.SetBinding(Label.TextProperty, "Name");

                    Label companyLabel = new Label();
                    companyLabel.SetBinding(Label.TextProperty, "Description");

                    return new ViewCell
                    {
                         View = new StackLayout
                         {
                              Padding = new Thickness(0, 5),
                              Orientation = StackOrientation.Vertical,
                              Children = {titleLabel, companyLabel}
                         }
                    };
               });

               this.Content = new StackLayout { Children = { taskList } };
          }

          private async void OnButtonClickedAsync(object sender, EventArgs e)
          {

          }

          private async void untapItem(object sender, ItemTappedEventArgs e)
          {
               await Navigation.PushModalAsync(new DetailPage(e.Item));
               ((ListView)sender).SelectedItem = null;
          }

          protected override async void OnAppearing()
          {
               base.OnAppearing();
               var firebase = new FirebaseHelper();
               var allPersons = await firebase.GetAllTasks();
               taskList.ItemsSource = allPersons;
          }
     }
}