<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Center Page --%>
<div class="col-sm-9">
  <h2>Cust Get Page</h2>
  <table class="table table-bordered">
    <thead>
    <tr>
      <th>Id</th>
      <th>Pwd</th>
      <th>Name</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="c" items="${clist}">
      <tr>
        <td><a href="/cust/detail?id=${c.custId}">${c.custId}</a></td>
        <td>${c.custPwd}</td>
        <td>${c.custName}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>