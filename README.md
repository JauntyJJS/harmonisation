# Data Harmonisation Project Template


<a name="top"></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/JauntyJJS/harmonisation/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/JauntyJJS/harmonisation/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Table of Content

- [Motivation](#motivation)
- [Acknowledgement](#acknowledgement)
- [File Structure](#file-structure)
- [Software Installation](#software-installation)
- [R Package Installation](#r-package-installation)
- [Using `renv`](#using-renv)
- [R Functions Management](#r-functions-management)
- [R Packages Used](#r-packages-used)
- [R Platform Information](#r-platform-information)
- [Data Harmonisation Report For Each
  Cohort](#data-harmonisation-report-for-each-cohort)
- [Combined Data Harmonisation Report For All
  Cohort](#combined-data-harmonisation-report-for-all-cohort)
- [Data Harmonisation Summary](#data-harmonisation-summary)
- [General Recommendations](#general-recommendations)

## Motivation

Some large cohort studies involve the pooling of data from multiple
sites, studies or clinical trials. Prior to statistical or machine
learning analysis, a data steward must be able to not just clean but
organise and sort through these heterogeneous inputs in a standardised
and consistent format. This process is sometimes called retrospective
data harmonisation. As methods of data harmonisation for certain data
fields or variables can be complicated, it must be recorded in a
coherent way such that different stakeholders (such as your
collaborators or study committee members) can understand what is being
done to the raw/provided data. Despite its importance in the big data
environment, there are limit resources on how to document the data
harmonisation process in a structured, efficient (with some automation)
and robust way.

This repository aims to be a project template to allow a data steward to
be able to create data harmonisation reports using
[R](https://www.r-project.org/) and [Quarto](https://quarto.org/) books.
To learn more about Quarto books visit <https://quarto.org/docs/books>.

Output of these reports are as follows:

Run the R script `cohort_harmonisation_script.R` in `codes` folder to
generate:

- Cohort_A Harmonisation Report:
  - 🌐 HTML: <https://jauntyjjs-harmonisation-cohort-a.netlify.app>
  - 📕 PDF :
    <https://jauntyjjs-harmonisation-cohort-a.netlify.app/Harmonisation-Template-for-Cohort-A.pdf>
  - 📘 Word:
    <https://jauntyjjs-harmonisation-cohort-a.netlify.app/Harmonisation-Template-for-Cohort-A.docx>
- Cohort_B Harmonisation Report:
  - 🌐 HTML: <https://jauntyjjs-harmonisation-cohort-b.netlify.app>
  - 📕 PDF :
    <https://jauntyjjs-harmonisation-cohort-b.netlify.app/Harmonisation-Template-for-Cohort-A.pdf>
  - 📘 Word:
    <https://jauntyjjs-harmonisation-cohort-b.netlify.app/Harmonisation-Template-for-Cohort-A.docx>

Run the R script `cohort_all_harmonisation_script.R` in `codes` folder
to generate:

- Combined (All cohorts) Harmonisation Report:
  - 🌐 HTML: <https://jauntyjjs-harmonisation-cohort-all.netlify.app>

Run the R script `harmonisation_summary_script.R` in `codes` folder to
generate:

- Harmonisation Summary:
  - 🌐 HTML: <https://jauntyjjs-harmonisation-summary.netlify.app>
  - 📘 Word:
    <https://jauntyjjs-harmonisation-summary.netlify.app/Harmonisation-Summary-Report-Template.docx>

<a href="#top">Back to top</a>

## Acknowledgement

Layout of this page is inspired from R package
[`rcompendium`](https://frbcesab.github.io/rcompendium).

<a href="#top">Back to top</a>

## File Structure

Here is the file structure of this project.

    harmonisation/                            # Root of the project template.
    |
    ├── .quarto/ (not in repository)          # Folder to keep intermediate files/folders 
    |                                         # generated when Quarto renders the files.
    |
    ├── archive/                              # Folder to keep previous books and harmonised data.
    |   |
    │   ├── reports/                          # Folder to keep previous versions of
    |   |   |                                 # data harmonisation documentation.
    |   |   |
    |   |   ├── {some_date}_batch/            # Folder to keep {some_date} version of
    |   |   |                                 # data harmonisation documentation.
    |   |   |
    |   |   └── Flowchart.xlsx                # Flowchart sheet to record version control.
    |   |
    |   └── harmonised/                       # Folder to keep previous version of harmonised data.
    |       |
    |       ├── {some_date}_batch/            # Folder to keep {some_date} version of
    |       |                                 # harmonised data.
    |       |
    |       └── Flowchart.xlsx                # Flowchart sheet to record version control.
    |
    ├── codes/                                # Folder to keep R/Quarto scripts 
    |   |                                     # to run data harmonisation.
    |   |
    │   ├── {cohort name}/                    # Folder to keep Quarto scripts to run
    |   |   |                                 # data cleaning, harmonisation 
    |   |   |                                 # and output them for each cohort.
    |   |   |
    |   |   └── preprocessed_data/            # Folder to keep preprocessed data.
    |   |
    │   ├── harmonisation_summary/            # Folder to keep Quarto scripts to create
    |   |                                     # data harmonisation summary report.
    |   |
    │   ├── output/                           # Folder to keep harmonised data.
    |   |                                     
    |   ├── cohort_harmonisation_script.R     # R script to render each {cohort name}/ folder. 
    |   |                                     # folder into html, pdf and word document.
    |   |
    |   └── harmonisation_summary_script.R    # R script to render the {harmonisation_summary}/ 
    |                                         # folder into word document.
    │  
    ├── data-raw/                             # Folder to keep cohort raw data (.csv, .xlsx, etc.)
    |   |
    │   ├── {cohort name}/                    # Folder to keep cohort raw data.
    |   |   |
    |   |   ├── {data_dictionary}             # Data dictionary file that correspond to the 
    |   |   |                                 # cohort raw data. Can be one from the
    |   |   |                                 # collaborator provide or provided by us.
    |   |   |
    |   |   └── Flowchart.xlsx                # Flowchart sheet to record version control.
    |   |
    |   ├── data-dictionary/                  # Folder to keep data dictionary 
    |   |   |                                 # used for harmonising data.
    |   |   |
    |   |   └── Flowchart.xlsx                # Flowchart sheet to record version control.
    |   |
    |   └── data-input/                       # Folder to keep data input file 
    |       |                                 # for collaborators to fill in.
    |       |
    |       └── Flowchart.xlsx                # Flowchart sheet to record version control.
    |  
    ├── docs/                                 # Folder to keep R functions documentation 
    |                                         # generated using pkgdown:::build_site_external().
    |  
    ├── inst/                                 # Folder to keep arbitrary additional files 
    |   |                                     # to include in the project.
    |   |  
    |   └── WORDLIST                          # File generated by spelling::update_wordlist()
    |  
    ├── man/                                  # Folder to keep R functions documentation
    |   |                                     # generated using devtools::document().
    |   |
    │   ├── {fun-demo}.Rd                     # Documentation of the demo R function.
    |   |
    │   └── harmonisation-template.Rd         # High-level documentation.
    |  
    ├── R/                                    # Folder to keep R functions.
    |   |
    │   ├── {fun-demo}.R                      # Script with R functions.
    |   |
    │   └── harmonisation-package.R           # Dummy R file for high-level documentation.
    │  
    ├── renv/ (not in repository)             # Folder to keep all packages 
    |                                         # installed in the renv environment.
    | 
    ├── reports/                              # Folder to keep the most recent data harmonisation
    |                                         # documentation.
    |
    ├── templates/                            # Folder to keep template files needed to generate
    |   |                                     # data harmonisation documentation efficiently.
    |   |
    |   ├── quarto-yaml/                      # Folder to keep template files to generate 
    |   |   |                                 # data harmonisation documentation structure 
    |   |   |                                 # in Quarto. 
    |   |   |
    │   |   ├── _quarto_{cohort name}.yml     # Quarto book template data harmonisation documentation 
    |   |   |                                 # for {cohort name}.
    |   |   |
    |   |   └── _quarto_summary.yml           # Quarto book template data harmonisation summary.
    |   |
    |   └── index-qmd/                        # Folder to keep template files to generate
    |       |                                 # the preface page of the data harmonisation 
    |       |                                 # documentation.
    |       |
    |       ├── _index_report.qmd             # Preface template for each cohort data harmonisation
    |       |                                 # report. 
    |       |
    |       └── _index_summary.qmd            # Preface template for data harmonisation 
    |                                         # summary report. 
    |        
    ├── tests/                                # Folder to keep test unit files. 
    |                                         # Files will be used by R package testhat.
    |
    ├── .Rbuildignore                         # List of files/folders to be ignored while 
    │                                         # checking/installing the package.
    |
    ├── .Renviron (not in repository)         # File to set environment variables.
    |
    ├── .Rprofile (not in repository)         # R code to be run when R starts up.
    |                                         # It is run after the .Renviron file is sourced.
    |
    ├── .Rhistory (not in repository)         # File containing R command history.
    |
    ├── .gitignore                            # List of files/folders to be ignored while 
    │                                         # using the git workflow.
    |
    ├── .lintr                                # Configuration for linting
    |                                         # R projects and packages using linter.
    |        
    ├── .renvignore                           # List of files/folders to be ignored when 
    │                                         # renv is doing its snapshot.
    |
    ├── DESCRIPTION[*]                        # Overall metadata of the project.
    |
    ├── LICENSE                               # Content of the MIT license generated via
    |                                         # usethis::use_mit_license().
    |
    ├── LICENSE.md                            # Content of the MIT license generated via
    |                                         # usethis::use_mit_license().
    |
    ├── NAMESPACE                             # List of functions users can use or imported
    |                                         # from other R packages. It is generated 
    |                                         # by devtools::document().
    │        
    ├── README.md                             # GitHub README markdown file generated by Quarto.
    |
    ├── README.qmd                            # GitHub README quarto file used to generate README.md. 
    |        
    ├── _pkgdown.yml                          # Configuration for R package documentation
    |                                         # using pkgdown:::build_site_external().
    |        
    ├── _quarto.yml                           # Configuration for Quarto book generation.
    |                                         # It is also the project configuration file.
    |
    ├── csl_file.csl                          # Citation Style Language (CSL) file to ensure
    |                                         # citations follows the Lancet journal.
    |        
    ├── custom-reference.docx                 # Microsoft word template for data harmonisation 
    |                                         # documentation to Word.
    |
    ├── harmonisation_template.Rproj          # RStudio project file.
    |        
    ├── index.qmd                             # Preface page of Quarto book content.
    |        
    ├── references.bib                        # Bibtex file for Quarto book.
    |      
    └── renv.lock                             # Metadata of R packages installed generated
                                              # using renv::snapshot().

    [*] These files are automatically created but user needs to manually add some information.

<a href="#top">Back to top</a>

## Software Installation

### Installing R

Go to <https://cran.rstudio.com/>. Choose a version of R that matches
the computer’s operating system.

### Installing RStudio

Go to <https://posit.co/download/rstudio-desktop/>. Scroll down and
choose a version of RStudio that matches the computer’s operating
system.

### Installing Rtools

Go to <https://cran.r-project.org/bin/windows/Rtools/>. Choose a version
of Rtools that matches the R version that was installed.

### Quarto

Quarto converts R scripts into a technical report or notebook in html,
pdf, Microsoft Word,
[etc.](https://quarto.org/docs/output-formats/all-formats.html) It is
installed together with RStudio. User can also go to
<https://quarto.org/docs/get-started/> to install it separately. For
Quarto to be able to create pdf files, a [pdf
engine](https://quarto.org/docs/output-formats/pdf-engine.html) must be
installed as well. For ease, it is suggested to install
[TinyTex](https://yihui.org/tinytex/) using the terminal command
`quarto install tinytex`.

<a href="#top">Back to top</a>

## R Package Installation

Use Posit Public Package Manager
[PPM](https://packagemanager.posit.co/client) to set up your repository
environment to install R packages from
[CRAN](https://cloud.r-project.org/). This is because PPM allows
installation of frozen R package versions based on a snapshot date.

One way to do that is to set in the `.Rprofile` file with the code
`options(repos = c(P3M = "{link to repository url form Posit Public Package Manager}"))`

R packages can be installed using
[`pak::pkg_install()`](https://pak.r-lib.org/reference/pkg_install.html)
from the R package [`pak`](https://pak.r-lib.org/) as an alternative to
[`install.packages()`](https://rdrr.io/r/utils/install.packages.html)
and
[`remotes::install_github()`](https://remotes.r-lib.org/reference/install_github.html).
Benefits of using [`pak`](https://pak.r-lib.org/) can be found
[here](https://pak.r-lib.org/reference/features.html)

You can also view your repository environment using the command
[`pak::repo_get()`](https://pak.r-lib.org/reference/repo_get.html)

<a href="#top">Back to top</a>

## Using `renv`

You can increase reproducibility by using the package
[`renv`](https://rstudio.github.io/renv/). Install `renv` from CRAN with
`pak::pak("renv")`. If this is your first time using `renv`, start with
the
[`Introduction to renv vignette`](https://rstudio.github.io/renv/articles/renv.html).
Use `renv::init(bare = TRUE)` to start with an empty `renv` environment.

`renv` will freeze the exact package versions you depend on (in
`renv.lock`). This ensures that each collaborator (or you in the future)
will use the exact same versions of these packages. Moreover `renv`
provides to each project its own private package library making each
project isolated from others.

Install required dependencies locally with
[`pak::pkg_install()`](https://pak.r-lib.org/reference/pkg_install.html)
from [CRAN](https://cran.r-project.org/),
[Bioconductor](https://www.bioconductor.org/),
[R-universe](https://r-universe.dev/search), etc.

Sometimes the right
[downloader](https://community.rstudio.com/t/can-not-install-packages-after-initializing-renv/106064)
(libcurl or others) needs to set for installation of R packages inside
the `renv` environment to be successful. Setting the R environmental
variable RENV_DOWNLOAD_FILE_METHOD = “libcurl” may help.

Save the local environment with
[`renv::snapshot()`](https://rstudio.github.io/renv/reference/snapshot.html)
to create the `renv.lock` file.

<a href="#top">Back to top</a>

## R Functions Management

R functions heavily used in this project can be found in the `R` folder.
Documentation (`man` folder), test units (`test` folder) corresponding
to these functions are structured the same as creating an R package.
Relevant R packages required for R package development (and available on
Posit Public Package Manager
[PPM](https://packagemanager.posit.co/client)) are

| package | description | version | date | source | repository |
|:---|:---|:---|:---|:---|:---|
| covr | Test Coverage for Packages | 3.6.4 | 2023-11-09 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| devtools | Tools to Make Developing R Packages Easier | 2.4.5 | 2022-10-11 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| lintr | A ‘Linter’ for R Code | 3.2.0 | 2025-02-12 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| pkgdown | Make Static HTML Documentation for a Package | 2.1.1 | 2024-09-17 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| roxygen2 | In-Line Documentation for R | 7.3.2 | 2024-06-28 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| sinew | Package Development Documentation and Namespace Management | 0.4.0 | 2022-03-31 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| spelling | Tools for Spell Checking in R | 2.3.1 | 2024-10-04 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| testthat | Unit Testing for R | 3.2.3 | 2025-01-13 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| usethis | Automate Package and Project Setup | 3.1.0 | 2024-11-26 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |

Here is an example of the command to use `pak::pak("{package name}")` to
install packages from the Posit Public Package Manager
[PPM](https://packagemanager.posit.co/client).

There is no need to source the functions in the `R` folder. Use
[`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html)
instead.
[`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html)
will load required dependencies listed in `DESCRIPTION` and R functions
stored in `R/`. Prior installation of these dependencies is required for
the load to be successful.

After loading, R functions can be documented (using
[`devtools::document()`](https://devtools.r-lib.org/reference/document.html)),
tested (using
[`devtools::test()`](https://devtools.r-lib.org/reference/test.html) and
then
[`devtools::check()`](https://devtools.r-lib.org/reference/check.html))
and even installed as an R package (using
[`devtools::install`](https://devtools.r-lib.org/reference/install.html)).

More information of this workflow can be found in [Chapter 1: The Whole
Game](https://r-pkgs.org/whole-game.html) of the R Packages (2e) book.

Documentation of the functions in the `R` folder can be found in
<https://jauntyjjs.github.io/harmonisation/reference/index.html>.

## R Packages Used

R packages installed from Posit Public Package Manager
[PPM](https://packagemanager.posit.co/client) or
[CRAN](https://cran.r-project.org/) using command
`pak::pkg_install("{package name}")` are

Here are all the R packages used in this analysis.

| package | title | version | date | source | repository |
|:---|:---|:---|:---|:---|:---|
| cli | Helpers for Developing Command Line Interfaces | 3.6.4 | 2025-02-13 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| dplyr | A Grammar of Data Manipulation | 1.1.4 | 2023-11-17 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| flextable | Functions for Tabular Reporting | 0.9.7 | 2024-10-27 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| fontawesome | Easily Work with ‘Font Awesome’ Icons | 0.5.3 | 2024-11-16 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| forcats | Tools for Working with Categorical Variables (Factors) | 1.0.0 | 2023-01-29 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| fs | Cross-Platform File System Operations Based on ‘libuv’ | 1.6.5 | 2024-10-30 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| fst | Lightning Fast Serialization of Data Frames | 0.9.8 | 2022-02-08 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| ftExtra | Extensions for ‘Flextable’ | 0.6.4 | 2024-05-10 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| glue | Interpreted String Literals | 1.8.0 | 2024-09-30 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| harmonisation | Utility Functions For A Data Harmonisation Project | 1.0.0.0 | 2025-03-14 | local | NA |
| here | A Simpler Way to Find Your Files | 1.0.1 | 2020-12-13 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| htmltools | Tools for HTML | 0.5.8.1 | 2024-04-04 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| htmlwidgets | HTML Widgets for R | 1.6.4 | 2023-12-06 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| knitr | A General-Purpose Package for Dynamic Report Generation in R | 1.49 | 2024-11-08 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| magrittr | A Forward-Pipe Operator for R | 2.0.3 | 2022-03-30 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| openxlsx | Read, Write and Edit xlsx Files | 4.2.8 | 2025-01-25 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| pointblank | Data Validation and Organization of Metadata for Local and Remote Tables | 0.12.2 | 2024-10-23 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| purrr | Functional Programming Tools | 1.0.4 | 2025-02-05 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| quarto | R Interface to ‘Quarto’ Markdown Publishing System | 1.4.4 | 2024-07-20 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| reactable | Interactive Data Tables for R | 0.4.4 | 2023-03-12 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| readxl | Read Excel Files | 1.4.4 | 2025-02-27 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| renv | Project Environments | 1.1.2 | 2025-03-03 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| rlang | Functions for Base Types and Core R and ‘Tidyverse’ Features | 1.1.5 | 2025-01-17 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| rmarkdown | Dynamic Documents for R | 2.29 | 2024-11-04 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| sessioninfo | R Session Information | 1.2.2 | 2021-12-06 | CRAN (R 4.4.2) | https://cran.rstudio.com |
| stringr | Simple, Consistent Wrappers for Common String Operations | 1.5.1 | 2023-11-14 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| testthat | Unit Testing for R | 3.2.3 | 2025-01-13 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| tibble | Simple Data Frames | 3.2.1 | 2023-03-20 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| tidyr | Tidy Messy Data | 1.3.1 | 2024-01-24 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |
| vroom | Read and Write Rectangular Text Data Quickly | 1.6.5 | 2023-12-05 | RSPM | https://packagemanager.posit.co/cran/2025-03-06 |

<a href="#top">Back to top</a>

## R Platform Information

Here are the R platform environment used in this analysis.

| setting | value |
|:---|:---|
| version | R version 4.4.2 (2024-10-31 ucrt) |
| os | Windows 11 x64 (build 26100) |
| system | x86_64, mingw32 |
| ui | RTerm |
| language | (EN) |
| collate | English_Singapore.utf8 |
| ctype | English_Singapore.utf8 |
| tz | Asia/Singapore |
| date | 2025-03-14 |
| pandoc | 3.2 @ C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools/ (via rmarkdown) |
| quarto | 1.6.37 @ C:/Program Files/Quarto/bin/quarto.exe/ (via quarto) |
| knitr | 1.49 from RSPM |

<a href="#top">Back to top</a>

## Data Harmonisation Report For Each Cohort

To start the harmonisation of data, run the R script
`cohort_harmonisation_script.R` in `codes` folder. The script will clean
and harmonise the raw data and create a Quarto harmonisation report book
for each cohort in html, word and pdf.

This involves

- copying a specific `yml` file (`_quarto_{cohort name}.yml`) from the
  `templates/quarto-yaml` folder to the project folder `harmonisation`
  and rename it as `_quarto.yml`, overwriting any existing `_quarto.yml`
  file.
- copying a specific `qmd` file (`_index_report.qmd`) from the
  `templates/index-qmd` folder to the project folder `harmonisation` and
  rename it as `index.qmd`, overwriting any existing `index.qmd` file.

Using the `_quarto.yml`, `index.qmd`, `references.bib` and
`csl_file.csl` files, Quarto will then start running the Quarto scripts
in the `codes/{cohort_name}` folder. This involves reading the raw data
in the `data-raw/{cohort_name}` folder, placing preprocessing data in
the `codes/{cohort_name}/preprocessed_data` folder, outputting the
harmonised data as excel file called `harmonised_{cohort_name}.xlsx` in
the `codes/output/harmonised` folder. Also, the data harmonisation
process documentation will be created in the `reports/{cohort_name}`
folder as a Quarto book in html, word and pdf.

<a href="#top">Back to top</a>

## Combined Data Harmonisation Report For All Cohort

To start the harmonisation of data, run the R script
`cohort_all_harmonisation_script.R` in `codes` folder. The script will
clean and harmonise the raw data and create a Quarto harmonisation
report (all cohort combined) book in html.

This involves

- copying a specific `yml` file (`_quarto_all.yml`) from the
  `templates/quarto-yaml` folder to the project folder `harmonisation`
  and rename it as `_quarto.yml`, overwriting any existing `_quarto.yml`
  file.
- copying a specific `qmd` file (`_index_report.qmd`) from the
  `templates/index-qmd` folder to the project folder `harmonisation` and
  rename it as `index.qmd`, overwriting any existing `index.qmd` file.

Using the `_quarto.yml`, `index.qmd`, `references.bib` and
`csl_file.csl` files, Quarto will then start running the Quarto scripts
in the `codes/{cohort_name}` folder. This involves reading the raw data
in the `data-raw/{cohort_name}` folder, placing preprocessing data in
the `codes/{cohort_name}/preprocessed_data` folder, outputting the
harmonised data as excel file called `harmonised_{cohort_name}.xlsx` in
the `codes/output/harmonised` folder. Also, the data harmonisation
process documentation will be created in the `reports/all` folder as a
Quarto book in html.

A harmonisation report file can consist of a few hundred pages. It is
not recommended to output the combined report as one pdf or word
document file because the file size may be too large and it takes a long
time to open the file.

<a href="#top">Back to top</a>

## Data Harmonisation Summary

To start creating the data harmonisation summary document, run the R
script `harmonisation_summary_script.R` in `codes` folder. The script
will create the document in word.

This involves

- copying a specific `yml` file (`_quarto_summary.yml`) from the
  `templates/quarto-yaml` folder to the project folder `harmonisation`
  and rename it as `_quarto.yml`, overwriting any existing `_quarto.yml`
  file.
- copying a specific `qmd` file (`_index_summary.qmd`) from the
  `templates/index-qmd` folder to the project folder `harmonisation` and
  rename it as `index.qmd`, overwriting any existing `index.qmd` file.

Using the `_quarto.yml`, `index.qmd`, `references.bib` and
`csl_file.csl` files, Quarto will then start running the Quarto scripts
in the `codes/harmonisation_summary` folder. The data harmonisation
summary documentation will be created in the
`reports/harmonisation_summary_report` folder as a Quarto book in word.

<a href="#top">Back to top</a>

## General Recommendations

- Ensure the workspace is always in a blank state. Use
  [`usethis::use_blank_slate(scope = c("user", "project"))`](https://usethis.r-lib.org/reference/use_blank_slate.html)
  to create this setting.
- Keep the root of the project as clean as possible
- Store your raw data in `data-raw`
- Document raw data, data dictionary, data input file and archived files
  modifications in `Flowchart.xlsx` provided.
- Export modified raw data in `codes/{cohort_name}/preprocessed_data`
- Store only **R functions** in `R/`
- Store only **R scripts** and/or **qmd** in
  `codes/{cohort_name}_Cleaning`
- Built relative paths using
  [`here::here()`](https://here.r-lib.org/reference/here.html)
- Call external functions as `{package_name}::{function()}`
- Use
  [`devtools::document()`](https://devtools.r-lib.org/reference/document.html)
  to update the `NAMESPACE`
- Do not source your functions but use instead
  [`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html).
  [`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html)
  will load required dependencies listed in `DESCRIPTION` and R
  functions stored in `R/`

<a href="#top">Back to top</a>
