using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using XamarinLab.Helpers;
using XamarinLab.Models;
using Task = XamarinLab.Models.Task;

namespace XamarinLab.Pages
{
	[XamlCompilation(XamlCompilationOptions.Compile)]
	public partial class AddTaskPage : ContentPage
	{
	     public List<Role> Roles { get; set; }

          public AddTaskPage ()
		{
			InitializeComponent ();

		     ToolbarItems.Add(new ToolbarItem
		     {
		          Text = "OK",
		          Command = new Command(AddTask),
		     });

               ExpirationDatePicker.MinimumDate = DateTime.Now;
		}

	     private void Picker_OnSelectedIndexChanged(object sender, EventArgs e)
	     {
	          
	     }

	     private void DatePicker_OnDateSelectedatePicker_DateSelected(object sender, DateChangedEventArgs e)
	     {
	          
	     }

	     private async void AddTask()
	     {
	          var name = NameEntry.Text;
	          var description = DescriptionEditor.Text;
	          var priority = PriorityPicker.SelectedIndex;
	          var date = ExpirationDatePicker.Date;
	          var time = ExpirationTimePicker.Time;

	          var color = Roles[RolePicker.SelectedIndex].Color;

	          var expirationDateTime = new DateTime(date.Year, date.Month, date.Day, time.Hours, time.Minutes, time.Seconds);

	          var task = new Task
	          {
	               CreatedDate = DateTime.Now,
	               Description = description,
	               Name = name,
	               ExpirationDate = expirationDateTime,
	               Priority = priority,
                    Color = color
	          };

               TaskHelper.AddTask(task);

	          await Navigation.PopModalAsync();
          }

	     protected override async void OnAppearing()
	     {
	          base.OnAppearing();
	          Roles = await RoleHelper.GetAllRoles();
	          RolePicker.ItemsSource = Roles;
          }
	}
}