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
	     private double _red = 30;
	     private double _green = 0;
	     private double _blue = 0;

          public AddRolePage ()
		{
			InitializeComponent ();

		     ToolbarItems.Add(new ToolbarItem
		     {
		          Text = "OK",
		          Command = new Command(AddRole),
		     });

               RoleColorBox.Color = new Color(_red, _green, _blue);
          }

	     private void Picker_OnSelectedIndexChangedicker_SelectedIndexChanged(object sender, EventArgs e)
	     {
	          
	     }

	     private async void AddRole()
	     {
	          var name = NameEntry.Text;
	          var access = Picker.SelectedIndex;

               var role = new Role
	          {
	               Name = name,
	               PriviledgeLevel = access,
	               Id = Guid.NewGuid().ToString(),
	               Color = AppState.RoleColor.colorName
	          };

               RoleHelper.AddRole(role);

	          await Navigation.PopModalAsync();
          }

	     private async void ChooseColor_Clicked(object sender, EventArgs e)
	     {
	          await Navigation.PushModalAsync(new ColorPage());
	     }

	     protected override void OnAppearing()
	     {
	          base.OnAppearing();
	          RoleColorBox.Color = AppState.RoleColor.color;
	     }
	}
}