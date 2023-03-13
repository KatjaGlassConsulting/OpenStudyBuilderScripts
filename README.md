# OpenStudyBuilderScripts

Area to create programs and similar related to the OpenStudyBuilder to share scripts and similar.

## Structure and Origins

There are two sets of demonstration data used. One is the CDISC Pilot study with updates from the PHUSE TDF project and a SEND example study, both studies are located in the [PHUSE Script repository](https://github.com/phuse-org/phuse-scripts).

Study | Folder | Origin
-- | -- | --
CDISC Pilot Study | data/cdisc_pilot | https://github.com/phuse-org/phuse-scripts/tree/master/data/sdtm/TDF_SDTM_v1.0 (1) <br/>https://github.com/cdisc-org/sdtm-adam-pilot-project (2)
SEND Example (Vacc4) | data/send_vacc4 | https://github.com/phuse-org/phuse-scripts/tree/master/data/send/CBER-POC-Pilot-Study4-Vaccine (1)

File | Description
-- | -- 
data/cdisc_pilot/TrialDomains.xlsx | XPT files of TA, TI, TS, TV (1)
data/cdisc_pilot/cdiscpilot01_study_report.pdf | Study Report (2)
data/send_vacc4/TrialDomains.xlsx | XPT files of TA, TE, TS, TX (1)

## Documentation

File | Description 
-- | --
[\doc\InstallationExperiences.md](./doc/InstallationExperiences.md) | Installation commands and experiences (Windows 10)
[\doc\InstallationExpStandards.md](./doc/InstallationExpStandards.md) | Installation commands and experiences for Standard Imports(Windows 10)
[\doc\Backups.md](./doc/Backups.md) | Backups comments (Windows 10)
[\doc\LocalApplicationUpdated.md](./doc/LocalApplicationUpdated.md) | Run and change application locally
[\doc\ProtocolAutomation.md](./doc/ProtocolAutomation.md) | Options for implementing Protocol Automations
[\doc\CreateContentComments.md](./doc/CreateContentComments.md) | Explanation for **Webpage**: Utilizing API to have a webpage to create Clinical Programs, Projects and Studies from Trial Domains
\doc\Steps.pptx | To **ignore** - Work in progress - what has been tried out (data import via .csv - that's not recommended)

## Programs

File | Description 
-- | --
[\scripts\test_api_connection.py](./scripts/test_api_connection.py) | Test setup API connection, executable from data-import location (see Steps.pptx)
[\scripts\api_example_call.sas](./scripts/api_example_call.sas) | Example to call API from SAS
[\scripts\api_example_calls.R](./scripts/api_example_calls.R) | Example to call API from R
[\scripts\protocol_automation_example.R](./scripts/protocol_automation_example.R) | Example for protocol automation in R

**Webpage**: Utilizing API to have a webpage to create Clinical Programs, Projects and Studies from Trial Domains

File | Description 
-- | --
[\scripts\createContent.html](./scripts/createContent.html) | Webpage to perform tasks (needs connectes js file)
[\scripts\createContentScripts.js](./scripts/createContentScripts.js) | Functions to perform tasks (needed by webpage)
[\scripts\protocol_automation_example.R](./scripts/read_trial_domains_to_json.sas) | SAS program & macros to create trial domain JSONs 


## Contribution

Contribution is very welcome. When you contribute to this repository you are doing so under the below license (unlicense). Please checkout [Contribution](CONTRIBUTING.md) for additional information. All contributions must adhere to the following [Code of Conduct](CODE_OF_CONDUCT.md).

## License

![Unlicense](https://img.shields.io/badge/License-unlicense-blue.svg)

### Code, Scripts & Content (not referenced in third-party-licenses)

This project is using "Unlicence", feel free to use the scripts and documentation as you like without warrenty or the need to reference. Some content might come from third party using a different license, that license should always apply (e.g. example datasets copied/modified from PHUSE Script repository using MIT) - I store a third-party-licens.md file along those.
