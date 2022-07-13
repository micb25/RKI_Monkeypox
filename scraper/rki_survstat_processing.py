#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, glob
import pandas as pd

class RKI_SurvStat_Processing:
    def __init__(self):
        self.processed_data_folder = os.path.dirname(os.path.realpath(__file__)) + os.sep + '..' + os.sep + 'data' + os.sep
        self.raw_data_folder = self.processed_data_folder + 'RKI_SurvStat_by_date' + os.sep
        self.csv_files = self.__get_csv_files()
        self.date_min = self.__get_iso_date(self.csv_files[0])
        self.date_max = self.__get_iso_date(self.csv_files[-1])
        self.dfA = None
        self.dfS = None
        
        self.filename_states = self.processed_data_folder + 'RKI_Monkeypox_processed_states.csv'
        self.filename_states_latest = self.processed_data_folder + 'RKI_Monkeypox_states_sum_latest.csv'
        self.filename_ag = self.processed_data_folder + 'RKI_Monkeypox_processed_age_groups.csv'
                
        
    def __get_csv_files(self):
        return sorted(glob.glob(self.raw_data_folder + "*.csv"))
    
    
    def __get_iso_date(self, filename):
        return filename[-14:-4]
    
    
    def save_CSVs(self):
        if self.dfS is not None:
            self.dfS.to_csv(self.filename_states, sep=',', decimal='.', encoding='utf-8', float_format='%.0f', index=False)
        if self.dfA is not None:
            self.dfA.to_csv(self.filename_ag, sep=',', decimal='.', encoding='utf-8', float_format='%.0f', index=False)
        if len(self.csv_files) > 0:
            os.system('cp {} {}'.format(self.csv_files[-1], self.filename_states_latest))
    
    
    def process(self):
        if len(self.csv_files) < 1:
            return
        
        # read the first CSV file
        df_temp = pd.read_csv(self.csv_files[0], sep=',', decimal='.', encoding='utf-8')
        
        # create dataframe 'states'
        S_cols = ['date', 'total']
        S_cols.extend(list(df_temp['index'])[1:])                
        self.dfS = pd.DataFrame([], columns=S_cols)
        
        # create dataframe 'age_groups'
        A_cols = ['date', 'total']
        A_cols.extend(list(df_temp.columns)[2:])
        self.dfA = pd.DataFrame([], columns=A_cols)
        
        # iterate data
        for csv in self.csv_files:
            df = pd.read_csv(csv, sep=',', decimal='.', encoding='utf-8')
            isodate = self.__get_iso_date(csv)
            
            # per state
            new_row_S = [isodate]
            new_row_S.extend(list(df['total']))            
            self.dfS = pd.concat([self.dfS, pd.DataFrame([new_row_S], columns=S_cols)])
            
            # per age group
            new_row_A = [isodate]
            new_row_A.extend(list(df.iloc[0])[1:])
            self.dfA = pd.concat([self.dfA, pd.DataFrame([new_row_A], columns=A_cols)])
                
        self.dfS = self.dfS.convert_dtypes()
        self.dfA = self.dfA.convert_dtypes()
        
       
if __name__ == "__main__":
    c = RKI_SurvStat_Processing()
    c.process()
    c.save_CSVs()    
