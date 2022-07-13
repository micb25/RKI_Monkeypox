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
        self.dfI = None
        
        self.filename_states = self.processed_data_folder + 'RKI_Monkeypox_processed_states.csv'
        self.filename_states_latest = self.processed_data_folder + 'RKI_Monkeypox_states_sum_latest.csv'
        self.filename_ag = self.processed_data_folder + 'RKI_Monkeypox_processed_age_groups.csv'
        
        self.pop_states = {
            'Total': 83_237_124,
            'Baden-Württemberg': 11_124_642,
            'Bavaria': 13_176_989,
            'Berlin': 3_677_472,
            'Brandenburg': 2_537_868,
            'Bremen': 676_463,
            'Hamburg': 1_853_935,
            'Hesse': 6_295_017,
            'Mecklenburg-Vorpommern': 1_611_160,
            'Lower Saxony': 8_027_031,
            'North Rhine-Westphalia': 17_924_591,
            'Rhineland-Palatinate': 4_106_485,
            'Saarland': 982_348,
            'Saxony': 4_043_002,
            'Saxony-Anhalt': 2_169_253,
            'Schleswig-Holstein': 2_922_005,
            'Thuringia': 2_108_863,
            'Unknown': 0
        }
                
        
    def __get_csv_files(self):
        return sorted(glob.glob(self.raw_data_folder + "*.csv"))
    
    
    def __get_iso_date(self, filename):
        return filename[-14:-4]
    
    
    def save_CSVs(self):
        if self.dfS is not None:
            self.dfS.to_csv(self.filename_states, sep=',', decimal='.', encoding='utf-8', float_format='%.0f', index=False)
        if self.dfA is not None:
            self.dfA.to_csv(self.filename_ag, sep=',', decimal='.', encoding='utf-8', float_format='%.0f', index=False)
        if self.dfI is not None:
            self.dfI.to_csv(self.filename_states_latest, sep=',', decimal='.', encoding='utf-8', float_format='%.4f', index=False)
    
    
    def process(self):
        if len(self.csv_files) < 2:
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
        new_rows_S = []
        new_rows_A = []
        for csv in self.csv_files:
            df = pd.read_csv(csv, sep=',', decimal='.', encoding='utf-8')
            isodate = self.__get_iso_date(csv)
            
            # per state
            new_row_S = [isodate]
            new_row_S.extend(list(df['total']))
            new_rows_S.append(new_row_S)
            
            # per age group
            new_row_A = [isodate]
            new_row_A.extend(list(df.iloc[0])[1:])
            new_rows_A.append(new_row_A)
            
        self.dfS = pd.concat([self.dfS, pd.DataFrame(new_rows_S, columns=S_cols)])
        self.dfA = pd.concat([self.dfA, pd.DataFrame(new_rows_A, columns=A_cols)])
                
        self.dfS = self.dfS.convert_dtypes()
        self.dfA = self.dfA.convert_dtypes()
        
        # incidence per state
        df_temp_N = pd.read_csv(self.csv_files[-1], sep=',', decimal='.', encoding='utf-8')
        df_temp_O = pd.read_csv(self.csv_files[-2], sep=',', decimal='.', encoding='utf-8')
                
        I_cols = [ 'index', 'total_cases', 'total_incidence_1M', 'inc_cases' ]
        new_rows_I = []
        
        for i, r in df_temp_N.iterrows():
            
            new_row_I = [ r['index'], r['total'] ]
                        
            total_incidence = r['total'] / self.pop_states[r['index']] * 1_000_000 if r['index'] in self.pop_states and self.pop_states[r['index']] > 0 else 0.0
            new_cases = r['total'] - df_temp_O.iloc[i]['total'] if df_temp_O.iloc[i]['index'] == r['index'] else 0
            
            new_row_I.append( total_incidence )
            new_row_I.append(new_cases)           
            
            new_rows_I.append( new_row_I )
        
        self.dfI = pd.DataFrame(new_rows_I, columns=I_cols)        
        self.dfI = self.dfI.convert_dtypes()
        self.dfI['total_incidence_1M'] = self.dfI['total_incidence_1M'].astype(float)
        
       
if __name__ == "__main__":
    c = RKI_SurvStat_Processing()
    c.process()
    c.save_CSVs()    
