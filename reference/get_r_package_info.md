# Get R Package Information

A function that gives some information on the loaded libraries used in a
script or project.

## Usage

``` r
get_r_package_info()
```

## Value

A tibble with four columns \`package\`, \`version\`, \`date\` and
\`source\`.

- \`package\`: The name of the loaded package.

- \`version\`: The version number of the loaded package.

- \`date\`: The date of the loaded package was installed.

- \`source\`: The source where the loaded package was installed.

## Examples

``` r
library("dplyr")
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union

r_package_info <- get_r_package_info()

r_package_info
#> # A tibble: 3 × 4
#>   package       version date       source
#>   <chr>         <chr>   <chr>      <chr> 
#> 1 dplyr         1.1.4   2023-11-17 RSPM  
#> 2 harmonisation 1.0.0.0 2025-11-12 local 
#> 3 knitr         1.50    2025-03-16 RSPM  
```
