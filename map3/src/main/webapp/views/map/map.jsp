<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #map{
        width:1000px;
        height:400px;
        border: 2px solid blue;
    }
</style>
<script>
    let map2={
        map: null,
        markers: [],
        circle: null,

        init:function(){
            this.makeMap(36.800209, 127.074968);

            // [전체보기 버튼] 클릭 이벤트만 남깁니다.
            $('#shop').click(()=> {
                this.getData(10, this.displayAllShopsWithCircle.bind(this));
            });
        },

        makeMap:function(lat, lng){
            const mapContainer = document.getElementById('map');
            const mapOption = { center: new kakao.maps.LatLng(lat, lng), level: 5 };
            this.map = new kakao.maps.Map(mapContainer, mapOption);
        },

        clearOverlays: function() {
            this.markers.forEach(marker => marker.setMap(null));
            this.markers = [];
            if (this.circle) { this.circle.setMap(null); this.circle = null; }
        },

        getData: function (cateNo, successCallback){
            $.ajax({
                url:'/getshops',
                data:{cateNo:cateNo},
                success:(data)=>{
                    if (!data || data.length === 0) {
                        alert('표시할 가게 정보가 없습니다.');
                        return;
                    }
                    successCallback(data);
                }
            });
        },

        // [전체보기 기능] 모든 마커와 고정된 원을 함께 표시하는 함수
        displayAllShopsWithCircle: function(datas) {
            this.clearOverlays();
            const bounds = new kakao.maps.LatLngBounds();

            // 1. 고정된 중심점을 정의하고 원과 중심마커를 그립니다.
            const fixedCenter = new kakao.maps.LatLng(36.800209, 127.074968);
            this.drawCenterAndCircle(fixedCenter, 3000); // 3km 원 표시

            // 2. DB에서 가져온 모든 가게 마커를 생성합니다.
            datas.forEach(item => {
                const markerPosition = new kakao.maps.LatLng(item.lat, item.lng);
                this.createMarker(markerPosition, item);
                bounds.extend(markerPosition); // 마커 위치를 지도 범위에 추가
            });

            // 3. 중심점도 지도 범위에 포함시켜, 원이 잘리지 않도록 합니다.
            bounds.extend(fixedCenter);

            // 4. 모든 마커와 원이 보이도록 지도 범위를 최종 조정합니다.
            this.map.setBounds(bounds);
        },

        // 중심점 마커와 원을 그리는 헬퍼 함수
        drawCenterAndCircle: function(position, radius) {
            const centerMarker = new kakao.maps.Marker({ map: this.map, position: position });
            const centerInfowindow = new kakao.maps.InfoWindow({ content: '<div style="padding:5px;text-align:center;">중심점</div>', removable: true });
            kakao.maps.event.addListener(centerMarker, 'click', () => { centerInfowindow.open(this.map, centerMarker); });
            this.markers.push(centerMarker);

            this.circle = new kakao.maps.Circle({
                center : position,
                radius: radius, // 파라미터로 받은 반경을 사용
                strokeWeight: 3, strokeColor: '#39f', strokeOpacity: 0.8, strokeStyle: 'solid',
                fillColor: '#bce6ff', fillOpacity: 0.3
            });
            this.circle.setMap(this.map);
        },

        // 마커를 생성하는 공통 함수
        createMarker: function(position, item) {
            const imgSrc1 = 'https://t1.daumcdn.net/localimg/localimages/07/2012/img/marker_p.png';
            const markerImg = new kakao.maps.MarkerImage(imgSrc1, new kakao.maps.Size(30,30));
            const marker = new kakao.maps.Marker({ image: markerImg, map: this.map, position: position });
            this.markers.push(marker);

            const iwContent = '<p>'+item.title+'</p><img style="width:80px;" src="<c:url value="/img/shop/'+item.img+'"/>">';
            const infowindow = new kakao.maps.InfoWindow({ content : iwContent, removable: true });

            kakao.maps.event.addListener(marker, 'mouseover', () => infowindow.open(this.map, marker));
            kakao.maps.event.addListener(marker, 'mouseout', () => infowindow.close());
            kakao.maps.event.addListener(marker, 'click', () => { location.href = '<c:url value="/map/goshop?target='+item.target+'"/>'; });
            return marker;
        }
    }

    $(function(){
        map2.init();
    })
</script>
<div class="col-sm-10">
    <div class="row">
        <div class="col-sm-8">
            <h2>Map</h2>
            <button id="shop" class="btn btn-primary">주변검색</button>
            <div id="map"></div>
        </div>
    </div>
</div>