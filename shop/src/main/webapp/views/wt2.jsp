<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  #map{
    width:auto;
    height:400px;
    border: 2px solid blue;
  }
  #result{
    margin-top: 83px;
    width:auto;
    height:400px;
    border: 2px solid red;
    overflow: auto;
  }
</style>
<script>
  //맵의 기능을 map2라는 객체에 담았다.
  let map2={
    //스크립트 코드가 실행이 될때 맨먼저 작동이 된다.
    init:function(){
      this.makeMap(37.538453, 127.053110, '남산', 100);

      // 37.538453, 127.053110
      $('#sbtn').click(()=>{
        let loc = 108
        this.getData2(loc); //데이터를 넣어준다
        this.makeMap(37.538453, 127.053110, '남산', 's1.jpg', 100);

      });
      // 35.170594, 129.175159
      $('#bbtn').click(()=>{
        let loc = 109
        this.getData2(loc); //데이터를 넣어준다
        this.makeMap(35.170594, 129.175159, '해운대', 's2.jpg', 200);
      });
      // 33.250645, 126.414800
      $('#jbtn').click(()=>{
        let loc = 131
        this.getData2(loc); //데이터를 넣어준다
        this.makeMap(33.250645, 126.414800, '중문', 's3.jpg', 300);
      });
    },

    makeMap:function(lat, lng, title, imgName, target){
      let mapContainer = document.getElementById('map');
      let mapOption = {
        center: new kakao.maps.LatLng(lat, lng),
        level: 7
      }

      let map = new kakao.maps.Map(mapContainer, mapOption);
      let mapTypeControl = new kakao.maps.MapTypeControl();
      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
      let zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

      // Marker 생성
      let markerPosition  = new kakao.maps.LatLng(lat, lng);
      let marker = new kakao.maps.Marker({
        position: markerPosition,
        map:map
      });

      // Infowindow
      let iwContent = '<p>'+title+'</p>';
      iwContent += '<img src="<c:url value="/img/'+imgName+'"/> " style="width:80px;">';
      let infowindow = new kakao.maps.InfoWindow({
        content : iwContent
      });

      // Event
      kakao.maps.event.addListener(marker, 'mouseover', function(){
        infowindow.open(map, marker);
      });
      kakao.maps.event.addListener(marker, 'mouseout', function(){
        infowindow.close();
      });
      kakao.maps.event.addListener(marker, 'click', function(){
        location.href='<c:url value="/wt2"/> '
      });

      this.getData(map, target);
    },


    getData: function (map, target){
      $.ajax({
        url:'/getmarkers',
        data:{target:target},
        success:(data)=>{
          this.makeMarkers(map, data);
        }
      });
    },

    getData2:function(loc){
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

  $(function(){
    map2.init();
  })
</script>
<div class="col-sm-10">
  <div class="row">
    <div class="col-sm-8">
      <h2>Wheather2</h2>
      <button id="sbtn" class="btn btn-primary">Seoul</button>
      <button id="bbtn" class="btn btn-primary">Busan</button>
      <button id="jbtn" class="btn btn-primary">Jeju</button>
      <div id="map"></div>
    </div>
    <div class="col-sm-4">
      <div id="result"></div>
    </div>
  </div>


</div>