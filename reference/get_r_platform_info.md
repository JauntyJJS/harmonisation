# Get R Platform Information

A function that gives some information on the R platform environment
used in a script or project.

## Usage

``` r
get_r_platform_info()
```

## Value

A tibble with two columns \`setting\`, and \`value\`.

- \`setting\`: The name of the settings like R version, OS, etc.

- \`value\`: The value of the setting. Usually the version number of the
  settings.

## Examples

``` r

r_platform_table <- get_r_platform_info
```
