using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using XamarinLab.Helpers;
using XamarinLab.Models;

namespace XamarinLab.Pages
{
	[XamlCompilation(XamlCompilationOptions.Compile)]
	public partial class RolesListPage : ContentPage
	{
	     public List<Role> Roles { get; set; }

          public RolesListPage ()
		{
			InitializeComponent ();

		     //AddRoleButton.IsVisible = false;
		}

	     private void TapItem(object sender, ItemTappedEventArgs e)
	     {
	          ((ListView)sender).SelectedItem = null;
          }

	     private async void Button_OnClicked(object sender, EventArgs e)
	     {
	          await Navigation.PushModalAsync(new NavigationPage(new AddRolePage()));
          }

	     protected override async void OnAppearing()
	     {
	          base.OnAppearing();
	          Roles = await RoleHelper.GetAllRoles();
	          RoleList.ItemsSource = Roles;
	     }
	}
}