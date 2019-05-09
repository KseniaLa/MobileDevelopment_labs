using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using Xamarin.Forms;

namespace XamarinLab.Converters
{
    public class TaskPriorityConverter : IValueConverter
    {
         public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
         {
              var priority = (int) value;
              if (priority == 3)
              {
                   return "LightPink";
              }

              return "White";
         }

         public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
         {
              throw new NotImplementedException();
         }
    }
}
