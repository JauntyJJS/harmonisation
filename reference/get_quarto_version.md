# Print Quarto Version

A function that gives some information on which version of Quarto is
used and its location. We can't name it as get_quarto_version

## Usage

``` r
get_quarto_version(test_sys_path = FALSE, test_no_path = FALSE)
```

## Arguments

- test_sys_path:

  Set to TRUE if we want to test the program finding Quarto in a system
  environment. Default: FALSE

- test_no_path:

  Set to TRUE if we want to test when a path to Quarto does not exist.
  Default: FALSE

## Value

A vector of text indicating the Quarto version and where is it found in
the computer.

## Examples

``` r

quarto_version <- get_quarto_version()
```
