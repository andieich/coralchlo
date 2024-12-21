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
sheet. During this the import of the sheet, some basic test are done to
ensure it was filled out correctly and that the values make sense.

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
the chlorophyll a concentration for the surface area of the coral
fragment. For each sample, two measurements were taken, therefore two
chlorophyll a concentrations will be exported.

``` r
dat_chla <- normalise_chla_per_area(dat_overview,
                                    path_to_biotekfolder = "example_path")
```

![](README_files/figure-commonmark/unnamed-chunk-6-1.png)

``` r
head(dat_chla, n = 10)
```

<div id="ocfmbdycct" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ocfmbdycct table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#ocfmbdycct thead, #ocfmbdycct tbody, #ocfmbdycct tfoot, #ocfmbdycct tr, #ocfmbdycct td, #ocfmbdycct th {
  border-style: none;
}
&#10;#ocfmbdycct p {
  margin: 0;
  padding: 0;
}
&#10;#ocfmbdycct .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#ocfmbdycct .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#ocfmbdycct .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#ocfmbdycct .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#ocfmbdycct .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#ocfmbdycct .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#ocfmbdycct .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#ocfmbdycct .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#ocfmbdycct .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#ocfmbdycct .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#ocfmbdycct .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#ocfmbdycct .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#ocfmbdycct .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#ocfmbdycct .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#ocfmbdycct .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ocfmbdycct .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#ocfmbdycct .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#ocfmbdycct .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#ocfmbdycct .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ocfmbdycct .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#ocfmbdycct .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ocfmbdycct .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#ocfmbdycct .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ocfmbdycct .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#ocfmbdycct .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ocfmbdycct .gt_left {
  text-align: left;
}
&#10;#ocfmbdycct .gt_center {
  text-align: center;
}
&#10;#ocfmbdycct .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#ocfmbdycct .gt_font_normal {
  font-weight: normal;
}
&#10;#ocfmbdycct .gt_font_bold {
  font-weight: bold;
}
&#10;#ocfmbdycct .gt_font_italic {
  font-style: italic;
}
&#10;#ocfmbdycct .gt_super {
  font-size: 65%;
}
&#10;#ocfmbdycct .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#ocfmbdycct .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#ocfmbdycct .gt_indent_1 {
  text-indent: 5px;
}
&#10;#ocfmbdycct .gt_indent_2 {
  text-indent: 10px;
}
&#10;#ocfmbdycct .gt_indent_3 {
  text-indent: 15px;
}
&#10;#ocfmbdycct .gt_indent_4 {
  text-indent: 20px;
}
&#10;#ocfmbdycct .gt_indent_5 {
  text-indent: 25px;
}
&#10;#ocfmbdycct .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#ocfmbdycct div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

| sample_id | measurement_replicate | chl_a_per_cm2 |
|-----------|-----------------------|---------------|
| 2TSML27P  | m1                    | 3.416571      |
| 2TSML27P  | m2                    | 3.416571      |
| 2TSPL07P  | m1                    | 2.741200      |
| 2TSPL07P  | m2                    | 2.747538      |
| 2TSAL09P  | m1                    | 5.251357      |
| 2TSAL09P  | m2                    | 5.251357      |
| 2TSML26P  | m1                    | 6.467369      |
| 2TSML26P  | m2                    | 6.467369      |
| 2TSAL07P  | m1                    | 6.488811      |
| 2TSAL07P  | m2                    | 6.488367      |

</div>

Similarly, the Symbiodiniaceae counts are normalized for the surface
area of the coral fragment. Since six measurements are taken per sample,
six values are exported

``` r
dat_counts <- normalise_counts_per_area(dat_overview)
head(dat_counts, n = 10)
```

<div id="rcmpfvguwj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rcmpfvguwj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#rcmpfvguwj thead, #rcmpfvguwj tbody, #rcmpfvguwj tfoot, #rcmpfvguwj tr, #rcmpfvguwj td, #rcmpfvguwj th {
  border-style: none;
}
&#10;#rcmpfvguwj p {
  margin: 0;
  padding: 0;
}
&#10;#rcmpfvguwj .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#rcmpfvguwj .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#rcmpfvguwj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#rcmpfvguwj .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#rcmpfvguwj .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#rcmpfvguwj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#rcmpfvguwj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#rcmpfvguwj .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#rcmpfvguwj .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#rcmpfvguwj .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#rcmpfvguwj .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#rcmpfvguwj .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#rcmpfvguwj .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#rcmpfvguwj .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#rcmpfvguwj .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rcmpfvguwj .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#rcmpfvguwj .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#rcmpfvguwj .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#rcmpfvguwj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rcmpfvguwj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#rcmpfvguwj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rcmpfvguwj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#rcmpfvguwj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rcmpfvguwj .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#rcmpfvguwj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rcmpfvguwj .gt_left {
  text-align: left;
}
&#10;#rcmpfvguwj .gt_center {
  text-align: center;
}
&#10;#rcmpfvguwj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#rcmpfvguwj .gt_font_normal {
  font-weight: normal;
}
&#10;#rcmpfvguwj .gt_font_bold {
  font-weight: bold;
}
&#10;#rcmpfvguwj .gt_font_italic {
  font-style: italic;
}
&#10;#rcmpfvguwj .gt_super {
  font-size: 65%;
}
&#10;#rcmpfvguwj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#rcmpfvguwj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#rcmpfvguwj .gt_indent_1 {
  text-indent: 5px;
}
&#10;#rcmpfvguwj .gt_indent_2 {
  text-indent: 10px;
}
&#10;#rcmpfvguwj .gt_indent_3 {
  text-indent: 15px;
}
&#10;#rcmpfvguwj .gt_indent_4 {
  text-indent: 20px;
}
&#10;#rcmpfvguwj .gt_indent_5 {
  text-indent: 25px;
}
&#10;#rcmpfvguwj .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#rcmpfvguwj div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

| sample_id | count_replicate | count_per_cm2 |
|-----------|-----------------|---------------|
| 2TSML27P  | c1              | 4924526       |
| 2TSML27P  | c2              | 4559746       |
| 2TSML27P  | c3              | 5471696       |
| 2TSML27P  | c4              | 4377357       |
| 2TSML27P  | c5              | 5654086       |
| 2TSML27P  | c6              | 4742136       |
| 2TSPL07P  | c1              | 5267582       |
| 2TSPL07P  | c2              | 6099306       |
| 2TSPL07P  | c3              | 5128962       |
| 2TSPL07P  | c4              | 4297238       |

</div>
