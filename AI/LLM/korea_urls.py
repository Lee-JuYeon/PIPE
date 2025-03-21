from selenium import webdriver
from selenium.webdriver.chrome.options import Options

options = Options()  # Create an options object
# options.add_argument("--headless")  # 백그라운드 실행 옵션
options.add_experimental_option("detach", True)
options.binary_location = "/usr/local/bin/chromedriver" 

# driver init
driver = webdriver.Chrome(options=options)

#get url
korea_urls = "https://www.gov.kr/portal/orgSite?srchOrder=&srchOrgCd=&srchAsndOrgClsCd=&srchOrgAstCd=ALL&srchFsOrgAstCd=ALL&jrsdOrgCdAll=&jrsdOrgAstCd=ALL&jrsdOrgAstCd=ALL&jrsdOrgAstCd=ALL&jrsdOrgAstCd=ALL&srchTxt="
driver.get(korea_urls)