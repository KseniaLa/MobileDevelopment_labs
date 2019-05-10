using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using Xamarin.Forms;
using XamarinLab.Models;

namespace XamarinLab.Converters
{
    public class TaskPriorityConverter : IValueConverter
    {
         public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
         {
              var priority = (int) value;
              if (priority == 3)
              {
                   return AppState.CriticalCell;
              }

              return AppState.NormalCell;
         }

         public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
         {
              throw new NotImplementedException();
         }
    }
}
