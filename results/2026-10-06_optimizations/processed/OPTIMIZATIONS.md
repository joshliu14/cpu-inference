# Optimization experiments

Baseline = canonical explicit model. Speedup = baseline median / variant median (same process, same CPU, interleaved order). max_abs_diff = largest output difference vs baseline (numerical equivalence check).

| variant               |   median_ms |   p5_ms |   p95_ms |   stddev_ms |   speedup_vs_baseline |   saved_ms |   ipc |   instructions_M |   cycles_M |   max_abs_diff |   build_s |
|:----------------------|------------:|--------:|---------:|------------:|----------------------:|-----------:|------:|-----------------:|-----------:|---------------:|----------:|
| baseline              |     100.503 | 100.174 |  101.554 |       0.405 |                 1     |      0     | 2.258 |          475.043 |    210.365 |        0       |     1.482 |
| maxpool_chlast        |      92.091 |  91.879 |   92.488 |       0.209 |                 1.091 |      8.412 | 2.303 |          443.824 |    192.692 |        0       |     1.42  |
| fold_bn               |      98.542 |  98.254 |   99.139 |       0.297 |                 1.02  |      1.961 | 2.222 |          458.042 |    206.123 |        2.3e-05 |     1.575 |
| channels_last         |      89.725 |  89.421 |   90.378 |       0.283 |                 1.12  |     10.778 | 2.662 |          499.615 |    187.702 |        3.1e-05 |     1.406 |
| mkldnn_layout         |      93.846 |  93.561 |   94.764 |       0.365 |                 1.071 |      6.657 | 2.045 |          401.486 |    196.323 |        4e-05   |     1.816 |
| fold_bn+chlast_pool   |      90.001 |  89.639 |   90.997 |       0.399 |                 1.117 |     10.502 | 2.269 |          427.091 |    188.224 |        2.3e-05 |     1.431 |
| fold_bn+channels_last |      86.371 |  86.1   |   87.186 |       0.378 |                 1.164 |     14.132 | 2.639 |          476.978 |    180.709 |        3.1e-05 |     1.396 |
| jit_freeze            |      84.186 |  83.955 |   85.145 |       0.353 |                 1.194 |     16.317 | 2.203 |          388.033 |    176.113 |        8.4e-05 |     2.672 |
| inductor              |      70.412 |  70.238 |   71.19  |       0.278 |                 1.427 |     30.091 | 2.945 |          434.236 |    147.466 |        9.2e-05 |    10.509 |

## Per-operator-type time (ms, in-model hooks)

|                       |   conv1x1 |   conv3x3 |   conv7x7 |   batchnorm |   relu |   add |   maxpool |   other |
|:----------------------|----------:|----------:|----------:|------------:|-------:|------:|----------:|--------:|
| baseline              |     41.36 |     36.96 |      2.19 |        5.02 |   1.83 |  2.06 |     10.19 |    0.59 |
| maxpool_chlast        |     41.41 |     37.07 |      2.2  |        5.02 |   1.83 |  2.07 |      1.81 |    0.59 |
| fold_bn               |     44.17 |     37.1  |      2.21 |        0    |   1.87 |  2.05 |     10.18 |    0.59 |
| channels_last         |     42.61 |     34.15 |      2    |        5.59 |   1.82 |  2.05 |      0.61 |    0.59 |
| mkldnn_layout         |     41.77 |     35.74 |      1.86 |        5.99 |   2.72 |  4.11 |      0.24 |    0.62 |
| fold_bn+chlast_pool   |     43.98 |     37.03 |      2.21 |        0    |   1.87 |  2.04 |      1.82 |    0.59 |
| fold_bn+channels_last |     44.69 |     33.88 |      2    |        0    |   1.9  |  2.08 |      0.62 |    0.57 |

## Mechanism check A: max-pool kernel counters

Input [1, 64, 112, 112] -> 200704 outputs; per-call medians of in-process counters, normalised per pooled output. Results identical to NCHW: {'channels_last': True, 'mkldnn': True}.

|               |   us_per_call |   cycles_per_output |   instructions_per_output |   ipc |   branches_per_output |   branch_misses_per_output |   loads_per_output |   stores_per_output |   fp_256b_per_output |   fp_512b_per_output |
|:--------------|--------------:|--------------------:|--------------------------:|------:|----------------------:|---------------------------:|-------------------:|--------------------:|---------------------:|---------------------:|
| nchw          |     10141.2   |             105.827 |                   213.559 | 2.018 |                39.181 |                      1.851 |             62.121 |              14.253 |                    0 |                    0 |
| channels_last |       610.398 |               6.373 |                    23.577 | 3.7   |                 2.114 |                      0     |              9.077 |               3.492 |                    0 |                    0 |
| mkldnn        |       476.656 |               4.976 |                     9.497 | 1.909 |                 0.448 |                      0     |              2.876 |               1.657 |                    0 |                    0 |
| to_cl         |       804.447 |               8.371 |                    28.654 | 3.423 |                 4.081 |                      0     |              4.026 |               4.015 |                    0 |                    0 |
| to_nchw       |       324.164 |               3.37  |                     7.073 | 2.099 |                 1.015 |                      0     |              1.02  |               1.011 |                    0 |                    0 |

## Mechanism check B: oneDNN primitives per inference

From ONEDNN verbose of one inference (exec times as reported by oneDNN). Weight reorders = conv weights converted to oneDNN's blocked layout on every call; activation reorders = NCHW <-> blocked conversions of activations. MKL SGEMM (unstrided 1x1 convs in eager NCHW) does not appear here.

| variant               |   convolution_calls |   convolution_ms |   reorder_weight_calls |   reorder_weight_ms |   reorder_weight_MB |   reorder_activation_calls |   reorder_activation_ms |   reorder_activation_MB |   other_onednn_ms |
|:----------------------|--------------------:|-----------------:|-----------------------:|--------------------:|--------------------:|---------------------------:|------------------------:|------------------------:|------------------:|
| baseline              |                  20 |            35.09 |                     20 |                6.48 |               56.32 |                         39 |                    2.02 |                   24.79 |              0    |
| channels_last         |                  20 |            34.93 |                     20 |                7.93 |               56.32 |                          0 |                    0    |                    0    |              0    |
| fold_bn+channels_last |                  20 |            34.66 |                     20 |                7.89 |               56.32 |                          0 |                    0    |                    0    |              0    |
| fold_bn               |                  20 |            36.02 |                     20 |                6.73 |               56.32 |                         39 |                    2.08 |                   24.79 |              0    |
| inductor              |                  53 |            66.25 |                      0 |                0    |                0    |                          0 |                    0    |                    0    |              0    |
| jit_freeze            |                  53 |            64.26 |                     53 |               11.79 |               93.82 |                          2 |                    0.07 |                    0.61 |              4.42 |
| maxpool_chlast        |                  20 |            35.05 |                     20 |                6.45 |               56.32 |                         39 |                    2.06 |                   24.79 |              0    |
| mkldnn_layout         |                  53 |            64.75 |                     53 |               12.06 |               93.82 |                          0 |                    0    |                    0    |             10.32 |

## Mechanism check C: ATen operators dispatched per inference (calls)

| variant               |   aten::_slow_conv2d_forward |   aten::add_ |   aten::addmm |   aten::clamp_min_ |   aten::copy_ |   aten::max_pool2d_with_indices |   aten::mkldnn_convolution |   aten::native_batch_norm |   aten::relu_ |   mkldnn::_convolution_pointwise |   mkldnn::_convolution_pointwise_ |
|:----------------------|-----------------------------:|-------------:|--------------:|-------------------:|--------------:|--------------------------------:|---------------------------:|--------------------------:|--------------:|---------------------------------:|----------------------------------:|
| baseline              |                           33 |           16 |             1 |                 49 |             2 |                               1 |                         20 |                        53 |            49 |                                0 |                                 0 |
| channels_last         |                           33 |           16 |             1 |                 49 |             2 |                               1 |                         20 |                        53 |            49 |                                0 |                                 0 |
| fold_bn               |                           33 |           16 |             1 |                 49 |            35 |                               1 |                         20 |                         0 |            49 |                                0 |                                 0 |
| fold_bn+channels_last |                           33 |           16 |             1 |                 49 |            35 |                               1 |                         20 |                         0 |            49 |                                0 |                                 0 |
| inductor              |                            0 |            0 |             0 |                  0 |             0 |                               0 |                          0 |                         0 |             0 |                               37 |                                16 |
| jit_freeze            |                            0 |           16 |             0 |                  0 |             0 |                               0 |                          0 |                         0 |            49 |                                0 |                                 0 |
| maxpool_chlast        |                           33 |           16 |             1 |                 49 |             4 |                               1 |                         20 |                        53 |            49 |                                0 |                                 0 |
| mkldnn_layout         |                            0 |           16 |             0 |                  0 |             0 |                               0 |                         53 |                        53 |            49 |                                0 |                                 0 |
