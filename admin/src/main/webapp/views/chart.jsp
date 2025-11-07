
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    #container1, #container2, #container3, #container4{
        width:auto;
        border: 2px solid red;
    }
</style>
<script>
    let chart = {
        urls: [
            '${mainsseUrl}logs/maininfo1.log',
            '${mainsseUrl}logs/maininfo2.log',
            '${mainsseUrl}logs/maininfo3.log',
            '${mainsseUrl}logs/maininfo4.log',
            '${mainsseUrl}logs/logincount.log'
        ],
        containers: [
            'container1',
            'container2',
            'container3',
            'container4',
            'container5'
        ],
        // 각 차트의 선 및 영역 색상 배열 정의
        colors: [
            '#32CD32', // Chart 1 (라임 그린)
            '#007BFF', // Chart 2 (파란색)
            '#FFC107', // Chart 3 (노란색)
            '#DC3545',  // Chart 4 (빨간색)
            '#9B59B6'  // Chart 5 (보라색) - 로그인 차트 ← 이 줄 추가
        ],

        init: function() {
            // urls 배열을 순회하며 각 차트를 생성합니다.
            for (let i = 0; i < this.urls.length; i++) {
                if (i === 4) {
                    // 5번째 차트(로그인 카운트)는 막대그래프로 생성
                    this.createColumnChart(this.containers[i], this.urls[i], this.colors[i]);
                } else {
                    this.createChart(this.containers[i], this.urls[i], this.colors[i]);
                }
            }
            <c:if test="${sessionScope.admin.adminId != null}">
            this.adminId = '${sessionScope.admin.adminId}';
            this.connect();
            </c:if>
        },

        // color 인자를 추가
        createChart: function(containerId, dataUrl, chartColor) {
            Highcharts.chart(containerId, {
                chart: {
                    type: 'areaspline'
                },
                lang: {
                    locale: 'en-GB'
                },
                title: {
                    text: 'Live Data'
                },

                plotOptions: {
                    areaspline: {
                        // 이 부분에 chartColor 인자를 적용
                        color: chartColor,
                        fillColor: {
                            linearGradient: { x1: 0, x2: 0, y1: 0, y2: 1 },
                            stops: [
                                // 그라데이션에도 chartColor 적용 (투명도는 16진수 '20'으로 설정)
                                [0, chartColor],
                                [1, Highcharts.color(chartColor).setOpacity(0.2).get('rgba')]
                            ]
                        },
                        threshold: null,
                        marker: {
                            lineWidth: 1,
                            lineColor: null,
                            fillColor: 'white'
                        }
                    }
                },
                data: {
                    csvURL: dataUrl,
                    enablePolling: true,
                    dataRefreshRate: parseInt(2, 10)
                }
            });
        },

        // 막대그래프(Column Chart) 생성 함수
        createColumnChart: function(containerId, dataUrl, chartColor) {
            Highcharts.chart(containerId, {
                chart: {
                    type: 'column'
                },
                lang: {
                    locale: 'en-GB'
                },
                title: {
                    text: 'Login Count'
                },
                plotOptions: {
                    column: {
                        color: chartColor,
                        borderRadius: 5,
                        dataLabels: {
                            enabled: true,
                            color: '#FFFFFF'
                        }
                    }
                },
                data: {
                    csvURL: dataUrl,
                    enablePolling: true,
                    dataRefreshRate: parseInt(2, 10)
                }
            });
        },

        connect:function(){
            // SSE 연결
            let url = '${websocketurl}connect/'+this.adminId ;
            const sse = new EventSource(url);
            sse.addEventListener('connect', (e) => {
                const { data: receivedConnectData } = e;
                console.log('connect event data: ',receivedConnectData);  // "connected!"
            });
            sse.addEventListener('count', e => {
                const { data: receivedCount } = e;
                console.log("count :",receivedCount);
                $('#count').html(receivedCount);
            });
            sse.addEventListener('carMsg', e => {
                const { data: receivedData } = e;
                console.log("count event data",receivedData);
                console.log("count event data2",JSON.parse(receivedData).content1);
                this.display(JSON.parse(receivedData));
            });
        },
        display:function(data){
            $('#msg1').text(data.content1);
            $('#msg2').text(data.content2);
            $('#msg3').text(data.content3);
            $('#msg4').text(data.content4);
            $('#progress1').css('width',data.content1/100*100+'%');
            $('#progress1').attr('aria-valuenow',data.content1/100*100);
            $('#progress2').css('width',data.content2/1000*100+'%');
            $('#progress2').attr('aria-valuenow',data.content2/1000*100);
            $('#progress3').css('width',data.content3/500*100+'%');
            $('#progress3').attr('aria-valuenow',data.content3/500*100);
            $('#progress4').css('width',data.content4/10*100+'%');
            $('#progress4').attr('aria-valuenow',data.content4/10*100);
        }


    }
    $(() => {
        chart.init();
    })
</script>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Chart</h1>
        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
    </div>


    <!-- Content Row -->
    <div class="row ">

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Car1
                            </div>
                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <div id="msg1" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
                                </div>
                                <div class="col">
                                    <div class="progress progress-sm mr-2">
                                        <div id="progress1" class="progress-bar bg-info" role="progressbar"
                                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                                             aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Car2
                            </div>
                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <div id="msg2" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
                                </div>
                                <div class="col">
                                    <div class="progress progress-sm mr-2">
                                        <div id="progress2" class="progress-bar bg-info" role="progressbar"
                                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                                             aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Car3
                            </div>
                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <div id="msg3" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
                                </div>
                                <div class="col">
                                    <div class="progress progress-sm mr-2">
                                        <div id="progress3" class="progress-bar bg-info" role="progressbar"
                                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                                             aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Car4
                            </div>
                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <div id="msg4" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
                                </div>
                                <div class="col">
                                    <div class="progress progress-sm mr-2">
                                        <div id="progress4" class="progress-bar bg-danger" role="progressbar"
                                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                                             aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Content Row -->
    <div class="row">
        <div class="col-xl-6 col-lg-6">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Shop Main1</h6>
                </div>
                <div class="card-body">
                    <div id="container1" style="height: 300px;"></div>
                </div>
            </div>
        </div>
        <div class="col-xl-6 col-lg-6">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Shop Main2</h6>
                </div>
                <div class="card-body">
                    <div id="container2" style="height: 300px;"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xl-6 col-lg-6">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Shop Main3</h6>
                </div>
                <div class="card-body">
                    <div id="container3" style="height: 300px;"></div>
                </div>
            </div>
        </div>
        <div class="col-xl-6 col-lg-6">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Shop Main4</h6>
                </div>
                <div class="card-body">
                    <div id="container4" style="height: 300px;"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- 297번째 줄 </div> 바로 앞에 추가 -->
    <div class="row">
        <div class="col-xl-12 col-lg-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Login Activity</h6>
                </div>
                <div class="card-body">
                    <div id="container5" style="height: 300px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>