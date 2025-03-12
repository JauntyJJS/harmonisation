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


fs::file_copy(
  path = here::here(
    "templates",
    "quarto-yaml" ,
    "_quarto_all.yml"),
  new_path = here::here("_quarto.yml"),
  overwrite = TRUE
)

quarto::quarto_render(
  as_job = FALSE
)


