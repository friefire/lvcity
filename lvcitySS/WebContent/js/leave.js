	var zf = new Array ('0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
	
	window.onload = function(){
   
		var yzm="";	
		 for(var i = 0; i < 5 ; i ++) {
         var id = Math.ceil(Math.random()*35);
         yzm += zf[id];
     	}
		document.getElementById('yzm').innerHTML = yzm;
		document.getElementById('yzm2').value = yzm;
	}
	
	function shuaxin(){
		var yzm="";	
		 for(var i = 0; i < 5 ; i ++) {
         	var id = Math.ceil(Math.random()*35);
         	yzm += zf[id];
     	}
		document.getElementById('yzm').innerHTML = yzm;
		document.getElementById('yzm2').value = yzm;
		document.getElementById('check').value = "";
	}
	
	
	
	function login(){
		var loginname = document.getElementById('loginname').value;
		var passwd = document.getElementById('password').value;
		var check = document.getElementById('check').value;
		var yzm = document.getElementById('yzm').innerHTML;
		
		if(check == yzm){
			location.href="servlet/LoginServlet?loginname="+loginname+"&password="+passwd;
		}else{
			alert('验证码不正确！');
			shuaxin();
			document.getElementById('check').value = "";
		}
	}
	function wjmm(){
		
		document.getElementById('loginname').value = "";
		document.getElementById('password').value = "";
		document.getElementById('check').value = "";
		
		 var yzm="";	
		 for(var i = 0; i < 5 ; i ++) {
         	var id = Math.ceil(Math.random()*35);
         	yzm += zf[id];
     	 }
		 document.getElementById('yzm').innerHTML = yzm;
	}
	
	
	
	