% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/integer-check.R
\name{is_integer_vector}
\alias{is_integer_vector}
\title{Is Integer Vector}
\usage{
is_integer_vector(input_vector, allow_na = FALSE)
}
\arguments{
\item{input_vector}{The input vector}

\item{allow_na}{If true, NA values
are ignored and output is considered TRUE.
Default: FALSE}
}
\value{
A boolean vector indicating TRUE
when the input element is an integer and
FALSE otherwise.
}
\description{
Function to check if the input
vector contains only integers.
}
\details{
We assume the input vector is numeric.
If it is not, all elements will be given
a FALSE value.
}
\examples{

# An integer
is_integer_vector(c(1, 2, 3))

# Not an integer
is_integer_vector(c(1.1, 2, 3))

# Not numeric vector
# R converts c(1, 2, "3") to c("1", "2", "3")
is_integer_vector(c(1, 2, "3"))

# NA cases
is_integer_vector(c(1, NA, 3), allow_na = FALSE)
is_integer_vector(c(1, NA, 3), allow_na = TRUE)

}
