This repository presents the output data and the figures generated from it, and presented in
the paper "Combining land data assimilation and hydro-economic optimization to analyze water allocation 
in politically unstable transboundary river basins"
By C. Rouge, A. Tilmant, B. Zaitchik, A. Dezfuli and M. Salman

Files:

=> Output data:

te_res.mat 
contains all the results data used in this analysis

te_no_irr.mat 
contains all the results for a SDDP run with exactly the same inputs as te_res.mat, but without irrigation

=> Auxiliary data:

"Nominal.xlsx" contains expected (nominal) hydropower productions for a number of reservoirs in the T-E

"Nodes_with_XYcoord.xlsx" contains latitude and longitude for most nodes in this analysis

=> Matlab files

"Main.m" 
A call to this routine produces all the results figures as well as Table 1.
It is properly commented and contains calls to all other .m files in this repository.
