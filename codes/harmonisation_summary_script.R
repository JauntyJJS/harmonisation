library(quarto)
library(fs)
library(here)

# Copy the right index.qmd file

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

quarto::quarto_render(
  as_job = FALSE
)


