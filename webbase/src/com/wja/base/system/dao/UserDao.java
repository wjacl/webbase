package com.wja.base.system.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import com.wja.base.system.entity.Privilege;
import com.wja.base.system.entity.User;

@org.springframework.stereotype.Repository
public interface UserDao extends Repository<User, String>
{
    User getUserByUsername(String username);
    
    @Query("select distinct p from User u JOIN u.roles r JOIN r.privs p where u.id = ?1 order by p.orderNo")
    List<Privilege> getUserPrivileges(String id);
}
