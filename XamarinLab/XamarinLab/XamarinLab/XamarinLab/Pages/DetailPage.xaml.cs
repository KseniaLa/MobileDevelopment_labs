using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinLab.Pages
{
	[XamlCompilation(XamlCompilationOptions.Compile)]
	public partial class DetailPage : ContentPage
	{
	     public DetailPage(string name)
	     {
	          InitializeComponent();

	          var stackLayout = new StackLayout();

	          var label = new Label
	          {
	               Text = name
	          };

	          var button = new Button
	          {
	               Text = "Ok",
	               FontSize = Device.GetNamedSize(NamedSize.Large, typeof(Button)),
	               BorderWidth = 1,
	               HorizontalOptions = LayoutOptions.Center,
	               VerticalOptions = LayoutOptions.CenterAndExpand
	          };
	          button.Clicked += OnButtonClickedAsync;
	          stackLayout.Children.Add(label);
	          stackLayout.Children.Add(button);
	          Content = stackLayout;
	     }

	     private async void OnButtonClickedAsync(object sender, EventArgs e)
	     {
	          await Navigation.PopModalAsync();
	     }
     }
}