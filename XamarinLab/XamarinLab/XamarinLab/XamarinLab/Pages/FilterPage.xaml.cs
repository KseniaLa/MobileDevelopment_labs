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
	public partial class FilterPage : ContentPage
	{
	     public List<Role> Roles { get; set; }

          public FilterPage ()
		{
			InitializeComponent ();
		}

	     private void PriorityPicker_OnSelectedIndexChanged(object sender, EventArgs e)
	     {
	          AppState.FilterByPriority = true;
	          AppState.Priority = PriorityPicker.SelectedIndex;
	     }

	     protected override async void OnAppearing()
	     {
	          base.OnAppearing();
	          Roles = await RoleHelper.GetAllRoles();
	          RolePicker.ItemsSource = Roles;

	          if (AppState.FilterByPriority)
	          {
	               PriorityPicker.SelectedIndex = AppState.Priority;
	          }

	          if (AppState.FilterByRole)
	          {
	               var role = Roles.FirstOrDefault(r => r.Id == AppState.RoleId);

	               if (role != null)
	               {
	                    RolePicker.SelectedIndex = Roles.IndexOf(role);
	               }
	          }

	          if (AppState.FilterByDate)
	          {
	               ExpirationDatePicker.Date = AppState.Date;
	          }
          }

	     private void DatePicker_OnDateSelected(object sender, DateChangedEventArgs e)
	     {
	          AppState.FilterByDate = true;
	          AppState.Date = ExpirationDatePicker.Date;
          }

	     private async void DeleteFilter_Clicked(object sender, EventArgs e)
	     {
	          AppState.FilterByPriority = false;
	          AppState.FilterByDate = false;
	          AppState.FilterByRole = false;

	          await Navigation.PopAsync(true);
	     }

	     private void RolePicker_OnSelectedIndexChanged(object sender, EventArgs e)
	     {
	          AppState.FilterByRole = true;
	          AppState.RoleId = Roles[RolePicker.SelectedIndex].Id;
	     }
	}
}