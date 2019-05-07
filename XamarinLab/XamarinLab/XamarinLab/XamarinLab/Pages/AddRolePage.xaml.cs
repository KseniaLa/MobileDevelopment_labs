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
	public partial class AddRolePage : ContentPage
	{
		public AddRolePage ()
		{
			InitializeComponent ();
		}

	     private void Picker_OnSelectedIndexChangedicker_SelectedIndexChanged(object sender, EventArgs e)
	     {
	          
	     }

	     private void AddButton_Clicked(object sender, EventArgs e)
	     {
	          var name = NameEntry.Text;
	          var access = Picker.SelectedIndex;

	          var role = new Role
	          {
	               Name = name,
	               PriviledgeLevel = access,
	               Id = Guid.NewGuid().ToString(),
	               BlueColor = 20,
	               GreenColor = 1,
	               RedColor = 1
	          };

               RoleHelper.AddRole(role);
	     }
	}
}