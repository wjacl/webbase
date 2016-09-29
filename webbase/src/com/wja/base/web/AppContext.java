package com.wja.base.web;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 应用上下文获取工具类
 * @author ok
 *
 */
public class AppContext implements ServletContextListener {
	
	private static WebApplicationContext springContext;
	
	private static ServletContext servletContext;

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		springContext = null;
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		servletContext = event.getServletContext();
		springContext = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
	}
	
	public static WebApplicationContext getWebApplicationContext(){
		return springContext;
	}

	public static ServletContext getServletContext(){
		return servletContext;
	}
}
