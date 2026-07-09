library(quarto)
library(fs)
library(here)
library(purrr)

# Rendering cohorts one by one  ----

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

  tarchetypes::tar_quarto_raw(
    name = paste0(cohort, "_target"),
    path = here::here(),
    quiet = FALSE    
  )

}

cohort_name <- c("Cohort_A", "Cohort_B")

purrr::map(
  .x = cohort_name,
  .f = ~copy_and_render(cohort = .x)
)

# Rendering cohorts all at once  ----

fs::file_copy(
  path = here::here(
    "templates",
    "quarto-yaml" ,
    "_quarto_all.yml"),
  new_path = here::here("_quarto.yml"),
  overwrite = TRUE
)

tarchetypes::tar_quarto_raw(
  name = "all_cohorts_target",
  path = here::here(),
  quiet = FALSE    
)

# Rendering harmonisation summary ----

index_qmd_file <- paste0(
  "_index_",
  "summary",
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

quarto_yml_file <- paste0(
  "_quarto_",
  "summary",
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

tarchetypes::tar_quarto_raw(
  name = "harmonisation_summary_target",
  path = here::here(),
  quiet = FALSE    
)