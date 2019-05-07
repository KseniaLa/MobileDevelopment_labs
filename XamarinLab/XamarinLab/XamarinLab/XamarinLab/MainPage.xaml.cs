using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;
using XamarinLab.Helpers;
using XamarinLab.Models;
using XamarinLab.Pages;

namespace XamarinLab
{
     public partial class MainPage : ContentPage
     {
          public MainPage()
          {
               InitializeComponent();
               
          }

          private async void OnLoginButtonClicked(object sender, System.EventArgs e)
          {
               var login = LoginEntry.Text;
               var password = LoginEntry.Text;
               var user = await UserHelper.GetUserByCredentials(login, password);
               if (user == null)
               {
                    await DisplayAlert("Error", "Invalid login or password", "OK");
                    return;
               }

               AppState.CurrentUser = user;
               await Navigation.PushAsync(new TabsPage());
          }

          private async void OnRegisterButtonClicked(object sender, System.EventArgs e)
          {
               await Navigation.PushAsync(new SignUpPage());
          }
     }
}
