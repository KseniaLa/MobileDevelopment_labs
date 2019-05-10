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
	public partial class SignUpPage : ContentPage
	{
          public List<Role> Roles { get; set; }

		public SignUpPage ()
		{
			InitializeComponent ();

		     ToolbarItems.Add(new ToolbarItem
		     {
		          Text = "Sign Up",
		          Command = new Command(RegisterButton_Clicked),
		     });
          }

	     private void Picker_OnSelectedIndexChanged_SelectedIndexChanged(object sender, EventArgs e)
	     {
	          
	     }

	     private async void RegisterButton_Clicked()
	     {
	          if (LoginEntry.Text == "" || PasswordEntry.Text == "" || RolePicker.SelectedIndex == -1)
	          {
	               await DisplayAlert("Error", "Not all values set", "OK");
	               return;
	          }

               var role = Roles[RolePicker.SelectedIndex];

               var user = new User
	          {
	               Login = LoginEntry.Text,
	               Password = PasswordEntry.Text,
	               RoleId = role.Id
	          };

               UserHelper.AddUser(user);

	          AppState.CurrentUser = user;
	          AppState.CurrentAccessLevel = role.PriviledgeLevel;

	          await Navigation.PushAsync(new TabsPage());
          }

	     protected override async void OnAppearing()
	     {
	          base.OnAppearing();
	          Roles = await RoleHelper.GetAllRoles();
	          RolePicker.ItemsSource = Roles;
	     }
	}
}