library(quarto)
library(fs)
library(here)
library(purrr)

# Copy the right index.qmd file

index_qmd_file <- paste0(
  "_index_",
  "report",
  ".qmd"
)

fs::file_copy(
  path = here::here(
    "templates",
    "index-qmd",
    index_qmd_file),
  new_path = here::here("index.qmd"),
  overwrite = TRUE
)

copy_and_render <- function(
    cohort
) {

  quarto_yml_file <- paste0(
    "_quarto_",
    cohort,
    ".yml"
  )

  fs::file_copy(
    path = here::here(
      "templates",
      "quarto-yaml",
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
    cohort = .x
  )
)



