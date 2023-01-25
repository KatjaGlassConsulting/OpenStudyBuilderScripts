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
\doc\Steps.pptx | Work in progress - what has been tried out (data import via .csv - that's not recommended)
\scripts\test_api_connection.py | Test setup API connection, executable from data-import location (see Steps.pptx)
\scripts\api_example_call.sas | Example to call API from SAS
\scripts\api_example_calls.R | Example to call API from R



## Contribution

Contribution is very welcome. When you contribute to this repository you are doing so under the below licenses. Please checkout [Contribution](CONTRIBUTING.md) for additional information. All contributions must adhere to the following [Code of Conduct](CODE_OF_CONDUCT.md).

## License

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg) ![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-blue.svg)

### Code & Scripts

This project is using the [MIT](http://www.opensource.org/licenses/MIT "The MIT License | Open Source Initiative") license (see [`LICENSE`](LICENSE)) for code and scripts.

### Content

The content files like documentation and minutes are released under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). This does not include trademark permissions.

## Re-use

When you re-use the source, keep or copy the license information also in the source code files. When you re-use the source in proprietary software or distribute binaries (derived or underived), copy additionally the license text to a third-party-licenses file or similar.

When you want to re-use and refer to the content, please do so like the following:

> Content based on [OpenStudyBuilderScripts (GitHub)](https://github.com/KatjaGlassConsulting/OpenStudyBuilderScripts) used under the [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.