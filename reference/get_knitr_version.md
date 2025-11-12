# Get \`knitr\` Version

A function that gives some information on the loaded library \`knitr\`.

## Usage

``` r
get_knitr_version()
```

## Value

A text saying the version number and where it is downloaded from.

## Examples

``` r
library("knitr")

knitr_info <- get_knitr_version()

knitr_info
#> [1] "1.50 from RSPM"
```
