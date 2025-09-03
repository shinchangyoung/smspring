<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #map1{
        width:auto;
        height:400px;
        border:2px solid red;
    }
</style>
<script>
    let map1 = {
        Map: null,
        randomMarker: null, // 랜덤 마커를 저장할 변수명 변경
        randomInfowindow: null, // 랜덤 인포윈도우를 저장할 변수명 변경
        randomInterval: null, // 타이머 객체를 저장할 변수

        init: function() {
            let mapContainer = document.getElementById('map1');
            let mapOption = {
                center: new kakao.maps.LatLng(36.800209, 127.074968),
                level: 7
            };
            this.Map = new kakao.maps.Map(mapContainer, mapOption);

            // 기존 마커 및 이벤트 설정 (요청에 따라 삭제 또는 유지 가능)
            let markerPosition  = new kakao.maps.LatLng(36.800209, 127.074968);
            let marker = new kakao.maps.Marker({
                position: markerPosition,
                map:this.Map
            });
            let iwContent = '<p>Info Window</p>';
            let infowindow = new kakao.maps.InfoWindow({
                content : iwContent
            });
            kakao.maps.event.addListener(marker, 'mouseover', function(){
                infowindow.open(this.Map, marker);
            });
            kakao.maps.event.addListener(marker, 'mouseout', function(){
                infowindow.close();
            });
            kakao.maps.event.addListener(marker, 'click', function(){
                location.href='<c:url value="/cust/get"/> '
            });

            // 1초마다 무작위 마커를 표시하는 함수를 호출
            let self = this;
            this.randomInterval = setInterval(function() {
                self.updateRandomMarker();
            }, 1000); // 1000ms = 1초
        },

        // 무작위 위치에 마커와 인포윈도우를 업데이트하는 함수
        updateRandomMarker: function() {
            let bounds = this.Map.getBounds();
            let swLatLng = bounds.getSouthWest(); // 지도의 남서쪽 좌표
            let neLatLng = bounds.getNorthEast(); // 지도의 북동쪽 좌표

            let swLat = swLatLng.getLat();
            let swLng = swLatLng.getLng();
            let neLat = neLatLng.getLat();
            let neLng = neLatLng.getLng();

            // 현재 지도 경계 내에서 무작위 위도와 경도 생성
            let randomLat = swLat + (neLat - swLat) * Math.random();
            let randomLng = swLng + (neLng - swLng) * Math.random();
            let randomLatLng = new kakao.maps.LatLng(randomLat, randomLng);

            // 기존 마커가 있으면 지도에서 제거
            if (this.randomMarker) {
                this.randomMarker.setMap(null);
            }

            // 기존 인포윈도우가 있으면 닫기
            if (this.randomInfowindow) {
                this.randomInfowindow.close();
            }

            // 새로운 마커를 무작위 위치에 생성
            this.randomMarker = new kakao.maps.Marker({
                position: randomLatLng,
                map: this.Map
            });

            this.randomInfowindow.open(this.Map, this.randomMarker);
        }
    };

    $(function(){
        map1.init();
    });
</script>

<div class="col-sm-10">
    <h2>Map7</h2>
    <h3>오후 과정</h3>

    <div id="map1"></div>
</div>