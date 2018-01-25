<!DOCTYPE html>
<html>
<head>
	<title>四川国税现场资格复审查询记录系统</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <!-- 引入 Bootstrap -->
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/css/easyui.css">
    <link href="/static/fileinput/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
	<link href="/static/fileinput/themes/explorer/theme.css" media="all" rel="stylesheet" type="text/css"/>
	<link rel="icon" type="image/x-icon" href="/static/images/favicon.ico">
      <!-- HTML5 Shim 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
      <!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
      <!--[if lt IE 9]>
         <script src="/static/js/html5shiv.js"></script>
         <script src="/static/js/respond.min.js"></script>
      <![endif]-->
	  <link href="/static/css/main.css" rel="stylesheet">
   </head>
   <body>
	<div class="container">
	  <input type="hidden" id="newzkzh" value=""/>
	  <div id="tip_box" class="alert alert-warning">
		<a href="#" class="close" data-dismiss="alert">&times;</a>
		<strong>警告！</strong>未查询到结果请检查准考证号是否正确。
	  </div>
	  <div class="content">
	      <table class="table table-bordered">
	      	<tr>
	      		<td colspan="7"><h3 class="title">四川国税现场资格复审查询记录系统</h3></td>
	      	</tr>
	      	<tr>
	      		<td colspan="1" class="td_lable">准考证号</td>
	      		<td colspan="4"><input type="text" class="form-control form-input" id="zkzh" name="zkzh" placeholder="请输入准考证号后点击查询"></td>
	      		<td colspan="2"><button type="button" class="btn btn-primary" onclick="btn_query_onclick();">查询</button></td>
	      	</tr>
	      	<tr>
	      		<td class="td_lable">身份证号</td>
	      		<td class="td_lable">姓名</td>
	      		<td class="td_lable">性别</td>
	      		<td class="td_lable">专业</td>
	      		<td class="td_lable">学历</td>
	      		<td class="td_lable">学位</td>
	      		<td class="td_lable">毕业院校</td>
	      	</tr>
	      	<tr>
	      		<td id="sfzh"></td>
	      		<td id="ksxm"></td>
	      		<td id="xb"></td>
	      		<td id="zy"></td>
	      		<td id="xl"></td>
	      		<td id="xw"></td>
	      		<td id="byyx"></td>
	      	</tr>
	      	<tr>
	      		<td class="td_lable">考生身份</td>
	      		<td class="td_lable">手机号码</td>
	      		<td class="td_lable">资料顺序号</td>
	      		<td class="td_lable lable_waring">报考用人司局</td>
	      		<td class="td_lable lable_waring">职位代码</td>
	      		<td class="td_lable lable_waring" colspan="2">职位名称</td>
	      	</tr>
	      	<tr>
	      		<td id="kssf"></td>
	      		<td><input type="text" class="form-control form-input" id="sjhm" name="sjhm" placeholder="请输入手机号码"></td>
	      		<td id="zlsxh"></td>
	      		<td id="bkyrsj" class="lable_waring"></td>
	      		<td id="bkzwdm" class="lable_waring"></td>
	      		<td colspan="2" id="bkzwmc" class="lable_waring"></td>
	      	</tr>
	      	<tr>
	      		<td class="td_lable lable_waring" colspan="2">职位要求的专业</td>
	      		<td class="td_lable lable_waring">职位要求的学历</td>
	      		<td class="td_lable lable_waring">职位要求的学位</td>
	      		<td class="td_lable lable_waring">定向职位</td>
	      		<td class="td_lable lable_waring" colspan="2">职位要求的其他条件</td>
	      	</tr>
	      	<tr>
	      		<td colspan="2" id="zwyqzy" class="lable_waring"></td>
	      		<td id="zwyqxl" class="lable_waring"></td>
	      		<td id="zwyqxw" class="lable_waring"></td>
	      		<td id="dxzw" class="lable_waring"></td>
	      		<td colspan="2" id="zwyqdqttj" class="lable_waring"></td>
	      	</tr>
	      	<tr>
	      		<td class="td_lable">现场资格复审记录</td>
	      		<td>
					<select id="xczgsczt">
						<option value="">---请选择---</option>
						<option value="合格">合格</option>
						<option value="现场放弃">现场放弃</option>
						<option value="未通过">未通过</option>
					</select>
				</td>
	      		<td class="td_lable">审查人</td>
	      		<td><input type="text" class="form-control form-input" id="scr" name="scr" placeholder="请输入审查人"></td>
	      		<td class="td_lable">其他备注</td>
	      		<td colspan="2"><input type="text" class="form-control form-input" id="qtbz" name="qtbz" placeholder="备注"></td>
	      	</tr>
	      </table>
      </div>
      <div class="button-group">
      	<button type="button" class="btn btn-success" onclick="btn_save_onclick();">保存</button>
      	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exModal">导出</button>
      	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal">导入</button>
      	<button type="button" class="btn btn-warning" onclick="btn_cancle_onclick();">取消</button>
      </div>
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							请选择要导入的Excle文件<br><span id="waring">请谨慎操作导入数据会覆盖已存在的所有数据！</span>
						</h4>
					</div>
					<div class="modal-body">
						<form id="fileForm" enctype="multipart/form-data" method="post">
							<input id="file-zh" name="file" data-show-upload="false" 
							data-show-preview="false" data-show-remove="false" type="file" class="file"
							accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
						</form>
					</div>
					<div class="modal-footer">
						<input class="btn btn-success" type="submit" onclick="btn_import_onclick();" value="确定">
						<button type="button" class="btn btn-warning" data-dismiss="modal">取消
						</button>
					</div>
				</div>
			</div>
		</div>
      	<div class="modal fade" id="exModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							导出密码：
						</h4>
					</div>
					<div class="modal-body">
						<input type="password" class="form-control" id="dcmm" name="dcmm" placeholder="请输入导出密码">
					</div>
					<div class="modal-footer">
						<input class="btn btn-success" type="button" onclick="btn_export_onclick();" value="确定">
						<button type="button" class="btn btn-warning" data-dismiss="modal">取消
						</button>
					</div>
				</div>
			</div>
		</div>
    </div>
   </body>
   <script src="/static/js/jquery.js"></script>
   <script src="/static/js/jquery.easyui.min.js"></script>
   <script src="/static/fileinput/js/plugins/sortable.js" type="text/javascript"></script>
   <script src="/static/fileinput/js/fileinput.js" type="text/javascript"></script>
   <script src="/static/fileinput/js/locales/zh.js" type="text/javascript"></script>
   <script src="/static/fileinput/themes/explorer/theme.js" type="text/javascript"></script>
   <script src="/static/js/bootstrap.min.js"></script>
   <script src="/static/js/index.js"></script>
</html>

