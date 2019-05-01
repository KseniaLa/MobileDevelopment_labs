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
	public partial class ListPage : ContentPage
	{
	     public string[] Phones { get; set; }

	     public ListPage()
	     {
	          InitializeComponent();

	          string[] phones = new string[] { "iPhone 7", "Samsung Galaxy S8", "Huawei P10", "LG G6" };

	          var listView = new ListView();

	          listView.ItemsSource = phones;
	          listView.ItemTapped += untapItem;
	          this.Content = new StackLayout { Children = { listView } };
	     }

	     private async void untapItem(object sender, ItemTappedEventArgs e)
	     {
	          await Navigation.PushModalAsync(new DetailPage(e.Item.ToString()));
	          ((ListView)sender).SelectedItem = null;
	     }
     }
}