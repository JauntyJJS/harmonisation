# Create Drop Down Filter Render Function

Function that returns a \`reactable\` filter input render function that
provide a drop down functionality.

## Usage

``` r
create_dropdown_filter_render_function(
  reactable_element_id,
  style = "width: 100%; height: 100%;"
)
```

## Arguments

- reactable_element_id:

  Text input indicating the element ID of the \`reactable\`

- style:

  Text input indicating the javascript style parameters of the filter
  input drop down box. Default: 'width: 100%; height: 28px;'

## Value

A render function for a \`reactable\` column indicating that it needs a
drop down filter input box.

## Examples

``` r
create_dropdown_filter_render_function(
  reactable_element_id = "drop-down-filter-table")
#> function (values, name) 
#> {
#>     htmltools::tags$select(onchange = sprintf("\n          const value = event.target.value\n          Reactable.setFilter('%s', '%s', value === '__ALL__' ? undefined : value)", 
#>         reactable_element_id, name), htmltools::tags$option(value = "__ALL__", 
#>         "All"), lapply(intersect(levels(values), unique(values)), 
#>         htmltools::tags$option), `aria-label` = sprintf("Filter %s", 
#>         name), style = style)
#> }
#> <bytecode: 0x5625d032eed8>
#> <environment: 0x5625d032c4c8>
```
