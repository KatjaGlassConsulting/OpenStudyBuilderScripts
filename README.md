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

## Programs and Documentation

File | Description 
-- | --
\doc\InstallactionExperiences.md | Installation commands and experiences (Windows 10)
\doc\LocalApplicationUpdated.md | Run and change application locally
\doc\Steps.pptx | Work in progress - what has been tried out (data import via .csv - that's not recommended)
\scripts\test_api_connection.py | Test setup API connection, executable from data-import location (see Steps.pptx)
\scripts\api_example_call.sas | Example to call API from SAS
\scripts\api_example_calls.R | Example to call API from R

## Contribution

Contribution is very welcome. When you contribute to this repository you are doing so under the below license (unlicense). Please checkout [Contribution](CONTRIBUTING.md) for additional information. All contributions must adhere to the following [Code of Conduct](CODE_OF_CONDUCT.md).

## License

![Unlicense](https://img.shields.io/badge/License-unlicense-blue.svg)

### Code, Scripts & Content (not referenced in third-party-licenses)

This project is using "Unlicence", feel free to use the scripts and documentation as you like without warrenty or the need to reference. Some content might come from third party using a different license, that license should always apply (e.g. example datasets copied/modified from PHUSE Script repository using MIT) - I store a third-party-licens.md file along those.
