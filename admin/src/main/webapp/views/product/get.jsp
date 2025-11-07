
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>
    /* 이 CSS 규칙은 'dataTable' ID를 가진 테이블의
       tbody 안에 있는 td 태그의 img 태그를 대상으로 합니다.
    */
    #dataTable tbody td img {
        width: 50px;    /* 이미지의 가로 길이를 50px로 고정합니다. */
        height: auto;   /* 이미지의 원래 비율을 유지하여 찌그러지지 않게 합니다. */
    }
</style>


<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Tables</h1>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Product Select</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th>Img</th>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Rate</th>
                        <th>RegDate</th>
                        <th>Category</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>Img</th>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Rate</th>
                        <th>RegDate</th>
                        <th>Category</th>
                    </tr>
                    </tfoot>
                    <tbody>
                    <c:choose>
                        <c:when test="${plist == null}">
                            <h5>데이터가 없습니다.</h5>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${plist}">
                                <tr>
                                    <td><img src="/imgs/${p.productImg}"></td>
                                    <td><a href="<c:url value="/product/productdetail?id=${p.productId}"/> ">${p.productId}</a></td>

                                    <td>${p.productName}</td>
                                    <td><fmt:formatNumber type="number" pattern="###,###원" value="${p.productPrice}"/></td>
                                    <td>${p.discountRate}</td>
                                    <td>
                                        <fmt:parseDate value="${ p.productRegdate }"
                                                       pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime" type="both"/>
                                        <fmt:formatDate pattern="yyyy년MM월dd일" value="${ parsedDateTime }"/>
                                    </td>
                                    <td>${p.cateName}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>


                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>
<!-- /.container-fluid -->

<!-- Page level plugins -->
<script src="/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="/js/demo/datatables-demo.js"></script>