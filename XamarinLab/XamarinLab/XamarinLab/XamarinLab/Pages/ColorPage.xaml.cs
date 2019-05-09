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
		     foreach (var color in _colors)
		     {
		          var button = new Button
		          {
                         BackgroundColor = color,
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
	          AppState.RoleColor = button.BackgroundColor;
	          await Navigation.PopModalAsync();
	     }

          private List<Color> _colors = new List<Color>
          {
               Color.Blue,
               Color.Crimson,
               Color.DarkGreen,
               Color.DarkOrange,
               Color.HotPink,
               Color.Chartreuse,
               Color.Lime,
               Color.LightCoral,
               Color.Yellow,
               Color.Goldenrod
          };
	}

     
}