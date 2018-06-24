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
#notice_fm {
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

	<table id="notice_dg" class="easyui-datagrid" style="height: 670px;"
		url="notice/findAllnotice.do" toolbar="#notice_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:15,pageList:[5,10,15,20]">
		<thead>
			<tr>
				<th field="nt" width="50">动态类型</th>
				<th field="nname" width="50">动态名称</th>
				<th field="releasetime" width="50">发布时间</th>
				<th field="articlename" width="50">文章名称</th>
			</tr>
		</thead>
	</table>
	
	<div id="notice_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newnotice()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editnotice()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroynotice()">删除</a>
	</div>

	<div id="notice_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#notice_dlg-buttons">
		<div class="ftitle" style="margin:auto;">详细信息</div>
		<!-- enctype="multipart/form-data" -->
		<form id="notice_fm" method="post" novalidate >
			
			<div class="fitem">
				<label>动态名称:</label><input name="nname" class="easyui-textbox"
					required="true">
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
			
			<div class="fitem" >
				<label>动态类型:</label>
				<select name="ntid" id="dt">	
				</select>
			</div>
			<div class="fitem">
				<label>文章名称:</label><input name="articlename" class="easyui-textbox"
					required="true">
			</div>
			<div class="fitem" id="wzlx2">
				<label>文章类型:</label>
				<select name="atid" id="wzlx3">	
				</select>
			</div>
			
			<div class="fitem">
				<label>文章内容:</label><textarea id="editor_id4"  name="content" style="width:500px;height:300px;"></textarea>
			</div>
			 
		</form>
	</div>
	
	<div id="notice_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="savenotice()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#notice_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		var editor2;
		 var req;
		function newnotice() {
			
			$('#notice_dlg').dialog('open').dialog('setTitle', '新增');
			$('#notice_fm').form('clear');
			getnoticetypelist();
			//addkind('textarea[name="content"]','');
			addkind('#editor_id4','');
			url = 'notice/addnoticeandarticle.do';
		}
		
		function editnotice() {
			document.getElementById('wzlx2').style.display = 'none';
			var row = $('#notice_dg').datagrid('getSelected');
			if (row) {
				$('#notice_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#notice_fm').form('load', row);
				url = 'notice/updatenoticeandarticle.do?nid=' + row.nid+'&aid='+row.aid;
			}
			getnoticetypelist();
			//updatekind('textarea[name="content"]',row.content);
			updatekind('#editor_id4',row.content);
			
		}
		
		
		function savenotice() {
			$('#notice_fm').form('submit', {
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
						$('#notice_dlg').dialog('close'); // close the dialog
						$('#notice_dg').datagrid('reload'); // reload the food data
					}
				}
			});
		}
		function destroynotice() {
			var row = $('#notice_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('notice/deleteNoticeandArticle.do?aid='+row.aid+"&", {
							nid : row.nid 
						}, function(result) {
							if (result.success) {
								$('#notice_dg').datagrid('reload'); // reload the food data
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
		  if(editor2!=null){
			  editor2.html(ctext);
		  }else{
			  editor2 = KindEditor.create(kedit,{
				 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
					fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
					allowFileManager : true,
					width: '99%',
					height: '420px',
					afterBlur: function () { editor2.sync();},
					allowImageUpload: true
			    });
		  
		  }
		  
		}
		
		function updatekind(kedit,ctext){
			 if(editor2!=null){
				  editor2.html(ctext);
			  }else{
				  editor2 = KindEditor.create(kedit,{
					 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
						fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
						allowFileManager : true,
						width: '99%',
						height: '420px',
						afterBlur: function () { editor2.sync(); },
						allowImageUpload: true
				    });
			  }
			  
			}

		 	 function getnoticetypelist(){
			      var url2 = "notice/gettypelist.do" ; 
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
		 	         var obj = document.getElementById('dt');
		 	       	 obj.innerHTML ="";
		 	      	 var nt = json[0];
		 	       	 for(var i=0;i<nt.length;i++){
		 	        	var ntname = nt[i]['nt'];
		 	        	var ntid = nt[i]['ntid'];
		 	        	obj.options.add(new Option(ntname,ntid));
		 	         }
		 	       	
		 	        var obj2 = document.getElementById('wzlx3');
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