
var options = {
    chart: {
        type: 'line',
        height: '600px'
    },
    stroke: {
        curve: 'straight'
    },
    xaxis: {
        type: 'datetime',
            labels: {
            format: 'yyyy-MM-dd',
        }
    },
    series: [ 
    ],
    yaxis: {
        title: {
        text: 'Cases'
        }
    },
    dataLabels: {
        enabled: false,
        style: {
            colors: ['#000000']
        }
    },
    title: {
        text: 'Total reported monkeypox cases in Germany'
    },
    subtitle: {
        text: 'Source: Robert Koch Institute'
    },
    tooltip: {
        x: {
            format: 'yyyy-MM-dd'
        }
    },
    plotOptions: {
        bar: {
            dataLabels: {
                position: 'top'
            }
        },
        dataLabels: {
            enabled: false,
            style: {
                colors: ['#000000']
            },
            offsetX: 30
        },
    }
}

var chart = false;
var x_dates = [];
var y_total_cases = [];
var xy_total_cases = [];

function startUp() {
    
    $.get('./data/RKI_Monkeypox_processed.csv', function(rawdata) {
        
        data = $.csv.toArrays(rawdata);
        for ( var i = 1; i < data.length; ++i )
        {
            ts = new Date(data[i][0]).getTime();
            x_dates.push( ts );
            y_total_cases.push( parseInt(data[i][1]) );

            xy_total_cases.push( [ ts, parseInt(data[i][1]) ] );
        }
    }, dataType='text');

    chart = new ApexCharts(document.querySelector("#MPXTotalCases"), options);
    chart.render();
    chart.appendSeries({ name: 'Reported monkeypox cases in Germany', data: xy_total_cases }, false);
}

$(document).ready(function(){
    startUp();
});

