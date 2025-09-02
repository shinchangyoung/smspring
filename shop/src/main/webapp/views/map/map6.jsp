<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .map_wrap {overflow:hidden;height:330px}
    #map1 {width:100%; height:100%; border:2px solid red;}
    #roadview {width:100%; height:100%;}
    #mapWrapper, #rvWrapper {width:50%;height:300px;float:left}
</style>
<script>
    let map1 = {
        myMap: null,
        myRoadview: null,
        myRoadviewClient: null,
        rvMarker: null,

        init: function(){
            let mapContainer = document.getElementById('map1');
            let mapOption = {
                center: new kakao.maps.LatLng(36.800209, 127.074968),
                level: 7
            }
            // map 객체를 map1.myMap에 저장
            this.myMap = new kakao.maps.Map(mapContainer, mapOption);

            let mapTypeControl = new kakao.maps.MapTypeControl();
            this.myMap.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            let zoomControl = new kakao.maps.ZoomControl();
            this.myMap.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

            // 로드뷰 관련 객체들을 map1 내부에 저장
            this.myRoadview = new kakao.maps.Roadview(document.getElementById('roadview'));
            this.myRoadviewClient = new kakao.maps.RoadviewClient();

            // 초기 로드뷰 마커와 지도 클릭 이벤트 설정
            this.setupRoadviewMarkerAndEvents();

            // 기존 마커 및 인포윈도우 설정
            let markerPosition  = new kakao.maps.LatLng(36.800209, 127.074968);
            let marker = new kakao.maps.Marker({
                position: markerPosition,
                map:this.myMap
            });
            let iwContent = '<p>Info Window</p>';
            let infowindow = new kakao.maps.InfoWindow({
                content : iwContent
            });
            kakao.maps.event.addListener(marker, 'mouseover', () => {
                infowindow.open(this.myMap, marker);
            });
            kakao.maps.event.addListener(marker, 'mouseout', () => {
                infowindow.close();
            });
            kakao.maps.event.addListener(marker, 'click', () => {
                location.href='<c:url value="/cust/get"/>'
            });
        },

        setupRoadviewMarkerAndEvents: function(){
            let mapCenter = this.myMap.getCenter();
            this.myMap.addOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);

            let markImage = new kakao.maps.MarkerImage(
                'https://t1.daumcdn.net/localimg/localimages/07/2018/pc/roadview_minimap_wk_2018.png',
                new kakao.maps.Size(26, 46),
                {
                    spriteSize: new kakao.maps.Size(1666, 168),
                    spriteOrigin: new kakao.maps.Point(705, 114),
                    offset: new kakao.maps.Point(13, 46)
                }
            );

            this.rvMarker = new kakao.maps.Marker({
                image : markImage,
                position: mapCenter,
                draggable: true,
                map: this.myMap
            });

            // 마커 dragend 이벤트
            kakao.maps.event.addListener(this.rvMarker, 'dragend', (mouseEvent) => {
                this.toggleRoadview(this.rvMarker.getPosition());
            });

            // 지도 click 이벤트
            kakao.maps.event.addListener(this.myMap, 'click', (mouseEvent) => {
                let position = mouseEvent.latLng;
                this.rvMarker.setPosition(position);
                this.toggleRoadview(position);
            });
            this.toggleRoadview(mapCenter);
        },

        toggleRoadview: function(position){
            let mapWrapper = document.getElementById('mapWrapper');
            let rvContainer = document.getElementById('roadview');

            this.myRoadviewClient.getNearestPanoId(position, 50, (panoId) => {
                if (panoId === null) {
                    rvContainer.style.display = 'none';
                    mapWrapper.style.width = '100%';
                    this.myMap.relayout();
                } else {
                    mapWrapper.style.width = '50%';
                    this.myMap.relayout();
                    rvContainer.style.display = 'block';
                    this.myRoadview.setPanoId(panoId, position);
                    this.myRoadview.relayout();
                }
            });
        }
    };

    $(function(){
        map1.init();
    })
</script>
<div class="col-sm-10">
    <h2>Map6</h2>
    <div class="map_wrap">
        <div id="mapWrapper">
            <div id="map1"></div>
        </div>
        <div id="rvWrapper">
            <div id="roadview"></div>
        </div>
    </div>
</div>