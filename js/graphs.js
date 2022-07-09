
var options = {
    chart: {
        type: 'line',
        height: '600px',
        events: {
            mounted: (chart) => {
              chart.windowResizeHandler();
            }
          }
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
        },
        decimalsInFloat: 0
    },
    dataLabels: {
        enabled: false,
        style: {
            colors: ['#000000']
        }
    },
    title: {
        text: ''
    },
    subtitle: {
        text: 'Source: Robert Koch Institute; SurvStat@RKI 2.0, https://survstat.rki.de'
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

var chart_sum = new ApexCharts(document.querySelector("#MPXTotalCases"), options);
chart_sum.render();

var chart_new = new ApexCharts(document.querySelector("#MPXNewCases"), options);
chart_new.render();

var x_dates = [];
var xy_total_cases = [];
var xy_new_cases = [];
var xy_new_cases_mean = [];
var xy_states = {};
var states = [];

function startUp() {
    
    $.get('./data/RKI_Monkeypox_processed.csv', function(rawdata) {
        
        data = $.csv.toArrays(rawdata);
        for ( var i = 1; i < data.length; ++i )
        {
            ts = new Date(data[i][0]).getTime();
            x_dates.push( ts );

            xy_total_cases.push( [ ts, parseInt(data[i][1]) ] );
            xy_new_cases.push( [ ts, parseInt(data[i][4]) ] );
            xy_new_cases_mean.push( [ ts, parseFloat(data[i][5]) ] );
        }
        chart_new.appendSeries({ name: 'Newly monkeypox cases in Germany', data: xy_new_cases });
        chart_new.appendSeries({ name: 'Newly monkeypox cases in Germany (7-day average)', data: xy_new_cases_mean });
    }, dataType='text');

    $.get('./data/RKI_Monkeypox_processed_states.csv', function(rawdata) {
        
        data = $.csv.toArrays(rawdata);
        states = data[0].slice(2, data[0].length-1);
        for ( var i = 0; i < states.length; ++i )
        {
            xy_states[states[i]] = [];
        }
        for ( var i = 1; i < data.length; ++i )
        {
            ts = new Date(data[i][0]).getTime();
            for ( var j = 0; j < states.length; ++j )
            {
                xy_states[states[j]].push( [ ts, parseInt(data[i][2+j]) ] );
            }
        }
        chart_sum.appendSeries({ name: 'Germany', data: xy_total_cases });
        for ( var j = 0; j < states.length; ++j )
        {
            chart_sum.appendSeries({ name: states[j], data: xy_states[states[j]] });
            console.log(xy_states[states[j]]);
        }
    }, dataType='text');

}
