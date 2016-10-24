package com.wja.base.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil
{
    public static final String DATE = "yyyy-MM-dd";
    
    public static final String TIME = "HH:mm:ss";
    
    public static final String DATE_TIME = "yyyy-MM-dd HH:mm:ss";
    
    /**
     * 默认的格式器 格式：yyyy-MM-dd
     */
    public static final DateFormat DEFAULT_DF = new SimpleDateFormat(DATE);
    
    public static final DateFormat getDateFormat(String pattern)
    {
        return new SimpleDateFormat(pattern);
    }
    
    /**
     * 
     * 判断一个日期是否是休息日
     * 
     * @param cal
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final boolean isRestDay(Calendar cal)
    {
        int weekDay = cal.get(Calendar.DAY_OF_WEEK);
        return weekDay == Calendar.SATURDAY || weekDay == Calendar.SUNDAY;
    }
    
    /**
     * 
     * 判断一个日期是否是休息日
     * 
     * @param date
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final boolean isRestDay(Date d)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        int weekDay = cal.get(Calendar.DAY_OF_WEEK);
        return weekDay == Calendar.SATURDAY || weekDay == Calendar.SUNDAY;
    }
    
    public static void toNextWorkDay(Calendar cal)
    {
        if (isRestDay(cal))
        {
            cal.add(Calendar.DATE, 1);
            toNextWorkDay(cal);
        }
    }
}
