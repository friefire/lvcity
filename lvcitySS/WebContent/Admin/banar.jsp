<%@ page language="java"  import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/color.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/demo/demo.css">
<link rel="stylesheet" type="text/css"
	href="css/chaildPage.css">
<script type="text/javascript" src="jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
	
</head>
<body class="easyui-layout" data-options="fit:true">
 <div data-options="fit:true" style="height:500px">
  <!--  <% out.print(basePath); %>
  <%  HttpSession se = request.getSession();
      List banarList = (List)se.getAttribute("banarList"); %>-->
      
       <!-- 显示数据记录的banar_dg ，使用easyui的easyui-datagrid-->
	<table id="banar_dg" class="easyui-datagrid" style="height: 670px;"
		url="Admin/Banar?action=findAllBanar" toolbar="#banar_toolbar" pagination="true" 
		rownumbers="true" fitColumns="true" singleSelect="true" 
		data-options="fit:true,border:false,pageSize:20,pageList:[5,10,15,20]">
		<thead>
			<tr>
				<th field="banarid" width="50">编号</th>
				<th field="image" width="50">图片</th>
				<th field="state" width="50">状态</th>
			</tr>			
		</thead>	
<%-- 		<c:if test="${!empty banarList }">
				<c:forEach items="${banarList}" var="banar">
					<tr>
						<td>${banar.banarid }</td>
						<td>${banar.image }</td>	
						<td>${banar.state }</td>	
					</tr>				
				</c:forEach>
			</c:if>	 --%>
	</table>
</div>
 <!-- 工具栏banar_toolba，使用easyui的easyui-linkbutton -->
	<div id="banar_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="addBanar()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editBanar()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyBanar()">删除</a>
	</div>
	<!-- 点新增按钮打开的上传图片的对话框banar_dlg，使用easyui的easyui-dialog -->
	<div id="banar_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#contact_dlg-buttons">
		<form id="banar_fm" method="post" novalidate enctype="multipart/form-data">
			  
			  <div class="fitem">
				<label>上传图片:</label><input name="imgwj" id="imgPicker" type="file"  onchange="xmTanUploadImg(this)">
			</div>
			  <div class="fitem" style="display:none">
				<label>图片路径:</label><input  class="easyui-textbox"  name="image">
			</div>
			<div class="fitem" style="margin-top:10px;line-height:120px">
				<label>浏览图片:</label><br/><img id="xmTanImg" width="300px" height="200px"/>
			</div>
			
		    <script type="text/javascript">            
	          
	            //选择图片，马上预览
	            function xmTanUploadImg(obj) {
	                var file = obj.files[0];
	                
	                console.log(obj);
	                console.log(file);
	                console.log("file.size = " + file.size);  //file.size 单位为byte
	
	                var reader = new FileReader();
	
	                //读取文件过程方法
	                reader.onloadstart = function (e) {
	                    console.log("开始读取....");
	                }
	                reader.onprogress = function (e) {
	                    console.log("正在读取中....");
	                }
	                reader.onabort = function (e) {
	                    console.log("中断读取....");
	                }
	                reader.onerror = function (e) {
	                    console.log("读取异常....");
	                }
	                reader.onload = function (e) {
	                    console.log("成功读取....");
	
	                    var img = document.getElementById("xmTanImg");
	                    img.src = e.target.result;
	                    //或者 img.src = this.result;  //e.target == this
	                }
	
	               reader.readAsDataURL(file);
	               var imagepath = document.getElementById('imgPicker').value;
	               var imageinput = document.getElementsByName('image');
	               imageinput.value = imagepath;
	               
	            }
        	 </script>
		</form>
		<div id="banar_dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton c6"
				iconCls="icon-ok" onclick="saveBanar()" style="width: 90px">保存</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel" onclick="javascript:$('#banar_dlg').dialog('close')"
				style="width: 90px; float: right;">取消</a>
		</div>
	</div>
	
	<script type="text/javascript">
		var url;
		function addBanar() {
			document.getElementById('xmTanImg').src = '';
			$('#banar_dlg').dialog('open').dialog('setTitle', '新增');
			$('#banar_fm').form('clear');
			url = 'Admin/Banar?action=addBanar';
		}
		function editBanar() {
			var imageinput = document.getElementsByName('image');
            imageinput.value ='';
			var row = $('#banar_dg').datagrid('getSelected');
			document.getElementById('xmTanImg').src = row.image;
			if (row) {
				$('#banar_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#banar_fm').form('load', row);
				url = 'Admin/Banar?action=updateBanar&?banarid=' + row.banarid;
			}
		}
		function saveBanar() {
			$('#banar_fm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.errorMsg) {
						$.messager.show({
							title : 'Error',
							msg : result.errorMsg
						});
					} else {
						$('#banar_dlg').dialog('close'); // close the dialog
						$('#banar_dg').datagrid('reload'); // reload the banar data
					}
				}
			});
		}
		function destroyBanar() {
			var row = $('#banar_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('Admin/Banar?action=delBanar', {
							banarid : row.banarid
						}, function(result) {
							if (result.success) {
								//$('#banar_dg').datagrid('clearSelections');
								$('#banar_dg').datagrid('reload'); // reload the banar data								
							} else {
								$.messager.show({ // show error message
									title : 'Error',
									msg : result.errorMsg
								});
							}
						}, 'json');
					}
				});
			}
		}
	</script>
</body>
</html>