package org.joey.security.domain;

import java.io.Serializable;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 资源接口
 * 
 */
public interface ResourceDetails extends Serializable {

    String getResourceString();


    String getResourceType();


    Collection<GrantedAuthority> getAuthorities();
}
