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
		}

	     private void Picker_OnSelectedIndexChanged_SelectedIndexChanged(object sender, EventArgs e)
	     {
	          
	     }

	     private void RegisterButton_Clicked(object sender, EventArgs e)
	     {
	          var user = new User
	          {
	               Login = LoginEntry.Text,
	               Password = PasswordEntry.Text,
	               RoleId = Roles[RolePicker.SelectedIndex].Id
	          };

               UserHelper.AddUser(user);
	     }

	     protected override async void OnAppearing()
	     {
	          base.OnAppearing();
	          Roles = await RoleHelper.GetAllRoles();
	          RolePicker.ItemsSource = Roles;
	     }
	}
}