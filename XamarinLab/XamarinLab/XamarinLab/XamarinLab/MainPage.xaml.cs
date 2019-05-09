using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;
using XamarinLab.Helpers;
using XamarinLab.Models;
using XamarinLab.Pages;
using Color = System.Drawing.Color;

namespace XamarinLab
{
     public partial class MainPage : ContentPage
     {
          public MainPage()
          {
               InitializeComponent();
               AppState.RoleColor = (Color.Green, "Green");
          }

          private async void OnLoginButtonClicked(object sender, System.EventArgs e)
          {
               var login = LoginEntry.Text;
               var password = LoginEntry.Text;

               if (login == "" || password == "")
               {
                    await DisplayAlert("Error", "Empty login or password", "OK");
                    return;
               }

               Loading.IsRunning = true;
               var user = await UserHelper.GetUserByCredentials(login, password);
               if (user == null)
               {
                    await DisplayAlert("Error", "Invalid login or password", "OK");
                    return;
               }

               var role = await RoleHelper.GetRoleById(user.RoleId);
               
               AppState.CurrentUser = user;
               AppState.CurrentAccessLevel = role?.PriviledgeLevel ?? 0;

               Loading.IsRunning = false;
               await Navigation.PushAsync(new TabsPage());
          }

          private async void OnRegisterButtonClicked(object sender, System.EventArgs e)
          {
               await Navigation.PushAsync(new SignUpPage());
          }

          protected override void OnAppearing()
          {
               base.OnAppearing();
               AppState.CurrentUser = null;
               AppState.CurrentAccessLevel = 0;
          }
     }
}
