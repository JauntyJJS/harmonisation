library(quarto)
library(fs)
library(here)
library(purrr)

copy_and_render <- function(
    cohort,
    quarto_yml_folder = "quarto-yaml-template"
) {
  quarto_yml_file <- paste0(
    "_quarto_",
    cohort,
    ".yml"
  )

  fs::file_copy(
    path = here::here(
      quarto_yml_folder,
      quarto_yml_file),
    new_path = here::here("_quarto.yml"),
    overwrite = TRUE
  )

  quarto::quarto_render(
    as_job = FALSE
  )
}

# Render each cohort ----

cohort_name <- c("Cohort_A", "Cohort_B")

purrr::walk(
  .x = cohort_name,
  .f = ~copy_and_render(
    cohort = .x,
    quarto_yml_folder = "quarto-yaml-template"
  )
)



