# `coralchlo`


## Coral Chlorophyll and Symbiodiniaceae Counts

This package helps during the analysis of chlorophyll a data and
Symbiodiniaceae counts. The data has to be prepared following these
[protocols](https://andieich.github.io/coral_chlorophyll_symcounts/).

The package can be installed with the `devtools` package:

``` r
devtools::install_github("andieich/coralchlo")
```

The current version is 0.0.0.1.

After installation, you can load the package and download the metadata
sheet. During this the import, some basic test are done to ensure the
sheet was filled out correctly and that the values make sense.

``` r
library(coralchlo)

link_metadatasheet <- "https://docs.google.com/spreadsheets/d/1KP-_yEQoHC9zHPlVpf3ob9BRJ60qNiGJsdZsO-l3ljw/edit?gid=0#gid=0"

dat_overview <- read_metadata(link_metadatasheet)
```

Then, the chlorophyll a concentration can be calculated based on the
absorption measured with the photometer.

The photometer files (`.csv`) can be store in Google Drive or locally.
If they are stored locally, `path_to_biotekfolder`, is the path to the
folder containing these files. If they are stored in Google Drive,
`path_to_biotekfolder` is the path within the Google Drive to the folder
containing the photometer files. If you use Google Drive, set
`is_googledrive = TRUE`. The files are downloaded to a temporary folder
or to a folder specified in `download_directory`. All files in
`download_directory` will be replaced.

The values are blank-corrected. To ensure that the blank values make
sense, they are plotted for all wavelengths and photometer files. This
can be skipped by setting `plot = FALSE` in the
`normalise_chla_per_area()` function. The area data is used to normalize
the chlorophyll a concentration for the surface area of the coral
fragment. For each sample, two measurements were taken, therefore two
chlorophyll a concentrations will be exported.

``` r
dat_chla <- normalise_chla_per_area(dat_overview,
                                    path_to_biotekfolder = "/Users/andi/Desktop/test_files")
```

![](README_files/figure-commonmark/unnamed-chunk-3-1.png)

``` r
head(dat_chla)
```

    # A tibble: 6 × 2
      sample_id chl_a_per_cm2
      <chr>             <dbl>
    1 2TSML27P           3.42
    2 2TSML27P           3.42
    3 2TSPL07P           2.74
    4 2TSPL07P           2.75
    5 2TSAL09P           5.25
    6 2TSAL09P           5.25

Similarly, the Symbiodiniaceae counts are normalized for the surface
area of the coral fragment. Since six measurements are taken per sample,
six values are exported

``` r
dat_counts <- normalise_counts_per_area(dat_overview)
head(dat_counts)
```

    # A tibble: 6 × 3
      sample_id count_replicate count_per_cm2
      <chr>     <chr>                   <dbl>
    1 2TSML27P  c1                   4924526.
    2 2TSML27P  c2                   4559746.
    3 2TSML27P  c3                   5471696.
    4 2TSML27P  c4                   4377357.
    5 2TSML27P  c5                   5654086.
    6 2TSML27P  c6                   4742136.
