F1 = [10 40 8;5 3 5;12 5 12];
F2 = [6 3 6;2 1 2;6 3 6];
[S, HCOL1, HROW1] = isfilterseparable(F1)
[isseparable,hcol2,hrow2] = isfilterseparable(F2)