<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.neuedu.*" %>
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
#food_fm {
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
  
  <script type="text/javascript" charset="utf-8" src="kindeditor/kindeditor.js"></script> 
<script src="kindeditor/lang/zh_CN.js" type="text/javascript"></script>
<link href="kindeditor/plugins/code/prettify.css" rel="stylesheet" type="text/css" />
<script src="kindeditor/plugins/code/prettify.js" type="text/javascript"></script>

</head>


<body>

	<table id="food_dg" class="easyui-datagrid" style="height: 670px;"
		url="food/findAllfood.do" toolbar="#food_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:15,pageList:[5,10,15,20]">
		<thead>
			<tr>
				<th field="ft" width="50">美食类型</th>
				<th field="fname" width="50">美食名称</th>
				<th field="releasetime" width="50">发布时间</th>
				<th field="articlename" width="50">文章名称</th>
				<th field="image" width="50">图片路径</th>
			</tr>
		</thead>
	</table>
	
	<div id="food_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newfood()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editfood()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyfood()">删除</a>
	</div>

	<div id="food_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#food_dlg-buttons">
		<div class="ftitle" style="margin:auto;">详细信息</div>
		<!-- enctype="multipart/form-data" -->
		<form id="food_fm" method="post" novalidate enctype="multipart/form-data">
			
			<div class="fitem">
				<label>美食名称:</label><input name="fname" class="easyui-textbox"
					required="true">
			</div>
			 <div class="fitem">
				<label>上传图片:</label><input name="imgwj" id="imgPicker" type="file"  onchange="xmTanUploadImg(this)">
			</div>
			<div class="fitem" style="display:none">
				<label>图片路径:</label><input class="easyui-textbox" name="image" >
			</div>
			<div class="fitem" style="margin-top:10px;">
				<label>浏览图片:</label><img id="xmTanImg" width="200px" height="150px" src=""/>
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
		
		                reader.readAsDataURL(file);
		               var imagepath = document.getElementById('imgPicker').value;
		               var imageinput = document.getElementsByName('image');
		               imageinput.value = imagepath;
		            }
		        </script>
			
			<div class="fitem" >
				<label>美食类型:</label>
				<select name="ftid" id="mslx">	
				</select>
			</div>
			<div class="fitem">
				<label>文章名称:</label><input name="articlename" class="easyui-textbox"
					required="true">
			</div>
			<div class="fitem" id="wzlx2">
				<label>文章类型:</label>
				<select name="atid" id="wzlx">	
				</select>
			</div>
			
			<div class="fitem">
				<label>文章内容:</label><textarea id="editor_id"  name="content" style="width:500px;height:300px;"></textarea>
			</div>
			 
		</form>
	</div>
	
	<div id="food_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="savefood()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#food_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		var editor;
		 var req;
		function newfood() {
			document.getElementById('wzlx2').style.display = 'block';
			document.getElementById('xmTanImg').src='';
			$('#food_dlg').dialog('open').dialog('setTitle', '新增');
			$('#food_fm').form('clear');
			getfoodtypelist();
			//addkind('textarea[name="content"]','');
			addkind('#editor_id','');
			url = 'food/addfoodandarticle.do';
		}
		
		function editfood() {
			document.getElementById('wzlx2').style.display = 'none';
			var row = $('#food_dg').datagrid('getSelected');
			if (row) {
				$('#food_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#food_fm').form('load', row);
				url = 'food/updatefoodandarticle.do?fid=' + row.fid+'&aid='+row.aid;
				document.getElementById('xmTanImg').src = row.image;
			}
			getfoodtypelist();
			updatekind('#editor_id',row.content);
		}
		
		
		function savefood() {
			$('#food_fm').form('submit', {
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
						$('#food_dlg').dialog('close'); // close the dialog
						$('#food_dg').datagrid('reload'); // reload the food data
					}
				}
			});
		}
		function destroyfood() {
			var row = $('#food_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('food/deleteFoodandArticle.do?aid='+row.aid+"&", {
							fid : row.fid 
						}, function(result) {
							if (result.success) {
								$('#food_dg').datagrid('reload'); // reload the food data
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
						afterBlur: function () { editor.sync(); },
						allowImageUpload: true
				    });
			  }
			  
			}

		 	 function getfoodtypelist(){
			      var url2 = "food/gettypelist.do" ; 
			      if(window.XMLHttpRequest) {  
			          req = new XMLHttpRequest();  
			      }else if(window.ActiveXObject) {  
			          req = new ActiveXObject("Microsoft.XMLHTTP");  
			      }  
			      req.open("POST", url2, true);  
			      req.onreadystatechange = callback;  
			      req.send(null); 
			  }
			

		 	function callback() {  
		 	      if(req.readyState == 4 && req.status == 200) {  
		 	         var check = req.responseText;  
		 	         var json = eval("("+check+")");
		 	         var obj = document.getElementById('mslx');
		 	       	 obj.innerHTML ="";
		 	      	 var ft = json[0];
		 	       	 for(var i=0;i<ft.length;i++){
		 	        	var ftname = ft[i]['ft'];
		 	        	var ftid = ft[i]['ftid'];
		 	        	obj.options.add(new Option(ftname,ftid));
		 	         }
		 	       	
		 	        var obj2 = document.getElementById('wzlx');
		 	       	 obj2.innerHTML ="";
		 	         var at = json[1];
		 	       	 for(var j=0;j<at.length;j++){
		 	        	var atype = at[j]['atype'];
		 	        	var atid = at[j]['atid'];
		 	        	obj2.options.add(new Option(atype,atid));
		 	         }
		 	      }  
		 	  } 

		
	</script>

</body>
</html>