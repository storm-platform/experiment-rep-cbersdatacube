# Install devtools, rmarkdown, knitr, testthat and Rcpp if not already available
install.packages(c("rmarkdown", "knitr", 
                   "testthat", "remotes", 
                   "qpdf", "terra", 
                   "rstac", "IRkernel"), repos = "https://cran.uni-muenster.de")

#
# check the environment type
#
remotes::install_deps(dependencies = TRUE)

#
# install tensorflow and keras
#
remotes::install_github("rstudio/keras@aaddf0e411f66d48f88f858d1436c1d38e13fb97")
remotes::install_github("rstudio/reticulate@7174f745626d3e71a9527a96d56075a729b6506e")

#
# install sits package
#
remotes::install_github('e-sensing/sits@v0.10.0', dependencies = FALSE)

#
# configure irkernel
#
IRkernel::installspec(user = FALSE)
