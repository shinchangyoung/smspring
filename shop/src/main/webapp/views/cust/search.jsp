<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<form action="/cust/search" method="get"
      style="margin-bottom: 30px;" id="search_form" class="form-inline well">
  <div class="form-group">
    <label for="id">Name:</label>
    <input type="text" name="custName" class="form-control" id="id" <c:if test="${custName != null}">
           value="${custName}"</c:if>>
  </div>
  <div class="form-group">
    <label for="sdate">Start:</label>
    <input type="date" name="startDate" class="form-control" id="sdate" <c:if test="${startDate != null}">
           value="${startDate}"</c:if>>
  </div>
  <div class="form-group">
    <label for="edate">End:</label>
    <input type="date" name="endDate" class="form-control" id="edate"<c:if test="${endDate != null}">
           value="${endDate}"</c:if>>
  </div>
  <div class="form-group">
    <input type="submit" class="btn btn-info">Search</input>
  </div>
</form>