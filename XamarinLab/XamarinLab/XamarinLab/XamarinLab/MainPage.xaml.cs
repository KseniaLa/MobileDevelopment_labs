using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;
using XamarinLab.Pages;

namespace XamarinLab
{
     public partial class MainPage : ContentPage
     {
          public MainPage()
          {
               InitializeComponent();
               //var stackLayout = new StackLayout();
               //var login = new Entry();
               //var password = new Entry();
               //var button = new Button
               //{
               //     Text = "Sign In",
               //     FontSize = Device.GetNamedSize(NamedSize.Large, typeof(Button)),
               //     BorderWidth = 1,
               //     HorizontalOptions = LayoutOptions.Center,
               //     VerticalOptions = LayoutOptions.CenterAndExpand
               //};
               //button.Clicked += OnLoginButtonClicked;
               //stackLayout.Children.Add(login);
               //stackLayout.Children.Add(password);
               //stackLayout.Children.Add(button);
               //Content = stackLayout;
          }

          private async void OnLoginButtonClicked(object sender, System.EventArgs e)
          {
               await Navigation.PushAsync(new TabsPage());
          }

          private async void OnRegisterButtonClicked(object sender, System.EventArgs e)
          {
               await Navigation.PushAsync(new RegistrationPage());
          }
     }
}
