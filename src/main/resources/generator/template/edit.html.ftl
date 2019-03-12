<!DOCTYPE HTML>
<html  xmlns:th="http://www.thymeleaf.org">
<head th:include="_meta :: header">
<title>编辑</title>
</head>
<body>
<article class="page-container">
	<form class="form form-horizontal"  id="form-${table.name}-edit" action="#" th:action="@{/admin/test/edit}" th:object="${r"$"}{${table.name}}">
    <input type="hidden" name="id" th:value="${r"$"}{${table.name}.id}"/>
    <#list table.fields as field >
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>${field.comment}：</label>
        <div class="formControls col-xs-5 col-sm-5">
            <#if field.type == 'datetime'>
                     <input type="input-text" class="input-text Wdate" onfocus="WdatePicker({el:$dp.$('startupDate'),dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"
                            autocomplete="off" th:value="${r"$"}{#temporals.format(${table.name}.${field.propertyName}, 'yyyy-MM-dd HH:mm:ss')}" name="${field.propertyName}" placeholder="请选择${field.comment}"/>
            <#else>
                    <input type="text" class="input-text"  th:field="*{${field.propertyName}}" name="${field.propertyName}" id="${field.propertyName}"/>
            </#if>
        </div>
    </div>
    </#list>
	<div class="row cl">
	<div class="col-xs-3 col-sm-3 col-xs-offset-4 col-sm-offset-3">
		<input class="btn btn-primary radius" id="subbtn" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;"/>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn radius" id="reset" type="reset" value="&nbsp;&nbsp;重置&nbsp;&nbsp;"/>
	</div>
	</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去--> 
<div th:replace="_footer :: footerjs"></div>
 <!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script>
 $(function(){
	$("#form-${table.name}-edit").validate({
		rules:{
			 <#list table.fields as field >
                 ${field.propertyName}:{
                 required:true,
             },
             </#list>
		},
		onkeyup:false,
		debug: true,
		success:"valid",
		submitHandler:function(form){
				$(form).ajaxSubmit({
				type: 'POST',
				url: "/admin/${table.name}/edit" ,
				success: function(data){
					if(data.code == "0"){
						layer.designMsg('编辑成功!',1,function(){
							var index = parent.layer.getFrameIndex(window.name);
							parent.location.reload();
							parent.layer.close(index); 
						});
					}else{
						layer.designMsg('编辑失败!');
					}
				},
                error: function(){
					layer.designMsg('编辑异常!',5);
				}
			});
		}
	});
}); 

</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>