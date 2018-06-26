package com.neuedu.lvcity.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.alibaba.fastjson.JSONObject;
import com.neuedu.lvcity.common.FileUtils;
import com.neuedu.lvcity.model.Banar;
import com.neuedu.lvcity.service.BanarService;
import com.neuedu.lvcity.service.impl.BanarServiceImpl;

@WebServlet("/Admin/Banar")
public class BanarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BanarServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String action = request.getParameter("action");
		if ("findAllBanar".equals(action)) {
			dofindAllBanar(request, response);
		} else if ("addBanar".equals(action)) {
			doAddBanar(request, response);
		} else if ("delBanar".equals(action)) {
			doDelBanar(request, response);
		}else if("updateBanar".equals(action)){
			doUpdateBanar(request, response);
		}
	}
	private void doUpdateBanar(HttpServletRequest request, HttpServletResponse response) {
		// 获取session
				HttpSession se = request.getSession();
				int banarid = /*Integer.parseInt(request.getParameter("banarid"))*/12;
				Banar ba=new Banar();
				ba.setBanarid(banarid);
				System.out.println(banarid);
				// 调用Service方法
				BanarService banarService = BanarServiceImpl.getInstance();

				// 上传文件的目录
				//	 String path = request.getSession().getServletContext().getRealPath("/")+"images";    //文件系统的路径
		        // String path= System.getProperty("catalina.home") + "\\webapps\\lvcityFG\\images\\";    //tomcat下面的路径
		       				
				//创建文件对象
				File savePath = new File(FileUtils.UPLOAD_PATH);	
				
				// 检查我们是否有文件上传请求
				//boolean isMultipart = ServletFileUpload.isMultipartContent(request);
				
				// 1,声明DiskFileItemFactory工厂类，用于在指定磁盘上设置一个临时目录
				DiskFileItemFactory disk = new DiskFileItemFactory(1024 * 10, savePath);
			
				// 2,声明ServletFileUpload，接收上边的临时文件。也可以默认值
				ServletFileUpload up = new ServletFileUpload(disk);		

				try {
					// 3,解析request
					List<FileItem> list;
					list = up.parseRequest(request);
					// 如果就一个文件，
					FileItem file = list.get(0);
					// 获取文件名：
					String fileName = file.getName();
					
					// 获取文件的类型：
					//String fileType = file.getContentType();
					// 文件大小
			     	//	int size = file.getInputStream().available();
					
					// 获取文件的输入流，用于读取要上传的文件
					InputStream in = file.getInputStream();
					
					// 声明输出字节流，用于将文件上传到目的位置
					OutputStream out = new FileOutputStream(new File(savePath + "/" + fileName));
				
					
					// 文件copy
					byte[] b = new byte[1024];
					int len = 0;
					while ((len = in.read(b)) != -1) {
						out.write(b, 0, len);
						//out2.write(b, 0, len);
					}
					out.flush();
					out.close();
				

					// 删除上传生成的临时文件
					file.delete();
					ba.setImage("http://localhost:9080/uploads/"+fileName);
					//网数据库添加记录，在前面加上图片服务器的前缀			
					int result = banarService.updateBanar(ba);
					
					//生成返回结果的map
					Map<String, Object> map = new HashMap<String, Object>();
					if (result > 0) {
						map.put("success", true);
					} else {
						map.put("success", false);
						map.put("errorMsg", "Save user fail !");
					}
		           //将map转成JSON对象
					String str = JSONObject.toJSONString(map);
					//返回结果
					response.getWriter().write(str);

				} catch (FileUploadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

	}

	private void doDelBanar(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 调用Service方法
		BanarService banarService = BanarServiceImpl.getInstance();
		int banarid = Integer.parseInt(request.getParameter("banarid"));
		Banar banar = new Banar();
		banar.setBanarid(banarid);
		int res = banarService.deleteBanar(banar);
		System.out.println(res);
		Map<String, Object> map = new HashMap<String, Object>();
		if (res > 0) {
			map.put("success", true);
		} else {
			map.put("success", false);
			map.put("errorMsg", "delete contact fail !!!");
		}

		String str = JSONObject.toJSONString(map);
		response.getWriter().write(str);

	}

	@SuppressWarnings("unchecked")
	private void doAddBanar(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 获取session
		HttpSession se = request.getSession();
		// 调用Service方法
		BanarService banarService = BanarServiceImpl.getInstance();

		// 上传文件的目录
		//	 String path = request.getSession().getServletContext().getRealPath("/")+"images";    //文件系统的路径
        // String path= System.getProperty("catalina.home") + "\\webapps\\lvcityFG\\images\\";    //tomcat下面的路径
       				
		//创建文件对象
		File savePath = new File(FileUtils.UPLOAD_PATH);	
		
		// 检查我们是否有文件上传请求
		//boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		
		// 1,声明DiskFileItemFactory工厂类，用于在指定磁盘上设置一个临时目录
		DiskFileItemFactory disk = new DiskFileItemFactory(1024 * 10, savePath);
	
		// 2,声明ServletFileUpload，接收上边的临时文件。也可以默认值
		ServletFileUpload up = new ServletFileUpload(disk);		

		try {
			// 3,解析request
			List<FileItem> list;
			list = up.parseRequest(request);
			// 如果就一个文件，
			FileItem file = list.get(0);
			// 获取文件名：
			String fileName = file.getName();
			
			// 获取文件的类型：
			//String fileType = file.getContentType();
			// 文件大小
	     	//	int size = file.getInputStream().available();
			
			// 获取文件的输入流，用于读取要上传的文件
			InputStream in = file.getInputStream();
			
			// 声明输出字节流，用于将文件上传到目的位置
			OutputStream out = new FileOutputStream(new File(savePath + "/" + fileName));
		
			
			// 文件copy
			byte[] b = new byte[1024];
			int len = 0;
			while ((len = in.read(b)) != -1) {
				out.write(b, 0, len);
				//out2.write(b, 0, len);
			}
			out.flush();
			out.close();
		

			// 删除上传生成的临时文件
			file.delete();
			
			//网数据库添加记录，在前面加上图片服务器的前缀			
			int result = banarService.addBanar("http://localhost:9080/uploads/" + fileName);
			
			//生成返回结果的map
			Map<String, Object> map = new HashMap<String, Object>();
			if (result > 0) {
				map.put("success", true);
			} else {
				map.put("success", false);
				map.put("errorMsg", "Save user fail !");
			}
           //将map转成JSON对象
			String str = JSONObject.toJSONString(map);
			//返回结果
			response.getWriter().write(str);

		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void dofindAllBanar(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// page：页码，起始值 1。 rows：每页显示行。 page为前台要查询的页，rows为前台的每页记录数
		int rows = Integer.parseInt(request.getParameter("rows"));
		// System.out.println(rows);
		int page = Integer.parseInt(request.getParameter("page"));

		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("startPage", (page - 1) * rows);
		pageMap.put("endPage", rows);

		// 调用Service方法
		BanarService banarService = BanarServiceImpl.getInstance();
		//查找指定页的记录
		List<Banar> list = banarService.findAllBanar(pageMap);
		// System.out.println(list.size());
		//查找总记录数
		int total = banarService.banarCount();

		// JSON中，total记录总数，rows记录。total为后台返回的（数据库的）总记录数，（第二个）rows为后台返回的json对象数组。
		map.put("rows", list);
		map.put("total", total);
		String str = JSONObject.toJSONString(map);
		// System.out.println(map.toString());
		response.getWriter().write(str);

		/*
		 * //获取session HttpSession se = request.getSession(); // 调用Service方法
		 * BanarService banarService = BanarServiceImpl.getInstance();
		 * List<Banar> banars = null; // 查询所有用户 banars =
		 * banarService.findAllBanar(); if(banars != null) { //
		 * System.out.println(banars.size()); se.setAttribute("banarList",
		 * banars); response.sendRedirect(request.getContextPath() +
		 * "/Admin/banar.jsp");
		 * 
		 * }
		 */
	}

}
