<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JQuery easyui demo</title>

<style type="text/css">
#contact_fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

.fitem input {
	width: 160px;
}
</style>


<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/color.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/demo/demo.css">
<script type="text/javascript" src="jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
  

</head>


<body>

	<table id="contact_dg" class="easyui-datagrid" style="height: 670px;"
		url="contact/findAll.do" toolbar="#contact_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:5,pageList:[5,10,15,20]">
		<thead>
			<tr>
			<th field="contactname" width="50">联系人</th>
				<th field="address" width="50">联系地址</th>
				<th field="tel" width="50">电话</th>
				<th field="zipcode" width="50">邮编</th>
				<th field="qq" width="50">qq</th>
				<th field="web" width="50">网站地址</th>
				<th field="fax" width="50">传真编号</th>
			</tr>
		</thead>
	</table>
	<div id="contact_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newContact()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editContact()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyContact()">删除</a>
	</div>

	<div id="contact_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#contact_dlg-buttons">
		<div class="ftitle">详细信息</div>
		<form id="contact_fm" method="post" novalidate>
		<div class="fitem">
				<label>联系人:</label><br><input name="contactname" class="easyui-textbox" required="true">
			</div>
			<div class="fitem" >
				<label>联系地址:</label> <br><input name="address" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>电话:</label> <br><input name="tel" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>邮编:</label> <br><input name="zipcode" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>qq:</label> <br><input name="qq" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>网站地址:</label><br> <input name="web" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>传真编号:</label> <br><input name="fax" class="easyui-textbox">
			</div>
			<!--<div class="fitem">
				<label>网站地址:</label><textarea id="content" class="con" name="web" style="width:500px;height:300px;"></textarea>
			</div>
			<div class="fitem">
				<label>传真编号:</label><textarea id="content" class="con" name="fax" style="width:500px;height:300px;"></textarea>
			</div>
			  <div class="fitem">
				<label>图片:</label><input id="imgPicker" type="file" name="image" onchange="xmTanUploadImg(this)">
			</div>
			<div class="fitem" style="margin-top:10px;line-height:120px">
				<label>浏览图片:</label><img id="xmTanImg" width="300px" height="200px"/>
			</div>
			
			   <script type="text/javascript">            
            //判断浏览器是否支持FileReader接口
            if (typeof FileReader == 'undefined') {
                document.getElementById("xmTanDiv").InnerHTML = "<h1>当前浏览器不支持FileReader接口</h1>";
                //使选择控件不可操作
                document.getElementById("xdaTanFileImg").setAttribute("disabled", "disabled");
            }

            //选择图片，马上预览
            function xmTanUploadImg(obj) {
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

                reader.readAsDataURL(file)
            }
        </script>
		    -->
		</form>
	</div>
	
	<div id="contact_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveContact()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#contact_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		var editor;
		function newContact() {
			$('#contact_dlg').dialog('open').dialog('setTitle', '新增');
			$('#contact_fm').form('clear');
			url = 'contact/addcontact.do';
			addkind('textarea[name="webSite"]','');
		}
		
		function editContact() {
			var row = $('#contact_dg').datagrid('getSelected');
			if (row) {
				$('#contact_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#contact_fm').form('load', row);
				url = 'contact/updatecontact.do?contactid=' + row.contactid;
			}
			updatekind('textarea[name="webSite"]',row.webSite);
		}
		
		
		function saveContact() {
			$('#contact_fm').form('submit', {
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
						$('#contact_dlg').dialog('close'); // close the dialog
						$('#contact_dg').datagrid('reload'); // reload the contact data
					}
				}
			});
		}
		function destroyContact() {
			var row = $('#contact_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('contact/deletecontact.do', {
							contactid : row.contactid
						}, function(result) {
							if (result.success) {
								$('#contact_dg').datagrid('reload'); // reload the contact data
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
		  if(editor!=null){
			  editor.html(ctext);
		  }else{
			  editor = KindEditor.create(kedit,{
				 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
					fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
					allowFileManager : true,
					width: '99%',
					height: '420px',
					afterBlur: function () { editor.sync();},
					allowImageUpload: true
			    });
		  
		  }
		  
		}
		
		function updatekind(kedit,ctext){
			 if(editor!=null){
				  editor.html(ctext);
			  }else{
				  editor = KindEditor.create(kedit,{
					 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
						fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
						allowFileManager : true,
						width: '99%',
						height: '420px',
						afterBlur: function () { editor.sync('.con'); },
						allowImageUpload: true
				    });
			  }
			  
			}
		
	</script>

</body>
</html>