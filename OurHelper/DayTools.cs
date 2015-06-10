using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace OurHelper
{
    public class DayTools
    {
        //根据开学日期、第几周、第几天计算具体日期
        public static string GetDateByDayAndWeekIndexAndDayIndex(DateTime date, int weekIndex, int dayIndex)
        {
            int dayDiff = (int)date.DayOfWeek - dayIndex;
            return date.AddDays((weekIndex - 1) * 7 -dayDiff).ToString("yyyy-MM-dd");
        }

        //根据开始时间、结束时间计算一共有多少周
        public static int GetWeeksByStartDayAndEndDay(DateTime startWeek, DateTime endWeek)
        {
            TimeSpan ts = endWeek - startWeek;
            double result = ts.Days / 7;
            return (int)Math.Ceiling(result);
        }

        public static int GetDiffDaysBetweenSDateTimeAndEDateTime(DateTime startDateTime, DateTime endDateTime)
        {
            TimeSpan ts =DateTime.Parse( endDateTime.ToString ("yyyy-MM-dd") )- DateTime.Parse( startDateTime.ToString ("yyyy-MM-dd"));
            return ts.Days;
        }
        /// <summary>
        /// 根据时间获取星期几
        /// </summary>
        /// <param name="datetime"></param>
        /// <returns></returns>
        public static string GetChineseDayOfWeekByDatetime(DateTime datetime)
        {
            string[] day = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
           return day[ (int)datetime.DayOfWeek];
        }

        /// <summary>
        /// 以一个日期为标准，计算起星期X的日期
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="weekday"></param>
        /// <param name="Number"></param>
        /// <returns></returns>
        public static DateTime GetWeekUpOfDate(DateTime dt, DayOfWeek weekday, int Number)
        {
            int wd1 = (int)weekday;
            int wd2 = (int)dt.DayOfWeek;
            return wd2 == wd1 ? dt.AddDays(7 * Number) : dt.AddDays(7 * Number - wd2 + wd1);
        }
    }
}
