% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/r-environment.R
\name{get_r_platform_info}
\alias{get_r_platform_info}
\title{Get R Platform Information}
\usage{
get_r_platform_info()
}
\value{
A tibble with two columns `setting`,
and `value`.
\itemize{
  \item `setting`: The name of the settings like R version, OS, etc.
  \item `value`: The value of the setting. Usually the version number of the settings.
}
}
\description{
A function that gives some
information on the R platform environment used
in a script or project.
}
\examples{

r_platform_table <- get_r_platform_info

}
