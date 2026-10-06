# Dispatch overhead

Linear fit cycles(N) = fixed + per_element x N over N <= 64K elements (L2-resident). 'fixed' is an ESTIMATE of size-independent software cost.

Empty Python call: 38 ns; nn.Identity module call: 1007 ns.

| callable            |   fixed_cycles |   fixed_us |   cycles_per_element |   fixed_instructions | fit_valid   |
|:--------------------|---------------:|-----------:|---------------------:|---------------------:|:------------|
| F.max_pool2d chlast |        5220.23 |      2.486 |                1.455 |             16096.2  | True        |
| add_ inplace        |        2067.56 |      0.985 |                0.294 |              6906.01 | True        |
| conv1x1 64->64      |       17321.8  |      8.248 |                2.073 |             52794.8  | True        |
| conv3x3 64->64      |       81367.7  |     38.747 |               20.9   |            464060    | True        |
| nn.BatchNorm2d(64)  |       20483.5  |      9.754 |                0.449 |             66999.2  | True        |
| nn.MaxPool2d(3,2,1) |      -22731.3  |    -10.824 |               27.403 |             35101.9  | False       |
| nn.ReLU module      |        6172.98 |      2.94  |                0.305 |             20142.3  | True        |
| torch.add           |        2977.25 |      1.418 |                0.369 |              9168.38 | True        |
| torch.relu          |        2636.64 |      1.256 |                0.303 |              8328.6  | True        |

## Smallest call of each callable (OBSERVED; almost entirely fixed cost)

| callable            |   N |    us |   cycles_per_call |   instructions_per_call |
|:--------------------|----:|------:|------------------:|------------------------:|
| F.max_pool2d chlast | 256 |  2.61 |           5461.02 |                17983.6  |
| add_ inplace        |   1 |  1.04 |           2168.34 |                 6917.55 |
| conv1x1 64->64      |  64 |  8.01 |          16775.8  |                49814.5  |
| conv3x3 64->64      |  64 | 17.64 |          36965.5  |               111504    |
| module_identity     |   1 |  1.01 |           2110.42 |                 9587.59 |
| nn.BatchNorm2d(64)  |  64 |  9.66 |          20237.5  |                65511.4  |
| nn.MaxPool2d(3,2,1) | 256 |  5.76 |          12060.6  |                49453.1  |
| nn.ReLU module      |   1 |  2.94 |           6165.83 |                19930.5  |
| python_noop         |   0 |  0.04 |             80.31 |                  511.15 |
| torch.add           |   1 |  1.44 |           3018.8  |                 8974.17 |
| torch.relu          |   1 |  1.28 |           2692.44 |                 8133.38 |

## Fixed software cost per ResNet-50 inference (CALCULATED estimate)

calls per inference x smallest-call cost. conv3x3 row also stands for conv7x7 and the 3 strided 1x1 convs (oneDNN path); 'module_identity' stands for the 16 residual Add modules' wrapper plus avgpool/flatten/fc module calls. Conv rows are lower bounds.

| operator (module used as proxy)   |   calls_per_inference |   us_per_call |   us_per_inference |
|:----------------------------------|----------------------:|--------------:|-------------------:|
| conv1x1 64->64                    |                    33 |          8.01 |             264.2  |
| conv3x3 64->64                    |                    20 |         17.64 |             352.82 |
| nn.BatchNorm2d(64)                |                    53 |          9.66 |             511.92 |
| nn.ReLU module                    |                    49 |          2.94 |             144.18 |
| module_identity                   |                    19 |          1.01 |              19.14 |
| add_ inplace                      |                    16 |          1.04 |              16.56 |
| nn.MaxPool2d(3,2,1)               |                     1 |          5.76 |               5.76 |

**Total: 1.31 ms per inference = 1.3% of the 98.57 ms baseline.**
