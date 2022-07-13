#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, glob, json
import pandas as pd

class RKI_SurvStat_District_Processing:
    def __init__(self):
        self.processed_data_folder = os.path.dirname(os.path.realpath(__file__)) + os.sep + '..' + os.sep + 'data' + os.sep
        self.raw_data_folder = self.processed_data_folder + 'RKI_SurvStat_by_date_and_district' + os.sep
        self.csv_files = self.__get_csv_files()
        self.date_min = self.__get_iso_date(self.csv_files[0])
        self.date_max = self.__get_iso_date(self.csv_files[-1])
        self.dfD = None
        
        self.district_data = None
        self.__get_district_data()    
        
        self.filename_districts = self.processed_data_folder + 'RKI_Monkeypox_processed_districts_latest.csv'
        
        
    def __get_csv_files(self):
        return sorted(glob.glob(self.raw_data_folder + "*.csv"))
    
    
    def __get_iso_date(self, filename):
        return filename[-14:-4]
    
    
    def __get_district_data(self):
        f = open(self.processed_data_folder + os.sep + 'Germany' + os.sep + 'districts.json')
        self.district_data = json.load(f)
        f.close()
        pass
    
    
    def save_CSV(self):
        if self.dfD is not None:
            self.dfD.to_csv(self.filename_districts, sep=',', decimal='.', encoding='utf-8', float_format='%.4f', index=False)
    
    
    def process(self):
        if len(self.csv_files) < 2:
            return
        
        # create dataframe 'states'
        D_cols = ['district', 'population', 'total_cases', 'total_incidence_1M', 'inc_cases' ]
        self.dfD = pd.DataFrame([], columns=D_cols)
        
        # iterate latest data
        csv_new = self.csv_files[-1]
        csv_old = self.csv_files[-2]
        dfN = pd.read_csv(csv_new, sep=',', decimal='.', encoding='utf-8')
        dfO = pd.read_csv(csv_old, sep=',', decimal='.', encoding='utf-8')
        
        # per district
        row_D = []
        for i, r in dfN.iterrows():
            
            # skip sum row
            if i == 0:
                continue
            
            new_cases = r['gesamt'] - dfO.iloc[i]['gesamt'] if dfO.iloc[i]['index'] == r['index'] else 0            
            pop = self.district_data[ r['index'] ]['pop'] if r['index'] in self.district_data else 0            
            total_incidence = r['gesamt'] / pop * 1_000_000 if pop > 0 else 0.0
            
            row_D.append( [ r['index'], pop, r['gesamt'], total_incidence, new_cases ] )
        
        self.dfD = pd.concat([self.dfD, pd.DataFrame(row_D, columns=D_cols)])
        self.dfD = self.dfD.convert_dtypes()
        self.dfD['total_incidence_1M'] = self.dfD['total_incidence_1M'].astype(float)
        
       
if __name__ == "__main__":
    c = RKI_SurvStat_District_Processing()
    c.process()
    c.save_CSV()    
