package com.neuedu.lvcity.service.impl;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.neuedu.lvcity.common.DBUtils;
import com.neuedu.lvcity.dao.BanarDao;
import com.neuedu.lvcity.dao.impl.BanarDaoImpl;
import com.neuedu.lvcity.model.Banar;
import com.neuedu.lvcity.service.BanarService;

public class BanarServiceImpl implements BanarService{
	
	/**
	 * 类实例
	 */
	private static final BanarService instance = new BanarServiceImpl();

	/**
	 * 取得实例
	 * 
	 * @return 实例对象
	 */
	public static BanarService getInstance() {
		return instance;
	}

	/**
	 * 构造方法
	 */
	private BanarServiceImpl() {
	}

	@Override
	public int banarCount() {
		//声明数据库连接对象，用于保存数据库连接对象
		Connection conn = null;
		//声明变量，用于保存数据库查询结果
		int result = 0;
		try{
			//调用数据库工具类的getConnection方法，取得数据库连接对象，并赋值给数据库连接对象变量
			conn = DBUtils.getConnection();
			//创建userDao的实现类对象
			BanarDao banarDao = new BanarDaoImpl(conn);
			
			//调用dao中的banarCount方法，进行数据库查询操作，结果赋值给查询结果变量
			result = banarDao.banarCount();	
		
		} catch (Exception e) {
			System.out.println("查询统计所有banar错误"+e.getMessage());
		} finally {
			//调用数据库工具类的closeConnection方法，关闭连接
			DBUtils.closeConnection(conn);
		}
		//返回数据库查询结果
		return result;
	}

	@Override
	public List<Banar> findAllBanar(Map<String, Object> map) {
		// TODO Auto-generated method stub
				//声明数据库连接对象，用于保存数据库连接对象
						Connection conn = null;
						//声明变量，用于保存数据库查询结果
						List<Banar> banars = null;
						try{
							//调用数据库工具类的getConnection方法，取得数据库连接对象，并赋值给数据库连接对象变量
							conn = DBUtils.getConnection();
							//创建userDao的实现类对象
							BanarDao banarDao = new BanarDaoImpl(conn);
							//调用dao中的selectAll方法，进行数据库查询操作，结果赋值给查询结果变量
							banars = banarDao.findAllBanar(map);			
						
						} catch (Exception e) {
							System.out.println("查询所有banar错误"+e.getMessage());
						} finally {
							//调用数据库工具类的closeConnection方法，关闭连接
							DBUtils.closeConnection(conn);
						}
						//返回数据库查询结果
						return banars;
	}

	@Override
	public int addBanar(String imagePath) {
		//声明数据库连接对象，用于保存数据库连接对象
		Connection conn = null;
		//声明变量，用于保存数据库查询结果
		int result = 0;
		try{
			//调用数据库工具类的getConnection方法，取得数据库连接对象，并赋值给数据库连接对象变量
			conn = DBUtils.getConnection();
			DBUtils.beginTransaction(conn);
			//创建userDao的实现类对象
			BanarDao BanarDao = new BanarDaoImpl(conn);
			//调用dao中的selectAll方法，进行数据库查询操作，结果赋值给查询结果变量
			result = BanarDao.addBanar(imagePath);			
		    DBUtils.commit(conn);
		} catch (Exception e) {
			System.out.println("增加banar错误"+e.getMessage());
		} finally {
			//调用数据库工具类的closeConnection方法，关闭连接
			DBUtils.closeConnection(conn);
		}
		//返回数据库查询结果
		return result;
	}

	@Override
	public int updateBanar(Banar banar) {
		//声明数据库连接对象，用于保存数据库连接对象
				Connection conn = null;
				//声明变量，用于保存数据库查询结果
				int result = 0;
				try{
					//调用数据库工具类的getConnection方法，取得数据库连接对象，并赋值给数据库连接对象变量
					conn = DBUtils.getConnection();
					DBUtils.beginTransaction(conn);
					//创建userDao的实现类对象
					BanarDao BanarDao = new BanarDaoImpl(conn);
					//调用dao中的selectAll方法，进行数据库查询操作，结果赋值给查询结果变量
					result = BanarDao.updateBanar(banar);			
				    DBUtils.commit(conn);
				} catch (Exception e) {
					System.out.println("增加banar错误"+e.getMessage());
				} finally {
					//调用数据库工具类的closeConnection方法，关闭连接
					DBUtils.closeConnection(conn);
				}
				//返回数据库查询结果
				return result;
	}

	@Override
	public int deleteBanar(Banar banar) {
		//声明数据库连接对象，用于保存数据库连接对象
				Connection conn = null;
				//声明变量，用于保存数据库查询结果
				int result = 0;
				try{
					//调用数据库工具类的getConnection方法，取得数据库连接对象，并赋值给数据库连接对象变量
					conn = DBUtils.getConnection();
					DBUtils.beginTransaction(conn);
					//创建userDao的实现类对象
					BanarDao BanarDao = new BanarDaoImpl(conn);
					//调用dao中的selectAll方法，进行数据库查询操作，结果赋值给查询结果变量
					result = BanarDao.deleteBanar(banar);
				    DBUtils.commit(conn);
				} catch (Exception e) {
					System.out.println("删除banar错误"+e.getMessage());
				} finally {
					//调用数据库工具类的closeConnection方法，关闭连接
					DBUtils.closeConnection(conn);
				}
				//返回数据库查询结果
				return result;
	}

	@Override
	public Banar findOneBanar(Banar banar) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
