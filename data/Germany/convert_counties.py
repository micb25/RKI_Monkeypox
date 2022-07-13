#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, json

# data dumped from  
# https://services7.arcgis.com/mOBPykOjAyBO2ZKk/ArcGIS/rest/services/RKI_COVID19_Landkreise_Demo/FeatureServer/0/query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&relationParam=&returnGeodetic=false&outFields=county%2CAGS%2CBL_ID%2CEWZ&returnGeometry=false&returnCentroid=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&defaultSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token=

county_data = {}

f = open('dump_districts_pop.json')
data = json.load(f)
for r in data['features']:
    k = r['attributes']['county']
    county_data[k] = {}
    county_data[k]['pop'] = int(r['attributes']['EWZ'])
    county_data[k]['state'] = int(r['attributes']['BL_ID'])
    county_data[k]['ags'] = r['attributes']['AGS']

with open('districts.json', 'w') as g:
    json.dump(county_data, g)

f.close()