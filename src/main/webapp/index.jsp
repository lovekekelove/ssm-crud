
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("app_path",request.getContextPath());
%>
<html>
<head>
    <title>Employee List</title>
    <!--引入jqury-->
    <script type="text/javascript" src="${app_path}/static/js/jquery-1.12.4.min.js"></script>
    <!-- 引入Bootstrap -->
    <script src="${app_path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="${app_path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">UPDATE EMPLOYEE</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">EMPNAME</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">EMAIL</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update" placeholder="123@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">GENDER</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update" value="M" checked> MAN
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update" value="F"> WOMAN
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">DEPTNAME</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">UPDATE</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">ADD EMPLOYEE</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">EMPNAME</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add" placeholder="empname">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">EMAIL</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="123@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">GENDER</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add" value="M" checked> MAN
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add" value="F"> WOMAN
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">DEPTNAME</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>员工信息</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-success" id="addEmp_modal_btn">新增</button>
            <button class="btn btn-danger" id="delEmp_modal_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr class="danger">
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>EMID</th>
                        <th>EMPNAME</th>
                        <th>GENDER</th>
                        <th>EMAIL</th>
                        <th>DEPTNAME</th>
                        <th>OPERATION</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info">

        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="age_nav">

        </div>

    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentNum;
    $(function () {
        to_page(1);
    });
    //分页
    function to_page(pn) {
        $.ajax({
            url:"${app_path}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                //console.log(result)
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_(result);
                //3.//显示分页条
                build_page_nav(result);
            }
        });
    }
    //显示员工列表
    function build_emps_table(result) {
        //先清空table表格
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
        var checkTd=$("<th ><input type='checkbox' class='check_item'/></th>");
        var empTd=$("<th ></th>").append(item.empId);
        var empNameTd=$("<th ></th>").append(item.empName);
        var genderTd=$("<th ></th>").append(item.gender == 'M'? "男":"女");
        var emailTd=$("<th ></th>").append(item.email);
        var deptNameTd=$("<th></th>").append(item.department.deptName);
        var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
            .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
            .append("编辑");
            //为编辑按钮添加一个自定义属性，来表示员工的ID
            editBtn.attr("edit_id",item.empId);
        var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn")
            .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
            .append("删除");
            //为删除按钮添加一个自定义属性，来表示员工的ID
            delBtn.attr("del_id",item.empId);
        var btnTd=$("<th ></th>").append(editBtn).append(" ").append(delBtn);
        //append()方法执行完以后还会返回原来的元素
        $("<tr></tr>").append(checkTd)
            .append(empTd)
            .append(empNameTd)
            .append(genderTd)
            .append(emailTd)
            .append(deptNameTd)
            .append(btnTd)
            .appendTo("#emps_table tbody");
        });
    }

    //显示分页信息
    function build_page_(result) {
        //清空
        $("#page_info").empty();
         $("#page_info").append($("<h4></h4>").append("当前第<mark>"+result.extend.pageInfo.pageNum+"</mark>页，" +
             "总共<mark>"+result.extend.pageInfo.pages+"</mark>页，" +
             "总共<mark>"+result.extend.pageInfo.total+"</mark>记录"));
        totalRecord=result.extend.pageInfo.total;
        currentNum=result.extend.pageInfo.pageNum;
    }
    //显示分页条
    function build_page_nav(result) {
           //清空
          $("#age_nav").empty();

          var ul=$("<ul></ul>").addClass("pagination");
          var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
          var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));

          if(result.extend.pageInfo.hasPreviousPage == false){
              prePageLi.addClass("disabled");
              firstPageLi.addClass("disabled");
          }else{
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
          }

          ul.append(firstPageLi).append(prePageLi);

          $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
              var numPageLi=$("<li></li>").append($("<a></a>").append(item));
              if(result.extend.pageInfo.pageNum == item){
                   numPageLi.addClass("active");
              }
              numPageLi.click(function(){
                  to_page(item);
              });
              ul.append(numPageLi);
          });

          var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
          var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        if(result.extend.pageInfo.hasNextPage == false){
              nextPageLi.addClass("disabled");
              lastPageLi.addClass("disabled");
          }else{
              nextPageLi.click(function () {
                  to_page(result.extend.pageInfo.pageNum+1);
              });
              lastPageLi.click(function () {
                  to_page(result.extend.pageInfo.pages);
              });
          }

          ul.append(nextPageLi).append(lastPageLi);
         var nvaEle=$("<nva></nva>").append(ul);
         nvaEle.appendTo("#age_nav");
    }

    //弹出模态框
    $("#addEmp_modal_btn").click(function(){
        //清除表单数据和样式
        reset_form("#empAdd form");
       //先查出部门信息
        getDepts("#empAdd select");
        //弹出模态框
      $("#empAdd").modal({
            backdrop:"static"
        });
    });

    //清除表单数据和样式
    function reset_form(ele) {
        $(ele)[0].reset();
        //清除表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    //获取部门下拉框
    function getDepts(ele) {
        //清除表单数据和样式
        $(ele).empty();
        $.ajax({
            url:"${app_path}/depts",
            type:"GET",
            success:function (result) {
                //{"code":100,"msg":"处理成功","extend":{"depts":[{"deptId":1,"deptName":"开发部"}
                // ,{"deptId":2,"deptName":"测试部"}]}}
                //显示部门信息在下拉框
               // $("empAdd select");
                $.each(result.extend.depts,function () {
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据
    function validate_add_form() {
      //1.拿到校验的数据，使用正则表达式
       var empName= $("#empName_add").val();
       var regName= /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户名可以是2-5位中文或者5-16位英文和数字的组合")
            //应该清空这个元素之前的样式
            show_validate_msg("#empName_add","error","用户名可以是2-5位中文或者5-16位英文和数字的组合");
            return false;
        }else{
            show_validate_msg("#empName_add","success","");
        }

        //校验email
        var empEmail=$("#email_add").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(empEmail)){
            //alert("邮箱格式不正确")
            show_validate_msg("#email_add","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add","success","");
        }
        return true;
    }

    function show_validate_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text(" ");
        if("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#empName_add").change(function () {
         //发送ajax请求校验用户名是否有用
         var empName=this.value;
         $.ajax({
             url:"${app_path}/checkUser",
             data:"empName="+empName,
             type:"POST",
             success:function (result) {
                 if(result.code == 100){
                     show_validate_msg("#empName_add","success","用户名可用");
                      $("#emp_save_btn").attr("ajax_va","success");
                 }else{
                     show_validate_msg("#empName_add","error",result.extend.va_msg);
                     $("#emp_save_btn").attr("ajax_va","error");
                 }
             }
         });
     });
    //员工保存
    $("#emp_save_btn").click(function () {
        //1.先给提交给服务器的数据进行校验
       if(!validate_add_form()){
           return false;
       }
       if($(this).attr("ajax_va") == "error"){
           return false;
       }
        //2.发送ajax请求保存员工
        $.ajax({
            url:"${app_path}/emp",
            type:"POST",
            data: $("#empAdd form").serialize(),//序列化保存的数据
            success:function (result) {
                //员工保存成功
                if(result.code == 100) {
                    //1.关闭模态框
                    $('#empAdd').modal('hide')
                    //2.来到最后一页，显示保存的数据
                    //发送ajax请求
                    to_page(totalRecord);
                }else{
//                    console.log(result);
                    if(undefined != result.extend.errorFileds.email){
                       //显示邮箱的错误信息
                        show_validate_msg("#email_add","error",result.extend.errorFileds.email);
                    }

                    if(undefined != result.extend.errorFileds.empName){
                        //显示员工的错误信息
                        show_validate_msg("#empName_add","error",result.extend.errorFileds.empNamel);
                    }
                }
            }
        });
    });

    //============================编辑========================
    //我们时按钮创建之前就绑定了click,所以就绑定不上
    //jquery新版本没有live,使用on进行绑定
    $(document).on("click",".edit_btn",function () {

        //1.显示部门信息
        getDepts("#empUpdate select");
        //2.显示员工信息
        getEmp($(this).attr("edit_id"));
        //把员工的id给更新按钮
        $("#emp_update_btn").attr("emp_id",$(this).attr("edit_id"));
        //3.弹出模态框
        $("#empUpdate").modal({
            backdrop:"static"
        });
    });

    //查询员工信息
    function getEmp(id) {
        $.ajax({
            url:"${app_path}/emp/"+id,
            type:"GET",
            success:function (result) {
               //{"code":100,"msg":"处理成功","extend":{"emp":{"empId":2,"empName":"252b",
                // "gender":"M","email":"252b@qq.com","dId":1,"department":null}}}
              var empData=result.extend.emp;
              $("#empName_static").text(empData.empName);
              $("#email_update").val(empData.email);
              $("#empUpdate input[name=gender]").val([empData.gender]);
              $("#empUpdate select").val([empData.dId])
            }
        })
    }
    //======================================更新===============
    $("#emp_update_btn").click(function () {
        //验证邮箱
        var empEmail=$("#email_update").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(empEmail)){
            show_validate_msg("#email_update","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_update","success","");
        }
        //发送AJAX请求保存员工信息
        $.ajax({
            url:"${app_path}/emp/"+$(this).attr("emp_id"),
            type:"PUT",
            data:$("#empUpdate form").serialize(),
            success:function (result) {
               //1.关闭模态框
                $('#empUpdate').modal('hide')
               // 2.回到原来的页面
                to_page(currentNum);
            }
        })
    })
    //=============================================删除=====================
    $(document).on("click",".del_btn",function () {
         //1.弹出是否删除确认框
        var empName=$(this).parents("tr").find("th:eq(2)").text();
        var empId=$(this).attr("del_id");
        if(confirm("确认删除用户  "+empName+" 吗？")){
             //确认，发送ajax请求删除
             $.ajax({
                 url:"${app_path}/emp/"+empId,
                 type:"DELETE",
                 success:function (result) {
                     alert(result.msg);
                     // 2.回到原来的页面
                     to_page(currentNum);
                 }
             });
        }
    });
    //===============================删除多个===========================
    //1.多选框的全选和全不选
    $("#check_all").click(function () {
        //attr获取checked时undefind;
        //我们这些dom原生的属性用prop；
        //attr用获取自定义属性的值
        //$(this).prop("checked")：指的是点击之后是true还是false
       $(".check_item").prop("checked",$(this).prop("checked"));
    });
   //check_item
    $(document).on("click",".check_item",function () {
        //判断当前选择的元素是不是五个
       var flag= $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    //===================================批量删除======
    $("#delEmp_modal_btn").click(function () {
        var empNames="";
        var del_ids="";
        $.each($(".check_item:checked"),function () {
            del_ids +=$(this).parents("tr").find("th:eq(1)").text()+"-";
            empNames +=$(this).parents("tr").find("th:eq(2)").text()+",";
        });
        empNames=empNames.substring(0,empNames.length-1);
        del_ids=del_ids.substring(0,del_ids.length-1);
        if(confirm("确认删除用户"+empNames+"吗？")){
               $.ajax({
                  url:"${app_path}/emp/"+del_ids,
                   type:"DELETE",
                   success:function (result) {
                       alert(result.msg);
                       // 2.回到原来的页面
                       to_page(currentNum);
                   }
               });
            }
    });
</script>
</body>
</html>

