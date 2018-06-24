package com.neuedu.lvcity.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * ���ݿ⹤����
 */
public class DBUtils {

	/**
	 * ��ȡ���ݿ�����
	 */
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql:///lvcity";
			String user = "root";
			String password ="123";
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new ServiceException("Can not get connection", e);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			throw new ServiceException("Can not get connection", e);
		}
		
		/*	         1.����jdbc����
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//2.��������url
		String url = "jdbc:oracle:thin:@localhost:1521:neuedu";
		//3.��ȡ���ݿ�����    
		Connection conn = DriverManager.getConnection(url,"scott","tiger");*/
		
		/*try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context
					.lookup("java:comp/env/jdbc/lvcity");
			conn = ds.getConnection();
			System.out.println("connect sucess!");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			throw new ServiceException("Can not get connection", e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new ServiceException("Can not get connection", e);
		}
*/
		return conn;
	}

	/**
	 * ��������
	 * 
	 * @param conn
	 */
	public static void beginTransaction(Connection conn) {
		try {
			conn.setAutoCommit(false);
		} catch (SQLException e) {
			throw new ServiceException("Can not begin transaction", e);
		}
	}

	/**
	 * �ύ����
	 * 
	 * @param conn
	 */
	public static void commit(Connection conn) {
		try {
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			throw new ServiceException("Can not commit transaction", e);
		}
	}

	/**
	 * �ع�����
	 * 
	 * @param conn
	 */
	public static void rollback(Connection conn) {
		try {
			conn.rollback();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			throw new ServiceException("Can not rollback transaction", e);
		}
	}

	/**
	 * �ر�����
	 * 
	 * @param conn
	 */
	public static void closeConnection(Connection conn) {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			throw new ServiceException("Can not close connection", e);
		}
	}

	/**
	 * �ر�statement
	 * 
	 * @param stmt
	 */
	public static void closeStatement(ResultSet rs, Statement stmt) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException e) {
			throw new ServiceException("Can not close statement", e);
		}
	}
}
