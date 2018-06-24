<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
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


<style type="text/css">
#article_fm {
	margin: 0;
	padding: 10px 30px;
}
</style>
</head>
<body>
	<table id="article_dg" class="easyui-datagrid" style="height: 470px;"
		url="article/findAllArticle.do" toolbar="#article_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:5,pageList:[5,10,15,20]">
		<thead>
			<tr>
				<th field="aid" width="50">编号</th>
				<th field="atid" width="50">类别</th>
				<th field="publisher" width="50">发布人</th>
				<th field="releasetime" width="50">发布时间</th>
				<th field="articlename" width="50">标题</th>
				<th field="content" width="50">内容</th>
				<th field="image" width="50">图片</th>
			</tr>
		</thead>
	</table>
	<div id="article_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newArticle()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editArticle()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="deleteArticle()">删除</a>
	</div>
	
	<div id="article_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#article_dlg-buttons">
		<form id="article_fm" method="post" novalidate enctype="multipart/form-data">
			<div class="fitem">
				<label>标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题:</label> <input name="articlename" class="easyui-textbox"
					required="true">
			</div><br/>
			<div class="fitem">
				<label>上传图片:</label><input name="imgwj" id="imgPicker" type="file"  onchange="valueChange(this)" >
			</div><br/>
			<div class="fitem" id="imageShow" style="margin-top:10px; display: none;">
				<label>浏览图片:</label><br/><img id="xmTanImg" width="200px" height="150px" src=""/>
			</div><br/>
			<div class="fitem">
				<label>文章内容:</label><br/><textarea id="editor_id5"  name="content" style="width:500px;height:300px;"></textarea>
			</div><br/>
		</form>
	
		<div id="article_dlg-buttons" style=" float: right;">
			<a href="javascript:void(0)" class="easyui-linkbutton c6"
				iconCls="icon-ok" onclick="saveArticle()" style="width: 90px; ">保存</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel"
				onclick="javascript:$('#article_dlg').dialog('close')"
				style="width: 90px;">取消</a>
		</div>
	</div>
	<script type="text/javascript">
		var url, editor6, reqArticle;
		function newArticle() {
			$('#article_dlg').dialog('open').dialog('setTitle', '新增');
			$('#article_fm').form('clear');
			addkind('#editor_id5','');
			url = 'article/addArticle.do';
		}
		function editArticle() {
			var row = $('#article_dg').datagrid('getSelected');
			if (row) {
				$('#article_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#article_fm').form('load', row);
				url = 'article/updateArticle.do?aid=' + row.aid;
			}
			updatekind('#editor_id5',row.content);
		}
		
		function saveArticle() {
			$('#article_fm').form('submit', {
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
						$('#article_dlg').dialog('close'); // close the dialog
						$('#article_dg').datagrid('reload'); // reload the article data
					}
				}
			});
		}
		function deleteArticle() {
			var row = $('#article_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('article/deleteArticle.do', {
							aid : row.aid
						}, function(result) {
							if (result.success) {
								$('#article_dg').datagrid('reload'); // reload the article data
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
		
		function addkind(kedit,ctext){
			  if(editor6!=null){
				  editor6.html(ctext);
			  }else{
				  editor6 = KindEditor.create(kedit,{
					 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
						fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
						allowFileManager : true,
						width: '99%',
						height: '420px',
						afterBlur: function () { editor6.sync();},
						allowImageUpload: true
				    }); 
			  
			  }
			  
			}
			
			function updatekind(kedit,ctext){
				 if(editor6!=null){
					 editor6.html(ctext);
				  }else{
					  editor6 = KindEditor.create(kedit,{
						 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
							fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
							allowFileManager : true,
							width: '99%',
							height: '420px',
							afterBlur: function () { editor6.sync(); },
							allowImageUpload: true
					    });
				  }
				  
				}
			
			function valueChange(obj) {
				var file = obj.files[0];
                
                console.log(obj);console.log(file);
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
			   document.getElementById('imageShow').style.display = 'block';
               imageinput.value = imagepath;
               
			}
	</script>
</body>
</html>