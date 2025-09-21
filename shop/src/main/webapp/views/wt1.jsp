<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  #result{
    width: 400px;
    border: 2px solid red;
  }
</style>
<script>
  let wt1 = {
    init:function(){
      $('#get_btn').click(()=>{
        let loc = $('#loc').val();
        this.getData(loc); //데이터를 넣어준다
      });
    },
    getData:function(loc){
      $.ajax({
        url : '<c:url value="/getwt1"/>',
        data: {'loc':loc},
        success: (data)=>{
          // alert(data);
          console.log(data);
          this.display(data);
        }
      });
    },
    display:function(data){ //에서 값을 끄집어 내는 함수
      let txt = data.response.body.items.item[0].wfSv;
      $('#result').text(txt);
    }
  }
  $(function (){
    wt1.init();
  });
</script>


<div class="col-sm-10">
  <h2>Weather1 HEADING</h2>
  <select id="loc">
    <option value="108">전국</option>
    <option value="109">서울</option>
    <option value="131">충청</option>
    <option value="064">제주</option>

  </select>
  <button id="get_btn">Get</button>
  <h5 id="status"></h5>
  <div id="result"></div>
</div>