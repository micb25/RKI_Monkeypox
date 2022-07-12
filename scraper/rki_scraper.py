#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, re, os, sys
import pandas as pd
from datetime import date

class RKI_Monkeypox_Scraper:
    def __init__(self):
        self.URL = 'https://www.rki.de/DE/Content/InfAZ/A/Affenpocken/Ausbruch-2022-Situation-Deutschland.html'
        self.pattern = re.compile(r"stand ([0-9]{1,2})\.([0-9]{1,2})\.([0-9]{2,4})\s{1,}sind\s{1,}([0-9\.]{1,})\s{1,}affenpocken")
        self.date = None
        self.result = None
        
    def fetch_data(self):
        try:
            r = requests.get(self.URL, headers={'Pragma': 'no-cache', 'Cache-Control': 'no-cache'}, allow_redirects=True, timeout=5.0)
            if r.status_code == 200:
                pm = self.pattern.findall(r.text.lower())
                if pm is not None:
                    self.date = date(int(pm[0][2]), int(pm[0][1]), int(pm[0][0]))
                    self.result = int(pm[0][3].replace('.', ''))
                    return    
        except:
            pass
        
        self.date = None
        self.result = None
        
        
class RKI_Monkeypox_CSV:
    def __init__(self, csv_file='RKI_Monkeypox.csv', verbose=False):
        self.CSV = os.path.dirname(os.path.realpath(__file__)) + os.sep + '..' + os.sep + 'data' + os.sep + csv_file
        self.load_CSV()
        self.scraper = RKI_Monkeypox_Scraper()
        self.verbose = verbose
        
    def load_CSV(self):
        self.df = pd.read_csv(self.CSV, sep=',', decimal='.', encoding='utf-8')
        self.df['date'] = self.df['date'].astype('datetime64[ns]')
        self.df['date'] = pd.to_datetime(self.df['date'].dt.strftime('%Y-%m-%d'))
        
    def save_CSV(self):
        self.df['date'] = self.df['date'].astype('datetime64[ns]')
        self.df['date'] = pd.to_datetime(self.df['date'].dt.strftime('%Y-%m-%d'))
        self.df.to_csv(self.CSV, sep=',', decimal='.', encoding='utf-8', float_format='%.0f', index=False)
        
    def process(self):
        self.df = self.df.sort_values(by=['date', 'total_cases'])
        self.df['inc_cases'] = self.df['total_cases'].diff(1)
        self.df.at[0, 'inc_cases'] = self.df.iloc[0]['total_cases']
        
    def update(self):
        self.scraper.fetch_data()
        if self.verbose:
            print("scraper returned data: {}, {}".format(self.scraper.date, self.scraper.result))
        if self.scraper.result is not None and self.scraper.date is not None:
            if not (self.df.date == pd.Timestamp(self.scraper.date)).any():
                self.df = self.df.append({'date': self.scraper.date, 'total_cases': self.scraper.result, 'inc_cases': 0}, ignore_index=True)
                if self.verbose:
                    print("-> data added")
        self.process()
        self.save_CSV()


if __name__ == "__main__":
    c = RKI_Monkeypox_CSV(verbose=True)
    c.update()