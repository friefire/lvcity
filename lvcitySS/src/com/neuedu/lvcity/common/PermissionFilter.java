package com.neuedu.lvcity.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class PermissionFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		String url = req.getRequestURI();
		/*User user = (User)req.getSession().getAttribute("user");*/

		// 1. ·���к���Admin/�����session��û��loginUser�����Ȩ�޲��ǹ���Ա
		// 2. ·���к���User/�� ���session��û��loginUser�����Ȩ�޲�����ͨ�û�
		/*if (url.indexOf("Admin/") != -1
				&& (user == null || !"1".equals(user.getRule()))
				|| url.indexOf("User/") != -1
				&& (user == null || !"2".equals(user.getRule()))) {
			req.getSession().removeAttribute("user");
			req.getSession().invalidate();
			resp.sendRedirect(req.getContextPath() + "/Login.jsp");
			return;
		}*/

		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
