$(function(){
	$("#tip_box").hide();
    $('#file-zh').fileinput({
        language: 'zh',
        showPreview:false,
        showUpload: false,
        uploadUrl: '#',
        allowedFileExtensions: ['xls', 'xlsx']
    });
});

function btn_query_onclick(){
	var zkzh = $("#zkzh").val();
	var params = {};
	params.zkzh = zkzh;
	var res = jQueryAjax("/query", params,"POST");
	if (res.rtnCode = "2000" && res.data != null) {
		loadData(res);
	} else {
		$("#tip_box").show();
		cleanData();
		window.setTimeout(function(){
			 $("#tip_box").hide();
		},2000);
	}
}

function btn_export_onclick(){
	var dcmm = $("#dcmm").val();
	var time = getNowFormatDate();
	if(dcmm!=time){
		alert("密码错误！");
		return;
	}
	$('#exModal').modal('hide');
	$("#dcmm").val('');
	window.location.href="/export";
	//jQueryAjax("/export", null,"GET");
}


function btn_save_onclick(){
	var params = {};
	var zkzh = $("#newzkzh").val();
	var sjhm = $("#sjhm").val();
	var xczgsczt = $("#xczgsczt").val();
	var scr = $("#scr").val();
	var qtbz = $("#qtbz").val();
	if(!zkzh){
		alert("没有需要保存的数据！");
		return;
	}
	if(sjhm==''||sjhm==null){
		alert("手机号码不能为空！");
		return;
	}
	if(xczgsczt==''){
		alert("请选择现场复审结果！");
		return;
	}
	if(scr==''||scr==null){
		alert("请输入审查人员姓名！");
		return;
	}
	if(xczgsczt=='未通过'&&trim(qtbz)==''){
		alert("未通过时备注信息不能为空！");
		return;
	}
	params.zkzh = zkzh;
	params.sjhm = sjhm;
	params.xczgsczt = xczgsczt;
	params.scr = scr;
	params.qtbz = qtbz;
	var res = jQueryAjax("/save", params,"POST");
	btn_cancle_onclick();
	alert(res.rtnMsg);
}

function btn_cancle_onclick(){
	$("#zkzh").val('');
	cleanData();
}
function cleanData(){
	$("#newzkzh").val('');
	$("#oldsjhm").val('');
	$("#sfzh").text('');
	$("#ksxm").text('');
	$("#xb").text('');
	$("#zy").text('');
	$("#xl").text('');
	$("#xw").text('');
	$("#byyx").text('');
	$("#kssf").text('');
	$("#sjhm").val('');
	$("#zlsxh").text('');
	$("#bkyrsj").text('');
	$("#bkyrsj").text('');
	$("#bkzwdm").text('');
	$("#bkzwmc").text('');
	$("#zwyqzy").text('');
	$("#zwyqxl").text('');
	$("#zwyqxw").text('');
	$("#dxzw").text('');
	$("#zwyqdqttj").text('');
	$("#xczgsczt").val('');
	$("#scr").val('');
	$("#qtbz").val('');
}

function loadData(res){
	var data = res.data;
	$("#newzkzh").val(data.zkzh);
	$("#oldsjhm").val(data.sjhm);
	$("#sfzh").text(data.sfzh);
	$("#ksxm").text(data.ksxm);
	$("#xb").text(data.xb);
	$("#zy").text(data.zy);
	$("#xl").text(data.xl);
	$("#xw").text(data.xw);
	$("#byyx").text(data.byyx);
	$("#kssf").text(data.kssf);
	var sjhm = data.sjhm;
	if (sjhm.indexOf("$") == 0) {
		sjhm = sjhm.substr(1);
	}
	$("#sjhm").val(sjhm);
	$("#zlsxh").text(data.zlsxh);
	$("#bkyrsj").text(data.bkyrsj);
	$("#bkyrsj").text(data.bkyrsj);
	$("#bkzwdm").text(data.bkzwdm);
	$("#bkzwmc").text(data.bkzwmc);
	$("#zwyqzy").text(data.zwyqzy);
	$("#zwyqxl").text(data.zwyqxl);
	$("#zwyqxw").text(data.zwyqxw);
	$("#dxzw").text(data.dxzw);
	if(data.zwyqdqttj){
		$("#zwyqdqttj").text(trim(data.zwyqdqttj));
	}else{
		$("#zwyqdqttj").text('');
	}
	$("#xczgsczt").val(data.xczgsczt);
	if(data.scr){
		$("#scr").val(data.scr);
	}else{
		$("#scr").val('');
	}
	if(data.qtbz){
		$("#qtbz").val(data.qtbz);
	}else{
		$("#qtbz").val('');
	}
}
function btn_import_onclick(){
	$('#fileForm').form('submit', {
	    url:"/import",
		headers: {
			  'Content-Type':'application/json'
		},
	    async: false,
	    dataType : "json",
	    onSubmit: function(){
	    	var str=$("#file-zh").val();
	    	if(typeof (str) == "undefined" || str == "" || str == null){
	    		alert("请选择要导入的Excle文件！");
	    		return false;
	    	}
	    	var pos = str.lastIndexOf(".") + 1;
	    	var lastname = str.substring(pos,str.length);
	    	if(lastname!="xls"&&lastname!="xlsx"){
	    		alert("请选择xls,xlsx格式的文件");
	    		return false;
	    	}
	    },
	    success:function(data){
	    	var res = JSON.parse(data); 
	    	//var res = data;
	    	alert(res.rtnMsg);
	    	if(res.rtnCode="2000"){
	    		$('#myModal').modal('hide');
	    	}
	    },
	    error:function(XMLHttpRequest, textStatus, errorThrown){
			$.messager.alert("提示", "文件上传失败，请稍候再试……");
			return;
	    }
	});
} 


function jQueryAjax(url, params,method) {
	var res = "";
	var paramJson = "";
	if (params) {
		paramJson = JSON.stringify(params);
	}
	$.ajax({
		url : url,
		headers: {
			  'Content-Type':'application/json'
		},
		data : paramJson,
		async : false,
		type : method,
		dataType : "json",
		success : function(result) {
			try {
				res = result;
			} catch (e) {
				
			}
		}
	});
	return res;
}

function getNowFormatDate() {
    var date = new Date();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    var minutes = date.getMinutes();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    if(minutes>= 1 && minutes <= 9){
    	minutes = "0" + minutes;
    }
    var currentdate = date.getHours() + '' + minutes;
    return currentdate;
} 

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}