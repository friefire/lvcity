package com.neuedu.lvcity.dao.impl;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.neuedu.lvcity.common.DBUtils;
import com.neuedu.lvcity.dao.BanarDao;
import com.neuedu.lvcity.model.Banar;



public class BanarDaoImpl implements BanarDao {
		
		/**
		 * 数据库连接
		 */
		private Connection conn;
	
		/**
		 * 构造方法
		 * 
		 * @param conn
		 *            数据库连接
		 */
		public BanarDaoImpl(Connection conn) {
			this.conn = conn;
		}

	@Override
	public int banarCount() {
		//声明变量，用于保存查询结果
		int result = 0;
		//声明预编译的声明对象变量，用于进行数据库操作的载体
		PreparedStatement pstam = null;
		//声明结果集对象变量，用于保存数据库查询结果
		ResultSet rs = null;
		try {
			//调用连接对象的prepareStatement方法，得到预编译对象，赋值给预编译对象变量
			pstam = conn.prepareStatement("select count(*) from banar");
			//调用预编译对象的executeQuery方法，执行查询操作，返回查询结果，赋值给结果集对象变量
			rs = pstam.executeQuery();
			
			//如果查询结果不为空，将取出结果集统计的数据
			if(rs.next()){
				result = rs.getInt("count(*)");
							}	
		}catch (SQLException e) {
			//如果出现异常，输出异常信息
			System.out.println("在查询统计banar的时候出错了.错误信息是 ：" + e.getMessage());			
		} finally {
			//调用数据库工具类，关闭结果集对象和声明对象
			DBUtils.closeStatement(rs, pstam);
		}
	    //返回查询到的用户列表
		return result;
	}

	@Override
	public List<Banar> findAllBanar(Map<String, Object> map) {
		// TODO Auto-generated method stub
				//声明变量，用于保存查询结果
				List<Banar> list = new ArrayList<Banar>();
				//声明预编译的声明对象变量，用于进行数据库操作的载体
				PreparedStatement pstam = null;
				//声明结果集对象变量，用于保存数据库查询结果
				ResultSet rs = null;
				int startPage = (int) map.get("startPage");
				int endPage = (int) map.get("endPage");
				
				try {
					//调用连接对象的prepareStatement方法，得到预编译对象，赋值给预编译对象变量
					pstam = conn.prepareStatement("select * from banar limit ?,?");
					//调用预编译对象的executeQuery方法，执行查询操作，返回查询结果，赋值给结果集对象变量
					pstam.setInt(1, startPage);
					pstam.setInt(2, endPage);
					rs = pstam.executeQuery();
					//如果查询结果不为空，将取出结果集中的各个字段，封装在用户对象的各个属性中，所有对象放到集合中
					while(rs.next()){
					//创建用户对象，用于封装当前游标中的各个字段的值
					Banar banar = new Banar();
					banar.setBanarid(rs.getInt("banarid"));
					banar.setImage(rs.getString("image"));
					banar.setState(rs.getInt("state"));
								
					//声明结果集对象变量，用于保存数据库查询结果
					list.add(banar);
					}	
				}catch (SQLException e) {
					//如果出现异常，输出异常信息
					System.out.println("在查询全部banar的时候出错了.错误信息是 ：" + e.getMessage());			
				} finally {
					//调用数据库工具类，关闭结果集对象和声明对象
					DBUtils.closeStatement(rs, pstam);
				}
			    //返回查询到的用户列表
				return list;
	}

	@Override
	public int addBanar(String imagePath) {
		//声明变量，用于保存查询结果
		int result = 0;
		//声明预编译的声明对象变量，用于进行数据库操作的载体
		PreparedStatement pstam = null;				
		try {
			//调用连接对象的prepareStatement方法，得到预编译对象，赋值给预编译对象变量
			pstam = conn.prepareStatement("insert into banar(image) values(?)");
			pstam.setString(1, imagePath);
			
			//调用预编译对象的executeQuery方法，执行查询操作，返回查询结果，赋值给结果集对象变量
			result = pstam.executeUpdate();
			//如果查询结果不为空，将取出结果集中的各个字段，封装在用户对象的各个属性中，所有对象放到集合中
				
		}catch (SQLException e) {
			//如果出现异常，输出异常信息
			System.out.println("增加banar出错.错误信息是 ：" + e.getMessage());			
		} finally {
			//调用数据库工具类，关闭结果集对象和声明对象
			DBUtils.closeStatement(null, pstam);
		}
	    //返回查询到的用户列表
		return result;
	}

	@Override
	public int updateBanar(Banar banar) {
		//声明变量，用于保存查询结果
		int result = 0;
		//声明预编译的声明对象变量，用于进行数据库操作的载体
		PreparedStatement pstam = null;				
		try {
			//调用连接对象的prepareStatement方法，得到预编译对象，赋值给预编译对象变量
			pstam = conn.prepareStatement("update banar set image=? where banarid= ?");
			pstam.setString(1,banar.getImage());
			pstam.setInt(2,banar.getBanarid());
			//调用预编译对象的executeQuery方法，执行查询操作，返回查询结果，赋值给结果集对象变量
			result = pstam.executeUpdate();
			//如果查询结果不为空，将取出结果集中的各个字段，封装在用户对象的各个属性中，所有对象放到集合中
				
		}catch (SQLException e) {
			//如果出现异常，输出异常信息
			System.out.println("增加banar出错.错误信息是 ：" + e.getMessage());			
		} finally {
			//调用数据库工具类，关闭结果集对象和声明对象
			DBUtils.closeStatement(null, pstam);
		}
	    //返回查询到的用户列表
		return result;
	}

	@Override
	public int deleteBanar(Banar banar) {
		// TODO Auto-generated method stub
		//声明变量，用于保存查询结果
				int result = 0;
				//声明预编译的声明对象变量，用于进行数据库操作的载体
				PreparedStatement pstam = null;				
				try {
					//调用连接对象的prepareStatement方法，得到预编译对象，赋值给预编译对象变量
					pstam = conn.prepareStatement("DELETE FROM banar WHERE banarid =?");
					pstam.setInt(1, banar.getBanarid());
					
					//调用预编译对象的executeQuery方法，
					result = pstam.executeUpdate();
					//如果查询结果不为空，将取出结果集中的各个字段，封装在用户对象的各个属性中，所有对象放到集合中
						
				}catch (SQLException e) {
					//如果出现异常，输出异常信息
					System.out.println("删除banar出错.错误信息是 ：" + e.getMessage());			
				} finally {
					//调用数据库工具类，关闭结果集对象和声明对象
					DBUtils.closeStatement(null, pstam);
				}
			    //返回查询到的用户列表
				return result;
		
		
	}

	@Override
	public Banar findOneBanar(Banar banar) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
