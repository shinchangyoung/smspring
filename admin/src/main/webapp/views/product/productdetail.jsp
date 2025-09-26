<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
      $('#product_update_btn').click(()=>{
        let c = confirm("수정할까요?")
        if(c == true){
          $("#product_update_form").attr('enctype','multipart/form-data');
          $("#product_update_form").attr('method','post');
          $('#product_update_form').attr('action','<c:url value="/product/updateimpl"/>');
          $("#product_update_form").submit();
        }
        alert("상품수정 완료!");

      });
      $("#product_delete_btn").click(()=>{
        //let c = confirm("삭제할까요?")
        //if(c == true){
          location.href='<c:url value="/product/delete?id=${p.productId}"/>';
       // }
        alert("상품삭제 완료!");
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
    <h1 class="h3 mb-0 text-gray-800">Product Detail Page</h1>
  </div>


  <!-- Content Row -->

  <div class="row">

    <!-- Area Chart -->
    <div class="col-xl-10 col-lg-7">
      <div class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div
                class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-primary">Product Detail</h6>
        </div>
        <!-- Card Body -->
        <div class="card-body">
          <form id="product_update_form">
            <img src="/imgs/${p.productImg}">

            <div class="form-group">
              <label for="id">Id:</label>
              <p id="id">${p.productId}</p>
              <input type="hidden" name="productId" value="${p.productId}">
              <%--이미지를 입력 안했을 경우 null이 되면 안되니까 넣어줌 --%>
              <input type="hidden" name="productImg" value="${p.productImg}">
            </div>
            <div class="form-group">
              <label for="name">Name:</label>
              <input type="text" class="form-control" value="${p.productName}"  id="name" name="productName">
            </div>
            <div class="form-group">
              <label for="price">Price:</label>
              <input type="number" class="form-control" value="${p.productPrice}" id="price" name="productPrice">
            </div>
            <div class="form-group">
              <label for="rate">Discount Rate:</label>
              <input type="text" class="form-control" value="${p.discountRate}" id="rate" name="discountRate">
            </div>
            <div class="form-group">
              <label for="pimg">Product Image:</label>
              <input type="file" class="form-control" placeholder="Enter image name" id="pimg" name="productImgFile">
            </div>
            <div class="form-group">
              <label for="cate">Cate Id:</label>
<%--              <input type="number" class="form-control"  value="${p.cateId}" id="cate" name="cateId">--%>
              <select class="form-control" name="cateId" id="cate">
                <c:forEach items="${cate}" var="ca">
                  <%-- 상품의 카테고리(p.cateId)와 현재 옵션의 카테고리(ca.cateId)가 같으면 selected 속성을 추가합니다. --%>
                  <option value="${ca.cateId}" <c:if test="${p.cateId == ca.cateId}">selected</c:if>>${ca.cateName}</option>
                </c:forEach>
              </select>
            </div>
            <div class="form-group">
              <label for="rdate">Register Date:</label>
              <p id="rdate">
                <fmt:parseDate value="${p.productRegdate}"
                               pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime" type="both" />
                <fmt:formatDate pattern="yyyy년MM월dd일 HH시mm분ss시 등록" value="${parsedDateTime}" /></p>
            </div>
            <div class="form-group">
              <label for="udate">Update Date:</label>
              <p id="udate">
                <fmt:parseDate value="${p.productUpdate}"
                               pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime" type="both" />
                <fmt:formatDate pattern="yyyy년MM월dd일 HH시mm분ss시 수정" value="${parsedDateTime}" />
              </p>
            </div>


            <button type="button" class="btn btn-primary" id="product_update_btn">Update</button>
            <button type="button" class="btn btn-primary" id="product_delete_btn">Delete</button>
          </form>

        </div>
      </div>
    </div>
  </div>


</div>
