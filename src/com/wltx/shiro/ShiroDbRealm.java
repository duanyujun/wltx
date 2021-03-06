package com.wltx.shiro;

import java.util.Collection;
import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;

import com.wltx.model.User;

/**
 * @author java 动态权限的核心处理方法
 */
public class ShiroDbRealm extends AuthorizingRealm {

	/**
	 * 认证回调函数,登录时调用.
	 */
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {

		/**
		 * 获取token中的用户信息，如果验证通过，则返回info信息
		 */
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		String userName = token.getUsername();
		User user = User.dao.findFirst("select * from user where username = ? ", userName);
		if (user != null) {
			return new SimpleAuthenticationInfo(user.get("username"), user.get("password"), getName());
		} else {
			return null;
		}
	}

	/**
	 * 授权查询回调函数
	 */
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String userName = (String) principals.fromRealm(getName()).iterator().next();
		/** 动态设置用户的角色，和角色对应的权限 */
		User user = User.dao.findFirst("select * from user where username = ? ", userName);
		if (user != null) {
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			List<String> roleNameList = RolesService.service.getRoleNameList(user);
			info.addRoles(roleNameList); // 用户有哪些role

			List<Roles> roleList = RolesService.service.getRoleList(user);

			for (Roles role : roleList) { // 每个role有哪些权限
				Collection<String> per = role.getPermissionNameList();
				info.addStringPermissions(per);
			}
			return info;
		} else {
			return null;
		}
	}

	/**
	 * 更新用户授权信息缓存.
	 */
	public void clearCachedAuthorizationInfo(String principal) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(principal, getName());
		clearCachedAuthorizationInfo(principals);
	}

	/**
	 * 清除所有用户授权信息缓存.
	 */
	public void clearAllCachedAuthorizationInfo() {
		Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
		if (cache != null) {
			for (Object key : cache.keys()) {
				cache.remove(key);
			}
		}
	}

}