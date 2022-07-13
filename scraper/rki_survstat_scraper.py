#!/usr/bin/python3
# vim: set fileencoding=utf-8

import os, time, pandas as pd
from datetime import datetime, timedelta
from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException

class RKI_SurvStat_Scraper:
    def __init__(self, data_folder='RKI_SurvStat_by_date', headless=True, verbose=False):
        self.URL = 'https://survstat.rki.de/Content/Query/Create.aspx'
        self.verbose = verbose
        self.isodate = "1970-01-01"
        self.data_folder = os.path.dirname(os.path.realpath(__file__)) + os.sep + '..' + os.sep + 'data' + os.sep + data_folder + os.sep
        self.df = None
                    
        # sets selenium settings
        self.sel_options = webdriver.ChromeOptions()
        self.sel_options.add_argument("--lang=en")
        self.sel_options.add_argument("--disable-gpu")
        self.sel_options.add_argument("--window-size=1920,1200")
        self.sel_options.add_argument("--no-sandbox")
        self.sel_options.add_argument("--disable-dev-shm-usage")
        self.sel_options.add_argument("--ignore-certificate-errors")
        self.sel_options.add_argument("--disable-extensions")
        
        if headless:
            self.sel_options.add_argument("--headless")
            
        # creates webdriver
        self.driver = webdriver.Chrome(ChromeDriverManager().install(), options=self.sel_options)
        
        self.filter_row = []
        self.filter_col = []
        self.filter_cases = []
           
        
    def wait_barrier(self, delay=3):
        if self.verbose:
            print("called wait_barrier()")
        try:
            # wait for an element at the end of the page
            WebDriverWait(self.driver, delay).until(EC.presence_of_element_located((By.ID, 'navFunctionsPrint')))
        except TimeoutException:
            if self.verbose:
                print("wait_barrier timeout!")    
        if self.verbose:
            print("leaving wait_barrier()")
        pass
    
    
    def add_case_filter(self, label, filter_value):
        self.filter_cases.append([label, filter_value])
        
    
    def set_row_filter(self, label, filter_value):
        self.filter_row = [label, filter_value]
        
        
    def set_col_filter(self, filter_value):
        self.filter_col = [filter_value]
        
        
    def get_df_filename(self):
        return self.data_folder + 'RKI_SurvStat_' + self.isodate + '.csv'
        
    
    def save_df(self, float_format='%.0f'):
        if self.df is not None:
            filename = self.get_df_filename()
            self.df.to_csv(filename, sep=',', decimal='.', encoding='utf-8', float_format=float_format, index=False)


    def was_data_scraped(self):
        return os.path.isfile( self.get_df_filename() )
    

    def check_date(self):
        try:            
            # create Selenium object to interact with site
            self.driver.get(self.URL)
            self.wait_barrier()
            
            # update timestamp
            date_div = self.driver.find_elements('xpath', './/span')
            for s in date_div:
                if 'Current' in s.text:
                    self.isodate = s.text[9:19]
                    return True
        except:
            False


    def scrape(self, show_totals=True, show_zeros=True, German=False, download_data=False, force=False):        
        try:            
            
            if not self.check_date():
                return False
            
            if self.was_data_scraped() and not force:
                return False
            
            # apply case filters
            num_filter = 0
            for case_filter in self.filter_cases:
                num_filter += 1
                
                if self.verbose:
                    print(' > applying filter {} = {}'.format(case_filter[0], case_filter[1]))
                    
                if num_filter > 1:
                    # add new filter button
                    button = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_RepeaterFilter_ImageButtonAddFilterRow')
                    button.click()
                    self.wait_barrier()
                
                # get the filter
                filter_div = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_RepeaterFilter_DropDownListFilterHierarchy_{}_chosen'.format(num_filter))
                filter_div.click()
                self.wait_barrier()
                
                disease_filter_elements = filter_div.find_elements('xpath', './/li')
                for el in disease_filter_elements:
                    if case_filter[0] in el.text:
                        el.click()
                        break            
                self.wait_barrier()
                
                # get the actual filter value
                filter_value_div = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_RepeaterFilter_RepeaterFilterLevel_{}_ListBoxFilterLevelMembers_0_chosen'.format(num_filter))
                filter_value_div.click()
                self.wait_barrier()
                
                filter_elements = filter_value_div.find_elements('xpath', './/li')
                for el in filter_elements:
                    if case_filter[1] in el.text:
                        el.click()
                        break                    
                self.wait_barrier()
                
            # apply row filter
            if len(self.filter_row) == 2:
                row_selector = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListRowHierarchy_chosen')
                row_selector.click()    
                self.wait_barrier()
                
                filter_elements = row_selector.find_elements('xpath', './/li')
                for el in filter_elements:
                    if self.filter_row[0] == el.text:
                        el.click()
                        break
                self.wait_barrier()
                
                row_value_selector = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListRow_chosen')
                row_value_selector.click()
                self.wait_barrier()
                
                filter_elements = row_value_selector.find_elements('xpath', './/li')
                for el in filter_elements:
                    if self.filter_row[1] == el.text:
                        el.click()
                        break
                self.wait_barrier()
                
            # apply col filter
            if len(self.filter_col) == 1:
                # column selector (1-year age groups)
                col_selector = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListColHierarchy_chosen')
                col_selector.click()
                self.wait_barrier()
                
                filter_elements = col_selector.find_elements('xpath', './/li')
                for el in filter_elements:
                    if self.filter_col[0] == el.text:
                        el.click()
                        break
                self.wait_barrier()
                
            # show zeros
            if show_zeros:
                button = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_CheckBoxNonEmpty')
                button.click()
                self.wait_barrier()
            
            if show_totals:
                button = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_CheckBoxTotal')
                button.click()
                self.wait_barrier()
            
            # change to German (German county names)
            if German:
                button = self.driver.find_element('id', 'LinkButtonLanguage')
                button.click()
                self.wait_barrier()
                   
            if download_data:
                button = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_ButtonDownload')
                button.click()
                self.wait_barrier()
                return True
            else:
                # get the whole table
                table = self.driver.find_element('id', 'ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_GridViewResult')
                
                if len(self.filter_col) == 1:
                    cols = ['index']
                else:
                    cols = []
                    
                # get columns
                col_labels = table.find_element('xpath', ".//tr[@class = 'ResultMinorHeader']")
                col_elements = col_labels.find_elements('xpath', ".//th")
                for c in col_elements:
                    cols.append(c.text.replace(' ', '_').lower())
                self.df = pd.DataFrame(columns=cols)
                
                # get rows
                new_data_rows = []
                data_rows = table.find_elements('xpath', ".//tr[not(contains(@class, 'ResultMinorHeader')) and not(contains(@class, 'ResultMainHeader'))]")
                for r in data_rows:
                    row_elements = r.find_elements('xpath', './/td')
                    new_row = [row_elements[0].text]
                    for i in range(1, len(row_elements)):
                        str_value = row_elements[i].text
                        new_row.append(float(str_value) if str_value != '' else 0.0)
                    new_data_rows.append(new_row)
                    
                self.df = pd.concat([self.df, pd.DataFrame(new_data_rows, columns=cols)])
                self.df = self.df.convert_dtypes()
                return True
        except:
            return False
            

if __name__ == '__main__':
        
    scraper = RKI_SurvStat_Scraper()
    scraper.add_case_filter('Disease', 'Affenpocken')
    scraper.set_col_filter('Age stratification: 5 year intervals')
    scraper.set_row_filter('State / Territorial unit / County', 'State')
    
    if scraper.scrape():
        scraper.save_df()
        
    scraper.driver.quit()
        