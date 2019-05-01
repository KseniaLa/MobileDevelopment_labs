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
          }
     }
}