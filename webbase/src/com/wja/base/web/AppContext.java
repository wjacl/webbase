package com.wja.base.web;

import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

/**
 * 应用上下文获取工具类
 * 
 * @author ok
 *         
 */
public class AppContext implements ServletContextListener
{
    
    private static WebApplicationContext springContext;
    
    private static ServletContext servletContext;
    
    @Override
    public void contextDestroyed(ServletContextEvent arg0)
    {
        springContext = null;
    }
    
    @Override
    public void contextInitialized(ServletContextEvent event)
    {
        servletContext = event.getServletContext();
        springContext = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
    }
    
    public static WebApplicationContext getWebApplicationContext()
    {
        return springContext;
    }
    
    public static ServletContext getServletContext()
    {
        return servletContext;
    }
    
    /**
     * 获取国际化信息
     * 
     * @param code 国际化代码
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static String getMessage(String code)
    {
        return getMessage(code, null);
    }
    
    /**
     * 
     * 获取国际化信息
     * 
     * @param code 国际化代码
     * @param args 信息中的替换参数
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static String getMessage(String code, Object[] args)
    {
        HttpServletRequest req = RequestThreadLocal.request.get();
        Locale locale = (Locale)req.getSession().getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
        return springContext.getMessage(code, args, locale == null ? req.getLocale() : locale);
    }
}
