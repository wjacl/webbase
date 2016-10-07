package com.wja.base.common;

/**
 * 系统通用常量定义接口
 * 
 * @author wja
 *         
 */
public interface CommConstants
{
    
    String SESSION_USER = "session_user";
    
    String SESSION_USER_ID = "session_user_id";
    
    String SESSION_USER_PRIV_PATHS = "session_user_priv_paths";
    
    String SESSION_LANG = "user_lang";
    
    int RESULT_ADD_OK = 1;
    
    int RESULT_UPDATE_OK = 2;
    
    int RESULT_DELETE_OK = 3;
    
    /**
     * 数据有效
     */
    byte DATA_VALID = 1;
    
    /**
     * 数据无效（已删除）
     */
    byte DATA_INVALID = 0;
    
    interface User
    {
        /**
         * 用户类别-学生
         */
        String TYPE_STUDENT = "user.type.S";
        
        /**
         * 用户类别-员工
         */
        String TYPE_STAFF = "user.type.A";
        
        /**
         * 用户类别-合作企业用户
         */
        String TYPE_COMPANY = "user.type.C";
        
        /**
         * 用户状态-正常
         */
        String STATUS_NORMAL = "user.status.N";
        
        /**
         * 用户状态-锁定
         */
        String STATUS_LOCK = "user.status.L";
        
    }
    
}