# `coralchlo`


## Coral Chlorophyll and Symbiodiniaceae Counts

This package helps during the analysis of chlorophyll a data and
Symbiodiniaceae counts. The data has to be prepared following these
[protocols](https://andieich.github.io/coral_chlorophyll_symcounts/).

The package can be installed with the `devtools` package:

``` r
devtools::install_github("andieich/coralchlo")
```

The current version is 0.0.0.4.

After installation, you can load the package and download the metadata
sheet. During this the import of the sheet, some basic test are done to
ensure it was filled out correctly and that the values make sense.

Additionally, the surface area is estimated from the increase in weight
with the additional layer of paraffin wax. Different conversion factors
can be used. Either a value from the literature from @veal2010, or
conversion factors based on custom-made calibration blocks (see
[here](calibration.qmd) for more info). The method can be selected in
the `read_metadata()` function with `method = "veal"` or
`method = "criobe"`. The default selection is `"criobe"`.

``` r
library(coralchlo)

link_metadatasheet <- "example_link"

dat_overview <- read_metadata(link_metadatasheet)
```

Then, the chlorophyll a concentration is calculated based on the
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
the chlorophyll concentration for the surface area of the coral
fragment. For each sample, two measurements were taken, therefore two
chlorophyll a and c2 concentrations will be exported.

``` r
dat_chla <- normalise_chla_per_area(dat_overview,
                                    path_to_biotekfolder = "example_path")
```

![](README_files/figure-commonmark/unnamed-chunk-6-1.png)

``` r
head(dat_chla, n = 10)
```

       sample_id measurement_replicate chl_a_per_cm2 chl_c2_per_cm2 chl_tot_per_cm2
    1   2TSML27P                    m1      2.514030      0.3057623        2.819792
    2   2TSML27P                    m2      2.514030      0.3057623        2.819792
    3   2TSPL07P                    m1      2.013116      0.2365427        2.249658
    4   2TSPL07P                    m2      2.017770      0.2350646        2.252834
    5   2TSAL09P                    m1      3.948941      0.4135201        4.362461
    6   2TSAL09P                    m2      3.948941      0.4135201        4.362461
    7   2TSML26P                    m1      4.847892      0.4351625        5.283054
    8   2TSML26P                    m2      4.847892      0.4351625        5.283054
    9   2TSAL07P                    m1      4.706739      0.4407329        5.147472
    10  2TSAL07P                    m2      4.706417      0.4543703        5.160787

Similarly, the Symbiodiniaceae counts are normalized for the surface
area of the coral fragment. Since six measurements are taken per sample,
six values are exported

``` r
dat_counts <- normalise_counts_per_area(dat_overview)
head(dat_counts, n = 10)
```

       sample_id count_replicate count_per_cm2
    1   2TSML27P              c1       3623635
    2   2TSML27P              c2       3355218
    3   2TSML27P              c3       4026261
    4   2TSML27P              c4       3221009
    5   2TSML27P              c5       4160470
    6   2TSML27P              c6       3489426
    7   2TSPL07P              c1       3868471
    8   2TSPL07P              c2       4479282
    9   2TSPL07P              c3       3766669
    10  2TSPL07P              c4       3155858
