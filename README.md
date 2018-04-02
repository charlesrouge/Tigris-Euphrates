This repository presents the output data and the figures generated from it, and presented in
the paper "Identifying key water resource vulnerabilities in data-scarce transboundary river basins"
By C. Rouge, A. Tilmant, B. Zaitchik, A. Dezfuli and M. Salman

Files:

=> Output data (MAT format):

The output data used for the figures is available at https://drive.google.com/file/d/1yRq4uZS9dlxxfpn64At2bUcjY9FNs3FM/view?usp=sharing.

When clicking the link, warnings may appear, but you can ignore them.

All files have a letter plus number (ex: A0) referring the the scenario described in Table 1 of the paper. The prefix "hist" indicates a re-optimization of the historical flows; otherwise, the file contains results for 1,000, 10 years monthly time-series for the basin's inflows.
A0_no_irr.mat contains results for the no-irrigation version of scenario A0 (used for validation).

=> Auxiliary data:

"Nominal.xlsx" contains expected (nominal) hydropower productions for a number of reservoirs in the T-E

=> Matlab files

"Main.m" 
A call to this routine produces all the results figures as well as Table 1.
It is properly commented and contains calls to all other .m files in this repository.
