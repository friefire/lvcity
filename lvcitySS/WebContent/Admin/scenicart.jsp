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
#scenicart_fm {
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

	<table id="scenicart_dg" class="easyui-datagrid" style="height: 670px;"
		url="scenicart/findAllscenic.do" toolbar="#scenicart_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:15,pageList:[5,10,15,20]">
		<thead>
			<tr>
				<th field="st" width="50">景点类型</th>
				<th field="sname" width="50">景点名称</th>
				<th field="lx" width="50">类型</th>
				<th field="releasetime" width="50">发布时间</th>
				<th field="articlename" width="50">文章名称</th>
				<th field="image" width="50">图片路径</th>
			</tr>
		</thead>
	</table>
	
	<div id="scenicart_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newscenic()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editscenic()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyscenic()">删除</a>
	</div>

	<div id="scenicart_dlg" class="easyui-dialog" style="padding: 10px 20px" margin-top:50px;
		closed="true" buttons="#scenicart_dlg-buttons">
		<div class="ftitle" style="margin:auto;">详细信息</div>
		<!-- enctype="multipart/form-data" -->
		<form id="scenicart_fm" method="post" novalidate enctype="multipart/form-data">
			
			<div class="fitem">
				<label>景点名称:</label><input name="sname" class="easyui-textbox"
					required="true">
			</div>
			  <br>
			<div class="fitem">
				<label>上传图片:</label><input name="imgwj" id="imgPicker1" type="file"  onchange="xmTanUploadImg(this)">
			</div>
			<div class="fitem" style="display:none">
				<label>图片路径:</label><input class="easyui-textbox" name="image" >
			</div>
			<div class="fitem" style="margin-top:10px;">
				<label>浏览图片:</label><img id="xmTanImg1" width="200px" height="150px" src=""/>
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
							
		                    var img = document.getElementById("xmTanImg1");
		                    img.src = e.target.result;
		                    //或者 img.src = this.result;  //e.target == this
		                }
		
		                reader.readAsDataURL(file);
			               var imagepath = document.getElementById('imgPicker1').value;
			               var imageinput = document.getElementsByName('image');
			               imageinput.value = imagepath;
		            }
		        </script>
			 <br>
			<div class="fitem" >
				<label>景点类型:</label>
				<select name="stid" id="jdlx" style="width:120px;">	
				</select>
			</div>
			 <br>
			<div class="fitem" >
				<label>类型分类:</label>
				<select  id="lx" style="width:120px;">
				<option value="旅游" selected="selected">旅游</option>	
				<option value="景点">景点</option>
				</select>
			</div>
			 <br>
			<div class="fitem">
				<label>文章名称:</label><input name="articlename" class="easyui-textbox"
					required="true">
			</div>
			 <br>
			<div class="fitem" id="wzlx22">
				<label>文章类型:</label>
				<select name="atid" id="wzlx1" style="width:120px;">	
				</select>
			</div>
			 <br>
			<div class="fitem">
				<label>文章内容:</label><textarea id="editor_id2"  name="content" style="width:500px;height:300px;"></textarea>
			</div>
			 
		</form>
	</div>
	
	<div id="scenicart_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="savescenic()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#scenicart_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		var editor22;
		 var req;
		function newscenic() {
			document.getElementById('wzlx22').style.display = 'block';
			document.getElementById('xmTanImg1').src='';
			var a=document.getElementById('lx').value;
			$('#scenicart_dlg').dialog('open').dialog('setTitle', '新增');
			$('#scenicart_fm').form('clear');
			getfoodtypelist();
			//addkind('textarea[name="content"]','');
			addkind('#editor_id2','');
			url = 'scenicart/addfoodandarticle.do?';
		}
		
		function editscenic() {
			document.getElementById('wzlx22').style.display = 'none';
			var a=document.getElementById('lx').value;
			var row = $('#scenicart_dg').datagrid('getSelected');
			if (row) {
				$('#scenicart_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#scenicart_fm').form('load', row);
				url = 'scenicart/updatefoodandarticle.do?sid=' + row.sid+'&aid='+row.aid+'&';
				document.getElementById('xmTanImg1').src = row.image;
			}
			getfoodtypelist();
			//updatekind('textarea[name="content"]',row.content);
			updatekind('#editor_id2',row.content);
		}
		
		
		function savescenic() {
			var a=document.getElementById('lx').value;
			url=url+'lx='+a;
			$('#scenicart_fm').form('submit', {
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
						$('#scenicart_dlg').dialog('close'); // close the dialog
						$('#scenicart_dg').datagrid('reload'); // reload the scenicart data
					}
				}
			});
		}
		function destroyscenic() {
			var row = $('#scenicart_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('scenicart/deleteFoodandArticle.do?aid='+row.aid+"&", {
							sid : row.sid 
						}, function(result) {
							if (result.success) {
								$('#scenicart_dg').datagrid('reload'); // reload the scenicart data
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
		  if(editor22!=null){
			  editor22.html(ctext);
		  }else{
			  editor22 = KindEditor.create(kedit,{
				 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
					fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
					allowFileManager : true,
					width: '99%',
					height: '350px',
					afterBlur: function () { editor22.sync();},
					allowImageUpload: true
			    });
		  
		  }
		  
		}
		
		function updatekind(kedit,ctext){
			 if(editor22!=null){
				 editor22.html(ctext);
			  }else{
				  editor22 = KindEditor.create(kedit,{
					 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
						fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
						allowFileManager : true,
						width: '99%',
						height: '350px',
						afterBlur: function () { editor22.sync(); },
						allowImageUpload: true
				    });
			  }
			  
			}

		 	 function getfoodtypelist(){
			      var url2 = "scenicart/gettypelist.do" ; 
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
		 	         var obj = document.getElementById('jdlx');
		 	       	 obj.innerHTML ="";
		 	      	 var st = json[0];
		 	       	 for(var i=0;i<st.length;i++){
		 	        	var stname = st[i]['st'];
		 	        	var stid = st[i]['stid'];
		 	        	obj.options.add(new Option(stname,stid));
		 	         }
		 	       	
		 	        var obj2 = document.getElementById('wzlx1');
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