% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_metadata.R
\name{read_metadata}
\alias{read_metadata}
\title{Read and Combine Metadata from Google Sheets and Calculate Area}
\usage{
read_metadata(googlesheets_link, method = "criobe")
}
\arguments{
\item{googlesheets_link}{A character string representing the link to the Google Sheets document.}

\item{method}{Method used for the estimation of the surface area. Can either be a value based on the study by Veal et al. (2010) (\code{veal}) or conversion factors based on custom-build calibration objects (\code{criobe}).}
}
\value{
A data frame containing combined metadata from the specified Google Sheets.
}
\description{
This function reads metadata from a Google Sheets link and combines data from multiple sheets into a single data frame. After some checks, the area is calculated with the get_area() function.
}
\examples{
\dontrun{
googlesheets_link <- "https://docs.google.com/spreadsheets/d/your_sheet_id"
read_metadata(googlesheets_link)
}

}
