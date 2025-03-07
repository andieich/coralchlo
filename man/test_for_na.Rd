% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_metadata.R
\name{test_for_na}
\alias{test_for_na}
\title{Test for NA Values in Specific Columns}
\usage{
test_for_na(data, test, col_name)
}
\arguments{
\item{data}{A data frame to be checked for NA values.}

\item{test}{A logical expression as a string to specify the columns (and combinations) to be checked for NA values.}

\item{col_name}{A character defining the column that should be printed as warning for the respective test.}
}
\description{
This function checks for NA values in specific columns (and combinations) of a data frame and warns if any are found. It exports the row and column names with the NA values.
}
\examples{
\dontrun{
data <- data.frame(
  id = 1:5,
  type = c("sample", "control", NA, "sample", "control"),
  value = c(10, NA, 15, 20, 25),
  col_name = "value"
)
test_for_na(data, test = 'type == "sample" & is.na(value)')
}

}
