<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    /* 지도 영역의 스타일을 정의합니다. */
    #map{
        width:auto;
        height:400px;
        border: 2px solid blue;
    }
    /* 정보 표시 영역의 스타일을 정의합니다. */
    #content{
        margin-top: 83px;
        width:auto;
        height:400px;
        border: 2px solid red;
        overflow: auto;
    }
</style>
<script>
    // 전역 객체인 map2를 선언합니다.
    let map2={
        // 객체 초기화 함수입니다.
        init:function(){
            // 페이지 로드 시 기본 지도를 서울 남산으로 설정합니다.
            this.makeMap(37.538453, 127.053110, '남산', 's1.jpg', 100);

            // 서울 버튼 클릭 시 서울 남산 지도를 생성합니다.
            $('#sbtn').click(()=>{
                this.makeMap(37.538453, 127.053110, '남산', 's1.jpg', 100);
            });
            // 부산 버튼 클릭 시 부산 해운대 지도를 생성합니다.
            $('#bbtn').click(()=>{
                this.makeMap(35.170594, 129.175159, '해운대', 'b1.jpg', 200);
            });
            // 제주 버튼 클릭 시 제주 중문 지도를 생성합니다.
            $('#jbtn').click(()=>{
                this.makeMap(33.250645, 126.414800, '중문', 'j1.jpg', 300);
            });
        },
        // 지도를 생성하고 제어하는 함수입니다.
        makeMap:function(lat, lng, title, imgName, target){
            let mapContainer = document.getElementById('map');
            let mapOption = {
                center: new kakao.maps.LatLng(lat, lng), // 지도의 중심 좌표
                level: 7 // 지도의 확대 레벨
            }
            // 새로운 카카오맵 객체를 생성하여 map 변수에 할당합니다.
            let map = new kakao.maps.Map(mapContainer, mapOption);

            // 지도 타입 컨트롤을 생성하고 지도에 추가합니다.
            let mapTypeControl = new kakao.maps.MapTypeControl();
            map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

            // 줌 컨트롤을 생성하고 지도에 추가합니다.
            let zoomControl = new kakao.maps.ZoomControl();
            map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

            // 지도의 중심 좌표에 마커를 생성합니다.
            let markerPosition  = new kakao.maps.LatLng(lat, lng);
            let marker = new kakao.maps.Marker({
                position: markerPosition,
                map:map // 마커를 표시할 지도
            });

            // 마커에 표시할 정보 창(Infowindow)의 내용을 정의합니다.
            let iwContent = '<p>'+title+'</p>';
            iwContent += '<img src="<c:url value="/img/'+imgName+'"/> " style="width:80px;">';
            let infowindow = new kakao.maps.InfoWindow({
                content : iwContent
            });

            // 마커에 마우스 오버 이벤트를 추가하여 정보 창을 엽니다.
            kakao.maps.event.addListener(marker, 'mouseover', function(){
                infowindow.open(map, marker);
            });
            // 마커에서 마우스 아웃 이벤트를 추가하여 정보 창을 닫습니다.
            kakao.maps.event.addListener(marker, 'mouseout', function(){
                infowindow.close();
            });
            // 마커 클릭 시 특정 URL로 이동하는 이벤트를 추가합니다.
            kakao.maps.event.addListener(marker, 'click', function(){
                location.href='<c:url value="/cust/get"/> '
            });

            // makeMarkers 함수를 호출하여 부가적인 마커들을 생성합니다.
            this.makeMarkers(map, target);

        },
        // 선택한 지역에 따라 여러 마커들을 생성하는 함수입니다.
        makeMarkers:function(map, target){
            let datas = [];
            // target 값에 따라 다른 데이터 배열을 설정합니다.
            if(target == 100){ // 서울 지역
                datas = [
                    {lat:37.564472, lng:126.990841, title:'순대국1', img:'ss1.jpg', target:101},
                    // ... (서울 지역 마커 데이터)
                ];
            }else if(target == 200){ // 부산 지역
                datas = [
                    {lat:35.176109, lng:129.165474, title:'순대국1', img:'ss1.jpg', target:201},
                    // ... (부산 지역 마커 데이터)
                ];
            }else if(target == 300){ // 제주 지역
                datas = [
                    {lat:33.251645, lng:126.415800, title:'순대국1', img:'ss1.jpg', target:301},
                    // ... (제주 지역 마커 데이터)
                ];
            }
            // 외부 이미지 경로와 로컬 이미지 경로를 정의합니다.
            let imgSrc1 = 'https://t1.daumcdn.net/localimg/localimages/07/2012/img/marker_p.png';
            let imgSrc2 = '<c:url value="/img/down.png"/> ';

            let result = '';

            // datas 배열을 순회하며 각 마커를 생성하고 이벤트 리스너를 추가합니다.
            $(datas).each((index,item)=>{
                let imgSize = new kakao.maps.Size(30,30);
                // 마커 이미지 객체를 생성합니다.
                let markerImg = new kakao.maps.MarkerImage(imgSrc1, imgSize);
                let markerPosition = new kakao.maps.LatLng(item.lat, item.lng);
                let marker = new kakao.maps.Marker({
                    image: markerImg, // 마커 이미지 설정
                    map:map,
                    position: markerPosition
                });
                // 인포윈도우 내용을 생성합니다.
                let iwContent = '<p>'+item.title+'</p>';
                iwContent += '<img style="width:80px;" src="<c:url value="/img/'+item.img+'"/> ">';
                let infowindow = new kakao.maps.InfoWindow({
                    content : iwContent,
                });
                // 마커에 마우스 오버 및 아웃 이벤트를 추가합니다.
                kakao.maps.event.addListener(marker, 'mouseover', function() {
                    infowindow.open(map, marker);
                });
                kakao.maps.event.addListener(marker, 'mouseout', function() {
                    infowindow.close();
                });
                // 마커 클릭 시 특정 URL로 이동합니다.
                kakao.maps.event.addListener(marker, 'click', function() {
                    location.href = '<c:url value="/map/go?target='+item.target+'"/>';
                });
                // 콘텐츠 목록을 동적으로 생성합니다.
                result += '<p>';
                result += '<a href="<c:url value="/map/go?target='+item.target+'"/>">';
                result += '<img width="20px" src="<c:url value="/img/'+item.img+'"/> ">';
                result += item.target+' '+item.title;
                result += '</a>';
                result += '</p>';
            });  // end for
            // 생성된 HTML 콘텐츠를 화면에 표시합니다.
            $('#content').html(result);
        } // end makeMarkers
    }

    // 문서가 준비되면 map2.init() 함수를 호출합니다.
    $(function(){
        map2.init();
    })
</script>
<div class="col-sm-10">
    <div class="row">
        <div class="col-sm-8">
            <h2>Map2</h2>
            <button id="sbtn" class="btn btn-primary">Seoul</button>
            <button id="bbtn" class="btn btn-primary">Busan</button>
            <button id="jbtn" class="btn btn-primary">Jeju</button>
            <div id="map"></div>
        </div>
        <div class="col-sm-4">
            <div id="content"></div>
        </div>
    </div>
</div>