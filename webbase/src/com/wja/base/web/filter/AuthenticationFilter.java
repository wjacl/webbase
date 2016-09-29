package com.wja.base.web.filter;

import java.io.IOException;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.wja.base.common.CommConstants;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
public class AuthenticationFilter implements Filter
{
    private static final String XHR_OBJECT_NAME = "XMLHttpRequest";
    
    private static final String HEADER_REQUEST_WITH = "x-requested-with";
    
    /**
     * 无权操作转向界面
     */
    private String unauthorizedUri = "/unauthorized";
    
    /**
     * 排除的地址模式
     */
    String[] exceptUriPatterns = null;
    
    /**
     * Default constructor.
     */
    public AuthenticationFilter()
    {
        // TODO Auto-generated constructor stub
    }
    
    /**
     * @see Filter#destroy()
     */
    @Override
    public void destroy()
    {
        // TODO Auto-generated method stub
    }
    
    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException
    {
        HttpServletRequest hrequest = (HttpServletRequest)request;
        HttpServletResponse hresponse = (HttpServletResponse)response;
        
        String uri = hrequest.getRequestURI();
        
        if (matchExcepts(uri))
        {
            chain.doFilter(request, response);
        }
        else
        {
            // 当前用户有权操作的uri集合
            @SuppressWarnings("unchecked")
            Set<String> privs = (Set<String>)hrequest.getSession().getAttribute(CommConstants.SESSION_USER_PRIV_PATHS);
            
            if (privs != null && privs.contains(uri))
            {
                chain.doFilter(request, response);
            }
            else
            {
                if (XHR_OBJECT_NAME.equals(hrequest.getHeader(HEADER_REQUEST_WITH)))
                {// ajax请求
                    hresponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    hresponse.getWriter().append(this.unauthorizedUri);
                }
                else
                {
                    hresponse.sendRedirect(this.unauthorizedUri);
                }
            }
        }
    }
    
    private boolean matchExcepts(String uri)
    {
        if (this.exceptUriPatterns != null)
        {
            for (String pattern : this.exceptUriPatterns)
            {
                if (uri.matches(pattern))
                {
                    return true;
                }
            }
        }
        return false;
    }
    
    /**
     * @see Filter#init(FilterConfig)
     */
    @Override
    public void init(FilterConfig fConfig)
        throws ServletException
    {
        String cpath = fConfig.getServletContext().getContextPath();
        
        this.unauthorizedUri = cpath + this.unauthorizedUri;
        
        String unauthorized = fConfig.getInitParameter("unauthorized-uri");
        if (StringUtils.isNotBlank(unauthorized))
        {
            unauthorized = unauthorized.replaceAll("\\s", "");
            if (!"".equals(unauthorized))
            {
                String str = "";
                if (!unauthorized.startsWith("/"))
                {
                    str = "/";
                }
                this.unauthorizedUri = cpath + str + unauthorized;
            }
        }
        
        String exceptUris = fConfig.getInitParameter("except-uri-patterns");
        if (StringUtils.isNotBlank(exceptUris))
        {
            exceptUris = exceptUris.replaceAll("\\s", "");
            
            if (StringUtils.isNotBlank(exceptUris))
            {
                this.exceptUriPatterns = exceptUris.split(";");
                for (int i = 0; i < this.exceptUriPatterns.length; i++)
                {
                    this.exceptUriPatterns[i] =
                        cpath + (this.exceptUriPatterns[i].startsWith("/") ? "" : "/") + this.exceptUriPatterns[i];
                }
            }
        }
    }
    
}
