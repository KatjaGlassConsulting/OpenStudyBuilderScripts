# How to create SBOM files for Java files using build.gradle

## Create a JSON file with all license information

The plugin [dependency-license-report](https://github.com/jk1/Gradle-License-Report) provides an easy opportunity to create a JSON file with all license information. For this the build.gradle needs to be updated to include the plugin and the following settings:

Updates in `build.gradle`:

```
plugins {
    id 'com.github.jk1.dependency-license-report' version '2.5'
}

import com.github.jk1.license.render.*
import com.github.jk1.license.importer.*

licenseReport {
    renderers = [new JsonReportRenderer('third-party-libs.son')]
}
```

Execution of the plugin to create the JSON file on the command line:

```
gradle generateLicenseReport
```

## Create SBOM out of JSON

The following python program could be used to create the SBOM file out of the JSON - Paths might need updates:

```py
import json
import requests
from bs4 import BeautifulSoup

file_path = 'C:/temp/git/OpenStudyBuilder-collab/studybuilder-ddf-api-adaptor/ddf-studybuilder-translator/third-party-libs.json'

with open(file_path, 'r') as json_file:
    sbomData = json.load(json_file)

dependencies_list = sbomData['dependencies']
unique_urls = set()

for dependency in dependencies_list:
    if 'moduleLicenseUrl' in dependency:
        unique_urls.add(dependency['moduleLicenseUrl'])
    elif dependency['moduleName'] == 'com.fasterxml.jackson:jackson-bom' and dependency['moduleVersion'] == '2.14.2':
        dependency['moduleLicenseUrl'] = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
    elif dependency['moduleName'] == 'com.google.cloud:libraries-bom' and dependency['moduleVersion'] == '25.4.0':
        dependency['moduleLicenseUrl'] = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
    else:
        print('missing URL ' + dependency['moduleName'])
        
    
for url in unique_urls:
    print(url)

def getContentFromUrl(url):
    aUrl = url;
    
    if "https://github.com" in url:
        aUrl = aUrl.replace('https://github.com','https://raw.githubusercontent.com')
        aUrl = aUrl.replace('/blob/','/')
        
    # include raw text file
    if '.txt' in aUrl or 'raw.githubusercontent.com' in aUrl:
        response = requests.get(aUrl)
        if response.status_code == 200:
            content = response.text
            return content
        else:
            print("Failed to fetch the content from the URL: " + url)
     
    # read from opensource.org 
    if 'opensource.org/' in aUrl:
        response = requests.get(aUrl)
        html_content = response.content
        soup = BeautifulSoup(html_content, 'html.parser')
        entry_content_div = soup.find('div', class_='entry-content')
        return str(entry_content_div)
    
    print('not processed ' + url)
    
    return ''

with open('sbom.md', 'w', encoding='utf-8') as file:
    file.write('## Installed packages\n\n')
    file.write('Module | Version | License URL\n-- | -- | --\n')
    for dependency in dependencies_list:
        file.write(dependency['moduleName'] + '|' + dependency['moduleVersion'] + '|' + dependency['moduleLicenseUrl'] + '\n')
    file.write('\n\n')
    file.write('## Third-party package licenses\n\n---\n\n')
    for url in unique_urls:
        file.write('### License for ' + url + '\n\n')
        file.write(getContentFromUrl(url))
        file.write('\n\n\n---\n\n\n')

```