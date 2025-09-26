<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .product-image {
    width: 200px;
    height: 200px;
    object-fit: cover; /* This is optional but highly recommended! */
  }
</style>


<script>
  let product_detail ={
    init: function (){
      $('#update_btn').click(()=>{
        let c = confirm("해당고객의 정보를 수정할까요?")
        if(c == true){
          // 1. form의 전송 방식을 'post'로 설정합니다.
          $('#cust_update_form').attr('method', 'post');
          // 2. form의 목적지(action)를 설정합니다.
          $('#cust_update_form').attr('action','<c:url value="/cust/updatecust"/>');
          // 3. form을 전송(submit)합니다.
          $("#cust_update_form").submit();
        }
      });
      $("#delete_btn").click(()=>{
        let c = confirm("해당 고객의 정보를 삭제할까요?")
        if(c == true){
          location.href='<c:url value="/cust/custdelete?id=${cust.custId}"/>';
        }
      });

    }
  }
  $().ready(()=>{
    product_detail.init();
  });

</script>


<!-- Begin Page Content -->
<div class="container-fluid">

  <!-- Page Heading -->
  <div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Cust Detail Page</h1>
  </div>


  <!-- Content Row -->

  <div class="row">

    <!-- Area Chart -->
    <div class="col-xl-10 col-lg-7">
      <div class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div
                class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-primary">Cust Detail</h6>
        </div>
        <!-- Card Body -->
        <div class="card-body">
          <form id="cust_update_form">
            <div class="form-group">
              <label for="id">Id:</label>
              <input type="text" readonly value="${cust.custId}" name="custId" class="form-control" placeholder="Enter id" id="id">
            </div>
            <div class="form-group">
              <label for="pwd">Password:</label>
              <button id="cust_pwd_btn" class="btn btn-primary">result</button>
            </div>
             <div class="form-group">
              <label for="name">Name:</label>
              <input type="text" value="${cust.custName}" name="custName"  class="form-control" placeholder="Enter name" id="name">
            </div>
            <div class="form-group">
              <label for="addr">Addr:</label>
              <input type="text" value="${cust.custAddr}" name="custAddr"  class="form-control" placeholder="Enter Address" id="addr">
            </div>
          </form>
          <button id="update_btn" class="btn btn-primary">Update</button>
          <button id="delete_btn" class="btn btn-primary">delete</button>

        </div>
      </div>
    </div>
  </div>


</div>
