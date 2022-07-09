#!/usr/bin/python3
# vim: set fileencoding=utf-8

from rki_survstat_scraper import RKI_SurvStat_Scraper

if __name__ == '__main__':
        
    district_scraper = RKI_SurvStat_Scraper(data_folder='RKI_SurvStat_by_date_and_district')
    district_scraper.add_case_filter('Disease', 'Affenpocken')
    district_scraper.set_col_filter('Age stratification: 5 year intervals')
    district_scraper.set_row_filter('State / Territorial unit / County', 'County')
    
    if district_scraper.scrape(German=True):
        district_scraper.save_df()
        
    district_scraper.driver.quit()
    