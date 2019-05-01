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
               var stackLayout = new StackLayout();

               var button = new Button
               {
                    Text = "Нажми!",
                    FontSize = Device.GetNamedSize(NamedSize.Large, typeof(Button)),
                    BorderWidth = 1,
                    HorizontalOptions = LayoutOptions.Center,
                    VerticalOptions = LayoutOptions.CenterAndExpand
               };
               button.Clicked += OnButtonClickedAsync;
               stackLayout.Children.Add(button);
               Content = stackLayout;
          }

          private async void OnButtonClickedAsync(object sender, System.EventArgs e)
          {
               await Navigation.PushAsync(new TabsPage());
          }
     }
}
