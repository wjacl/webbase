package com.wja.base.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class DateUtil
{
    /**
     * 默认的格式器 格式：YYYY-MM-DD
     */
    public static final DateFormat DEFAULT_DF = new SimpleDateFormat("YYYY-MM-DD");
    
    public static final DateFormat getDateFormat(String pattern)
    {
        return new SimpleDateFormat(pattern);
    }
    
}
