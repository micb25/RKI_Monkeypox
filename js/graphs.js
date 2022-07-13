
var default_chart_options = {
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
        title: { text: 'cases' },
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
        text: 'source: Robert Koch Institute; SurvStat@RKI 2.0, https://survstat.rki.de'
    },
    tooltip: {
        x: {
            format: 'yyyy-MM-dd'
        }
    },
    plotOptions: {
        dataLabels: {
            enabled: false,
            style: {
                colors: ['#000000']
            },
            offsetX: 30
        },
    }
}

var chart_sum = null;
var chart_new = null;
var chart_age = null;

var xy_total_cases = [];
var xy_new_cases = [];
var xy_new_cases_mean = [];
var xy_states = {};
var xy_groups = [];
var y_age_dist = [];
var states = [];
var agroups = [];

var iso_date = "";

function startUp() 
{    
    $.get('./data/RKI_Monkeypox_processed.csv', function(rawdata) {        
        data = $.csv.toArrays(rawdata);
        for ( var i = 1; i < data.length; ++i )
        {
            ts = new Date(data[i][0]).getTime();
            xy_total_cases.push( [ ts, parseInt(data[i][1]) ] );
            xy_new_cases.push( [ ts, parseInt(data[i][4]) ] );
            xy_new_cases_mean.push( [ ts, parseFloat(data[i][5]) ] );
        }

        var options_new = jQuery.extend(true, {}, default_chart_options);
        options_new['series'] = [
            { name: 'New monkeypox cases in Germany', type: 'bar', data: xy_new_cases },
            { name: '7-day average', type: 'line', data: xy_new_cases_mean }
        ];
        options_new['yaxis']['title']['text'] = 'New cases';
        options_new['colors'] = ['#269ffb', '#ff0000'];
        chart_new = new ApexCharts(document.querySelector("#MPXNewCases"), options_new);
        chart_new.render();
    }, dataType='text');

    $.get('./data/RKI_Monkeypox_processed_states.csv', function(rawdata) {        
        data = $.csv.toArrays(rawdata);
        states = data[0].slice(2, data[0].length-1);
        for ( var i = 0; i < states.length; ++i )
            xy_states[states[i]] = [];
        for ( var i = 1; i < data.length; ++i )
        {
            ts = new Date(data[i][0]).getTime();
            for ( var j = 0; j < states.length; ++j )
                xy_states[states[j]].push( [ ts, parseInt(data[i][2+j]) ] );
        }
        
        var options_sum = jQuery.extend(true, {}, default_chart_options);
        options_sum['series'] = [
            { name: 'Germany', data: xy_total_cases }
        ];
        for ( var j = 0; j < states.length; ++j )
            options_sum['series'].push({ name: states[j], data: xy_states[states[j]] });
        chart_sum = new ApexCharts(document.querySelector("#MPXTotalCases"), options_sum);
        chart_sum.render();
    }, dataType='text');

    $.get('./data/RKI_Monkeypox_processed_age_groups.csv', function(rawdata) {        
        data = $.csv.toArrays(rawdata);
        agroups = data[0].slice(2, data[0].length-1);
        for ( var i = 0; i < agroups.length; ++i )
        {
            agroups[i] = agroups[i].replace('..', '-').replace('a', '');
            xy_groups[agroups[i]] = [];
        }            
        for ( var i = 1; i < data.length; ++i )
        {
            ts = new Date(data[i][0]).getTime();
            for ( var j = 0; j < agroups.length; ++j )
                xy_groups[agroups[j]].push( [ ts, parseInt(data[i][2+j]) ] );
        }
        for ( var j = 0; j < agroups.length; ++j )
            y_age_dist.push( xy_groups[agroups[j]][xy_groups[agroups[j]].length - 1][1] );

        var options_age = jQuery.extend(true, {}, default_chart_options);
        options_age['xaxis']['type'] = null;
        options_age['xaxis']['title'] = { 'text': 'age group (in years)' };
        options_age['xaxis']['categories'] = agroups;
        options_age['xaxis']['axisBorder'] = { 'show': false };
        options_age['xaxis']['axisTicks'] = { 'show': false };
        options_age['series'] = [ { name: 'age group', type: 'bar', data: y_age_dist } ];
        chart_age = new ApexCharts(document.querySelector("#MPXAgeGroups"), options_age);
        chart_age.render();

        iso_date = data[data.length-1][0];
        $("#LastUpdate").text(iso_date);
        // updateList();
    }, dataType='text');
}

function updateList()
{
    $.get('./data/RKI_SurvStat_by_date_and_district/RKI_SurvStat_' + iso_date +  '.csv', function(rawdata) {
        data = $.csv.toArrays(rawdata);
        list_src = "<table>";
        for ( var i = 2; i < data.length; ++i )
            list_src += "<tr><td>" + data[i][0] + "</td><td>" + data[i][1] + "</td></tr>\n";
        list_src += "</table>";
        $("#casesByRegion").html(list_src);
    }, dataType='text');
}
