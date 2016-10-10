package com.wja.base.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

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
    
}
