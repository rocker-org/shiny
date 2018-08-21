# rocker/shiny-verse

The `rocker/shiny-verse` image adds the `tidyverse` suite (and
`devtools` suite) of R packages to the `rocker:shiny` images.
Like the `rocker/shiny` images, this stack is versioned so
that a tag, such as `rocker/shiny-verse:3.5.0` will always
provide R v3.5.0, and likewise fix the version of all R
packages installed from CRAN to the [last date that version was
current](https://github.com/rocker-org/rocker-versioned/tree/master/VERSIONS.md).

Additional commonly used dependencies may be added to `shiny-verse`
when appropriate (or at least C libraries needed to ensure other common
packages can be installed from source).  Please open an issue on GitHub
to discuss any such proposals.


