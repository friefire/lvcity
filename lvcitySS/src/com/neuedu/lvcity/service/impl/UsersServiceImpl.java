package com.neuedu.lvcity.service.impl;

import java.sql.Connection;

import org.apache.tomcat.jni.User;

import com.neuedu.lvcity.common.DBUtils;
import com.neuedu.lvcity.dao.UsersDao;
import com.neuedu.lvcity.dao.impl.UsersDaoImpl;
import com.neuedu.lvcity.model.Users;
import com.neuedu.lvcity.service.UsersService;


public class UsersServiceImpl implements UsersService {
	/**
	 * 构造方法私有化
	 */
	private UsersServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 创建一个唯一的实例
	 */
	private static UsersService Instance = new UsersServiceImpl();

	/**
	 * 提供一个对外访问的公共接口
	 * 
	 * @return
	 */
	public static UsersService getInstance() {
		return Instance;
	}

	public Users login(String username, String passwrod) {
		// TODO Auto-generated method stub
		// 返回结果
		Users users = null;
		// 声明连接
		Connection conn = null;
		try {
			// 获取数据库连接
			conn = DBUtils.getConnection();
			// 拿到dao层实现类的对象
			UsersDao usersDao = new UsersDaoImpl(conn);
			// 调用dao层的方法
			users = usersDao.login(username, passwrod);
		} catch (Exception exception) {
			System.out.println("登录查询用户是出现异常：" + exception.getMessage());
		} finally {
			DBUtils.closeConnection(conn);
		}
		return users;
	}

}
