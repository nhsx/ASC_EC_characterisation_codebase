# AU_ASC_EC_characterisation
 
Overview: Characterisation of emergency care / A&E utilisation by care home residents.

Approach:  Leverages the emergency care dataset ECDS and the care home flag from the Master Patient Index, MIP (itself leveraging three methods to infer care home residency).
Descriptive statistics presented via Rmarkdown in tables and visualisations (`02-ECDSsummary_MPI.Rmd`).
A previous method using ECDS-internal variables to find a subset of care (home) users is also given (used ahead of MIP access), `01-ECDSsummary.Rmd`.
Upstream querying via SQL queries in `SQL queries` folder.
 
Output: Codebase as RMarkdown file and SQL scripts. The generated knitted file (html) is not supplied as this contains data outputs.
 
Software: SQL ; R ; RMarkdown
