package com.wja.base.util;

import net.sourceforge.pinyin4j.PinyinHelper;

public class StringUtil
{
    /**
     * 得到中文首字母
     * 
     * @param str
     * @return
     */
    public static String getPinYinHeadChar(String str)
    {
        
        String convert = "";
        for (int j = 0; j < str.length(); j++)
        {
            char word = str.charAt(j);
            String[] pinyinArray = PinyinHelper.toHanyuPinyinStringArray(word);
            if (pinyinArray != null)
            {
                convert += pinyinArray[0].charAt(0);
            }
            else
            {
                convert += word;
            }
        }
        return convert.toLowerCase(); // 转小写以处理字符串中有大写英文字母（统一为小写）
    }
    
    public static void main(String[] args)
    {
        System.out.println(StringUtil.getPinYinHeadChar("中国人"));
    }
}
