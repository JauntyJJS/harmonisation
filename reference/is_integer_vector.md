# Is Integer Vector

Function to check if the input vector contains only integers.

## Usage

``` r
is_integer_vector(input_vector, allow_na = FALSE)
```

## Arguments

- input_vector:

  The input vector

- allow_na:

  If true, NA values are ignored and output is considered TRUE. Default:
  FALSE

## Value

A boolean vector indicating TRUE when the input element is an integer
and FALSE otherwise.

## Details

We assume the input vector is numeric. If it is not, all elements will
be given a FALSE value.

## Examples

``` r

# An integer
is_integer_vector(c(1, 2, 3))
#> [1] TRUE TRUE TRUE

# Not an integer
is_integer_vector(c(1.1, 2, 3))
#> [1] FALSE  TRUE  TRUE

# Not numeric vector
# R converts c(1, 2, "3") to c("1", "2", "3")
is_integer_vector(c(1, 2, "3"))
#> [1] FALSE FALSE FALSE

# NA cases
is_integer_vector(c(1, NA, 3), allow_na = FALSE)
#> [1]  TRUE FALSE  TRUE
is_integer_vector(c(1, NA, 3), allow_na = TRUE)
#> [1] TRUE TRUE TRUE
```
