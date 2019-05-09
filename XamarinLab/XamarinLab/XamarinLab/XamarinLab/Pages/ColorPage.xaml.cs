using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using XamarinLab.Models;

namespace XamarinLab.Pages
{
	[XamlCompilation(XamlCompilationOptions.Compile)]
	public partial class ColorPage : ContentPage
	{
		public ColorPage ()
		{
			InitializeComponent ();
               var stackLayout = new StackLayout();
		     foreach (var color in AppState.Colors)
		     {
		          var button = new Button
		          {
                         BackgroundColor = color.Key,
		          };
		          button.Clicked += OnButtonClicked;
		          stackLayout.Children.Add(button);
		     }

		     var scrollView = new ScrollView {Content = stackLayout};
		     this.Content = scrollView;
          }

	     private async void OnButtonClicked(object sender, System.EventArgs e)
	     {
	          var button = (Button)sender;
	          AppState.RoleColor = (button.BackgroundColor, AppState.Colors[button.BackgroundColor]);
	          await Navigation.PopModalAsync();
	     }

          private readonly Dictionary<Color, string> _colors = new Dictionary<Color, string>
          {
               {Color.Blue, "Blue"},
               {Color.Crimson, "Crimson"},
               {Color.DarkGreen, "DarkGreen"},
               {Color.Yellow, "Yellow"},
               {Color.Red, "Red"},
               {Color.HotPink, "HotPink"},
               {Color.Orange, "Orange"},
          };
	}

     
}