#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import pandas as pd
import numpy as np
from rki_scraper import RKI_Monkeypox_CSV

class RKI_Monkeypox_Processing:
    def __init__(self):
        self.CSV = RKI_Monkeypox_CSV()
        self.CSV_States = RKI_Monkeypox_CSV(csv_file='RKI_Monkeypox_processed_states.csv')
        self.pre_days = 7
        self.filename = os.path.dirname(os.path.realpath(__file__)) + os.sep + '..' + os.sep + 'data' + os.sep + 'RKI_Monkeypox_processed.csv'
        # population of Germany(2021-12-31)
        # taken from https://www.destatis.de
        self.pop = 83_237_124
        
    def load_CSV(self):
        self.df = pd.read_csv(self.filename, sep=',', decimal='.', encoding='utf-8')
        self.df['date'] = self.df['date'].astype('datetime64[ns]')
        self.df['date'] = pd.to_datetime(self.df['date'].dt.strftime('%Y-%m-%d'))
        
    def save_CSV(self):
        self.df['date'] = self.df['date'].astype('datetime64[ns]')
        self.df['date'] = pd.to_datetime(self.df['date'].dt.strftime('%Y-%m-%d'))
        self.df.to_csv(self.filename, sep=',', decimal='.', encoding='utf-8', float_format='%.4f', index=False)
        
    def process(self):
        # generates a date range 
        min_date = min(self.CSV.df['date'].min(), self.CSV_States.df['date'].min()) - pd.Timedelta(self.pre_days, unit='d')
        max_date = max(self.CSV.df['date'].max(), self.CSV_States.df['date'].max())
        date_range = max_date - min_date
        dr = pd.date_range(min_date, periods=date_range.days + 1, freq='d')
        
        # generates the dataframe
        table_template = {
            'date': dr,
            'total_cases': pd.to_numeric(np.zeros(shape=(len(dr))))
        }
        sum_cases = 0        
        self.df = pd.DataFrame(table_template)
        
        # fills in case counts and adds missing dates in-between
        for i, row in self.df.iterrows():
            if row['date'] in self.CSV.df['date'].values:
                sum_cases = self.CSV.df.loc[self.CSV.df['date'] == row['date']]['total_cases']
            elif row['date'] in self.CSV_States.df['date'].values:
                sum_cases = self.CSV_States.df.loc[self.CSV_States.df['date'] == row['date']]['total']
            self.df.at[i, 'total_cases'] = sum_cases
        self.df['total_cases'] = self.df['total_cases'].astype(int)
        
        # adds 7-day mean of total cases
        self.df['total_cases_7d_mean'] = self.df['total_cases'].rolling(window=7).mean().fillna(0.0)
        
        # adds total incidence
        self.df['total_incidence_100k'] = self.df['total_cases'] / self.pop * 100_000
        
        # adds increments
        self.df['inc_cases'] = self.df['total_cases'].diff(1).fillna(0.0)
        self.df['inc_cases'] = self.df['inc_cases'].astype(int)        
        
        # adds 7-day incidence
        self.df['inc_cases_7d_mean'] = self.df['inc_cases'].rolling(window=7).mean().fillna(0.0)
        self.df['7d_incidence_100k'] = self.df['inc_cases'].rolling(window=7).sum().fillna(0.0) / self.pop * 100_000 
       
if __name__ == "__main__":
    c = RKI_Monkeypox_Processing()
    c.process()
    c.save_CSV()
    