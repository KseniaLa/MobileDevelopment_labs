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
     public partial class TabsPage : TabbedPage
     {
          public TabsPage()
          {
               InitializeComponent();

               ToolbarItems.Add(new ToolbarItem("Log Out", null, OnBackPressed));

               Title = "Tasks";

               var listPage = new NavigationPage(new ListPage())
               {
                    Icon = "ic_action_list.png"
               };

               var rolesPage = new NavigationPage(new RolesListPage())
               {
                    Icon = "ic_action_add_box.png"
               };

               Children.Add(listPage);
               Children.Add(rolesPage);
               Children.Add(new SettingsPage());

               ToolbarItems.Add(new ToolbarItem("Search", "ic_action_filter_list.png", async () =>
               {
                    await Navigation.PushAsync(new FilterPage());
               }));
          }

          protected override void OnTabIndexPropertyChanged(int oldValue, int newValue)
          {
               base.OnTabIndexPropertyChanged(oldValue, newValue);
               var titles = new[] {"Tasks", "Roles", "Settings"};
               Title = titles[newValue];
          }

          protected async void OnBackPressed()
          {
               await Navigation.PopToRootAsync(true);
          }
     }
}