# Naming convention

## Style

* lowercase
* snake_case (A)
* no abbreviation or shortening (B)

--

(A) Google Cloud resource names(ID) use hyphens instead of underscore 

e.g.

prj_app_d (Terraform ID) => prj-app-d (Google Cloud ID)

--

(B) Google Cloud resource names(ID) has length limits of 62 characters(Project ID are limited to 30 characters). 

e.g.

project - prj
group - grp


### Google cloud common abbreviation
project -  prj
folder - fldr
service_account - sa
development - d
production - p
stage - s
shared - sh
