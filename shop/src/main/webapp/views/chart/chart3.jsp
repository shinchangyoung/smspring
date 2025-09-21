<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #container{
        width:500px;
        border: 2px solid red;
    }
</style>
<style>
    .chart-container {
        width: 48%;
        border: 1px solid #ddd;
        display: inline-block;
    }
</style>
<script>
    let chart3 = {
        init: function () {
            this.getdata();
        },
        getdata: function () {
            $.ajax({
                url: '<c:url value="/chart3"/>',
                type: 'GET',
                dataType: 'json',
                success: (data) => {
                    console.log('Chart3 Data:', data);
                    if (data.error) {
                        console.error('Error:', data.error);
                        alert('데이터를 가져오는 중 오류가 발생했습니다: ' + data.error);
                        return;
                    }
                    this.displayTotal(data.categories, data.totalSalesSeries);
                    this.displayAverage(data.categories, data.averageSalesSeries);
                },
                error: (xhr, status, error) => {
                    console.error('AJAX Error:', error);
                    alert('서버와 통신 중 오류가 발생했습니다.');
                }
            });
        },
        displayTotal: function (categories, seriesData) {
            Highcharts.chart('containerTotal', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: '브랜드별 월별 매출 합계'
                },
                xAxis: {
                    categories: categories
                },
                yAxis: {
                    title: {
                        text: '매출 합계 (원)'
                    }
                },
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: true
                        },
                        enableMouseTracking: false
                    }
                },
                series: seriesData
            });
        },
        displayAverage: function (categories, seriesData) {
            Highcharts.chart('containerAverage', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: '브랜드별 월별 매출 평균'
                },
                xAxis: {
                    categories: categories
                },
                yAxis: {
                    title: {
                        text: '매출 평균 (원)'
                    }
                },
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: true
                        },
                        enableMouseTracking: false
                    }
                },
                series: seriesData
            });
        }
    }
    $(function () {
        chart3.init();
    });
</script>

<div class="col-sm-10">
    <h2>브랜드별 월별 매출 분석</h2>
    <div id="containerTotal" class="chart-container"></div>
    <div id="containerAverage" class="chart-container"></div>
</div>