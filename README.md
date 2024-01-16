# AU_ASC_EC_characterisation

## Overview
Analysis to support the Digitising Social Care team in its pillar "to inform the choice of care Tech to support people at home/independent living".

Discovery piece on identifying patterns and needs in the use of emergency care / A&E utilisation by care home residents.


Sharepoint folder (Digital Analytics Research Team): `Documents - NHSX Analytics Unit\Prog..anch\Analytics Team\Social Care\falls and third tech`

Contacts: Emma Lenden, Digitising Social Care programme

Analysis team: legacy Digital Analytics and Research Team (DART)
 

## Aproach
Leverages the emergency care dataset ECDS and the care home flag from the Master Patient Index, MIP (itself leveraging three methods to infer care home residency).

Descriptive statistics presented via Rmarkdown in tables and visualisations (`02-ECDSsummary_MPI.Rmd`).

A previous method using ECDS-internal variables to find a subset of care (home) users is also given (used ahead of MIP access), `01-ECDSsummary.Rmd`.

Upstream querying via SQL queries in `SQL queries` folder.

 ## Output
Codebase as RMarkdown file and SQL scripts. The generated knitted file (html) is not supplied as this contains data outputs.

 ## Software
SQL ; R ; RMarkdown
