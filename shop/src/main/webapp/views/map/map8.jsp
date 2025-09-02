<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #map{
        width:auto;
        height:400px;
        border: 2px solid blue;
    }
    #content{
        margin-top: 80px;
        width:auto;
        height:400px;
        border: 2px solid red;
        overflow: auto;
    }

</style>
<script>
    let map2 = {
        myMap: null,
        currentTypeId: null,
        clickMarker: null, // 클릭 마커를 저장할 속성 추가

        init: function() {
            this.makeMap(37.538453, 127.053110, '남산', 's1.jpg', 100);

            $('#sbtn').click(() => {
                this.makeMap(37.538453, 127.053110, '남산', 's1.jpg', 100);
                $('#content').html("서울");
                $('#content').html("서울");
            });
            $('#bbtn').click(() => {
                this.makeMap(35.170594, 129.175159, '해운대', 's2.jpg', 200);
                $('#content').html("부산");
            });
            $('#jbtn').click(() => {
                this.makeMap(33.250645, 126.414800, '중문', 's3.jpg', 300);
                $('#content').html("제주");
            });

            // 추가된 오버레이 버튼에 대한 클릭 이벤트 리스너를 등록합니다.
            $('#traffic').click(() => {
                this.setOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
            });
            $('#roadview').click(() => {
                this.setOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);
            });
            $('#terrain').click(() => {
                this.setOverlayMapTypeId(kakao.maps.MapTypeId.TERRAIN);
            });
            $('#use_district').click(() => {
                this.setOverlayMapTypeId(kakao.maps.MapTypeId.USE_DISTRICT);
            });
        },

        makeMap: function(lat, lng, title, imgName, target) {
            let mapContainer = document.getElementById('map');
            let mapOption = {
                center: new kakao.maps.LatLng(lat, lng),
                level: 7
            };

            this.myMap = new kakao.maps.Map(mapContainer, mapOption);

            // 지도에 클릭 이벤트 리스너를 추가하여, 클릭 시 clicklatMap 메서드를 호출합니다.
            kakao.maps.event.addListener(this.myMap, 'click', (mouseEvent) => {
                this.clicklatMap(mouseEvent);
            });

            let mapTypeControl = new kakao.maps.MapTypeControl();
            this.myMap.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            let zoomControl = new kakao.maps.ZoomControl();
            this.myMap.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

            let markerPosition = new kakao.maps.LatLng(lat, lng);
            let marker = new kakao.maps.Marker({
                position: markerPosition,
                map: this.myMap
            });

            let iwContent = '<p>' + title + '</p>';
            iwContent += '<img src="<c:url value="/img/' + imgName + '"/>" style="width:80px;">';
            let infowindow = new kakao.maps.InfoWindow({
                content: iwContent
            });



            kakao.maps.event.addListener(marker, 'mouseover', () => {
                infowindow.open(this.myMap, marker);
            });
            kakao.maps.event.addListener(marker, 'mouseout', () => {
                infowindow.close();
            });
            kakao.maps.event.addListener(marker, 'click', () => {
                location.href = '<c:url value="/cust/get"/>';
            });

            //this.makeMarkers(this.myMap, target);
        },



        // setOverlayMapTypeId 메서드는 지도에 특정 오버레이(교통정보, 지형 등)를 추가/제거하는 기능을 담당합니다.
        setOverlayMapTypeId: function(changeMaptype) { // 매개변수 이름을 변경했습니다.
            // 이전에 추가된 오버레이가 있다면 제거합니다.
            if (this.currentTypeId) {
                this.myMap.removeOverlayMapTypeId(this.currentTypeId);
            }

            // 새로운 지도 오버레이를 지도에 추가합니다.
            this.myMap.addOverlayMapTypeId(changeMaptype);

            // 현재 지도에 추가된 오버레이의 타입을 갱신합니다.
            this.currentTypeId = changeMaptype;
        },

        clicklatMap: function(mouseEvent) {
            let latlng = mouseEvent.latLng;
            let message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
            message += '경도는 ' + latlng.getLng() + ' 입니다.';

            // 결과를 표시할 HTML 요소를 찾고 내용을 업데이트합니다.
            let resultDiv = document.getElementById('result');
            resultDiv.innerHTML = message;

            // 이전에 생성된 마커가 있다면 지도에서 제거합니다.
            if (this.clickMarker) {
                this.clickMarker.setMap(null);
            }

            // 새로운 마커를 클릭한 위치에 생성합니다.
            this.clickMarker = new kakao.maps.Marker({
                position: latlng, // 클릭한 위치를 마커의 좌표로 설정
                map: this.myMap // 마커를 표시할 지도 객체 지정
            });
        },



        //해당 선택한 지역의 정보를 가져오기 위한 함수
        //가상의 데이터를 삽입하였음
        makeMarkers: function (map, target){
            let datas = [];
            if(target == 100){
                datas = [
                    {lat:37.564472, lng:126.990841, title:'순대국1', img:'ss1.jpg', target:101},
                    {lat:37.544472, lng:126.970841, title:'순대국2', img:'ss2.jpg', target:102},
                    {lat:37.564472, lng:126.970841, title:'순대국3', img:'ss3.jpg', target:103},
                    {lat:37.565472, lng:126.980841, title:'순대국4', img:'ss4.jpg', target:104},
                    {lat:37.563472, lng:126.974841, title:'순대국5', img:'ss5.jpg', target:105},
                    {lat:37.565472, lng:126.972841, title:'순대국6', img:'ss6.jpg', target:106},
                    {lat:37.566472, lng:126.971841, title:'순대국7', img:'ss7.jpg', target:107}
                ];
            }else if(target == 200){
                datas = [
                    {lat:35.176109, lng:129.165474, title:'순대국1', img:'ss1.jpg', target:201},
                    {lat:35.171109, lng:129.174474, title:'순대국2', img:'ss2.jpg', target:202},
                    {lat:35.179109, lng:129.172474, title:'순대국3', img:'ss3.jpg', target:203},
                    {lat:35.173109, lng:129.166474, title:'순대국4', img:'ss4.jpg', target:204}
                ];
            }
            let imgSrc1 = 'https://t1.daumcdn.net/localimg/localimages/07/2012/img/marker_p.png';

            $(datas).each((index, item)=>{
                let imgSize = new kakao.maps.Size(30,30);
                let markerImg = new kakao.maps.MarkerImage(imgSrc2, imgSize);
                let markerPosition = new kakao.maps.LatLng(item.lat, item.lng);
                let marker = new kakao.maps.Marker({
                    image: markerImg,
                    map:map,
                    position: markerPosition
                });
            })
        }

    };

    $(function() {
        map2.init();
    });
</script>
<div class="col-sm-10">
    <div class="row">
        <div class="col-sm-8">
            <h2>Map2</h2>
            <button id="sbtn" class="btn btn-primary">Seoul</button>
            <button id="bbtn" class="btn btn-primary">Busan</button>
            <button id="jbtn" class="btn btn-primary">Jeju</button>
            <div id="map"></div>
            <p>
                <button id="traffic" class=" btn-primary">교통정보 보기</button>
                <button id="roadview" class=" btn-primary">로드뷰 도로정보 보기</button>
                <button id="terrain" class="btn-primary">지형정보 보기</button>
                <button id="use_district" class="btn-primary">지적편집도 보기</button>
            </p>
        </div>
        <div class="col-sm-4">
            <div id="content"></div>
            <div id="result"></div>
        </div>
    </div>

</div>