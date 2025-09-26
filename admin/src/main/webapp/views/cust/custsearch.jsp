<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Tables</h1>


    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Custmer Select</h6>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Regdate</th>
                    <th>Update</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="c" items="${cpage.getList()}">
                    <tr>
                        <td>${c.custId}</td>
                        <td>${c.custName}</td>
                        <td>
                            <fmt:parseDate value="${ c.custRegdate }"
                                           pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                            <fmt:formatDate pattern="yyyy년MM월dd일 HH:mm" value="${ parsedDateTime }" />
                        </td>
                        <td>
                            <fmt:parseDate value="${c.custUpdate}"
                                           pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                            <fmt:formatDate pattern="yyyy년MM월dd일 HH:mm" value="${ parsedDateTime }" />
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <jsp:include page="pagination.jsp"/>
        </div>
    </div>

</div>
<!-- /.container-fluid -->

<!-- Page level plugins -->
<script src="/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="/js/demo/datatables-demo.js"></script>


