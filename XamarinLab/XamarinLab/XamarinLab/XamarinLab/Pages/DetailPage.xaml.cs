using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using XamarinLab.Enums;
using Task = XamarinLab.Models.Task;

namespace XamarinLab.Pages
{
	[XamlCompilation(XamlCompilationOptions.Compile)]
	public partial class DetailPage : ContentPage
	{
	     public DetailPage(object item)
	     {
	          InitializeComponent();

	          ToolbarItems.Add(new ToolbarItem
	          {
	               Text = "Close Task",
	               Command = new Command(CloseTask),
	          });
               //NameLabel.IsVisible = false;

               if (!(item is Task task)) return;

	          NameLabel.Text = task.Name;
	          DescriptionEditor.Text = task.Description;
	          PriorityLabel.Text = $"Priority: {GetPriorityTest(task.Priority)}";

	          CreatedDateLabel.Text = task.CreatedDate.ToString("g");
	          ExpirationDateLabel.Text = task.CreatedDate.ToString("g");
          }

          private string GetPriorityTest(int priority)
          {
               switch ((TaskLevels) priority)
               {
                    case TaskLevels.Low: return "Low";
                    case TaskLevels.Medium: return "Medium";
                    case TaskLevels.High: return "High";
                    case TaskLevels.Critical: return "Critical";
                    default: return "Undefined";
               }
          }

          private async void OnButtonClickedAsync(object sender, EventArgs e)
	     {
	          await Navigation.PopModalAsync();
	     }

	     private void CloseTask()
	     {
	          
	     }
	}
}