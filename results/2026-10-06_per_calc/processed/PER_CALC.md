# Cost of one calculation: core level vs inside each operator

## Core level (microbench/bin/compute, register-only loops, cycles at 2.1 GHz)

| instruction     |   lanes |   latency_cycles |   latency_ns |   throughput_cycles_per_instr |   instr_per_cycle |   ns_per_calc_dependent |   ns_per_calc_scalar_pipelined |   ns_per_calc_peak |
|:----------------|--------:|-----------------:|-------------:|------------------------------:|------------------:|------------------------:|-------------------------------:|-------------------:|
| fp32_avx2_fma   |       8 |           4.0075 |       1.9083 |                        0.501  |            1.9961 |                  1.9083 |                       nan      |             0.0298 |
| fp32_avx2_max   |       8 |           4.0073 |       1.9082 |                        0.5009 |            1.9964 |                  1.9082 |                       nan      |             0.0298 |
| fp32_avx512_add |      16 |           3.4245 |       1.6307 |                        0.5013 |            1.9949 |                  1.6307 |                       nan      |             0.0149 |
| fp32_avx512_fma |      16 |           4.008  |       1.9086 |                        0.5013 |            1.9948 |                  1.9086 |                       nan      |             0.0149 |
| fp32_avx512_max |      16 |           4.0075 |       1.9083 |                        0.5011 |            1.9955 |                  1.9083 |                       nan      |             0.0149 |
| fp32_avx512_mul |      16 |           4.008  |       1.9086 |                        0.5011 |            1.9954 |                  1.9086 |                       nan      |             0.0149 |
| fp32_scalar_add |       1 |           2.0038 |       0.9542 |                        0.5009 |            1.9963 |                  0.9542 |                         0.2385 |             0.2385 |
| fp32_scalar_fma |       1 |           4.0072 |       1.9082 |                        0.5009 |            1.9965 |                  1.9082 |                         0.2385 |             0.2385 |
| fp32_scalar_max |       1 |           4.0073 |       1.9082 |                        0.501  |            1.9962 |                  1.9082 |                         0.2385 |             0.2385 |
| fp32_scalar_mul |       1 |           4.0077 |       1.9085 |                        0.5009 |            1.9963 |                  1.9085 |                         0.2385 |             0.2385 |
| fp32_sse_fma    |       4 |           4.0074 |       1.9083 |                        0.5009 |            1.9963 |                  1.9083 |                       nan      |             0.0596 |

## Per operator type (in-model, one core)

avg = total time / total calculations of that type; fastest/slowest = layer with the lowest/highest ns per calculation; x core peak = how many times longer than the AVX-512 peak cost of the same calculation.

| op        |   layers | unit       |   core_peak_ns_per_calc |   avg_ns_per_calc |   fastest_ns_per_calc | fastest_layer   |   slowest_ns_per_calc | slowest_layer         |   avg_x_core_peak |   fastest_x_core_peak |   slowest_x_core_peak | slowest_layer_dominant_part         |   total_ms |
|:----------|---------:|:-----------|------------------------:|------------------:|----------------------:|:----------------|----------------------:|:----------------------|------------------:|----------------------:|----------------------:|:------------------------------------|-----------:|
| conv1x1   |       36 | MAC        |                  0.0149 |            0.0193 |                0.0155 | layer2.0.conv1  |                0.0282 | layer4.0.downsample.0 |            1.2913 |                1.0367 |                1.8889 | compute kernel (61%)                |    40.8333 |
| conv3x3   |       16 | MAC        |                  0.0149 |            0.0194 |                0.0165 | layer2.3.conv2  |                0.0296 | layer4.0.conv2        |            1.2972 |                1.1068 |                1.9809 | compute kernel (65%)                |    35.7995 |
| conv7x7   |        1 | MAC        |                  0.0149 |            0.0184 |                0.0184 | conv1           |                0.0184 | conv1                 |            1.231  |                1.231  |                1.231  | compute kernel (81%)                |     2.1675 |
| fc        |        1 | MAC        |                  0.0149 |            0.2425 |                0.2425 | fc              |                0.2425 | fc                    |           16.2564 |               16.2564 |               16.2564 | compute kernel (95%)                |     0.4967 |
| batchnorm |       53 | element    |                  0.0149 |            0.4398 |                0.3386 | layer1.1.bn2    |                1.1789 | layer4.0.bn2          |           29.4797 |               22.6925 |               79.0165 | framework / ATen-native loop (100%) |     4.8884 |
| relu      |       49 | element    |                  0.0149 |            0.1882 |                0.1455 | layer3.4.relu3  |                0.3262 | layer4.1.relu2        |           12.6212 |                9.7565 |               21.8696 | framework / ATen-native loop (100%) |     1.8087 |
| add       |       16 | element    |                  0.0149 |            0.3673 |                0.2956 | layer4.1.add    |                0.3918 | layer2.0.add          |           24.6216 |               19.8125 |               26.2617 | framework / ATen-native loop (100%) |     2.0274 |
| maxpool   |        1 | comparison |                  0.0149 |            5.6965 |                5.6965 | maxpool         |                5.6965 | maxpool               |          381.947  |              381.947  |              381.947  | framework / ATen-native loop (100%) |    10.1677 |
| avgpool   |        1 | element    |                  0.0149 |            0.7688 |                0.7688 | avgpool         |                0.7688 | avgpool               |           51.5337 |               51.5337 |               51.5337 | framework / ATen-native loop (100%) |     0.0772 |

## Slowest 15 layers relative to core peak

| layer        | op        | input_shape   |   calculations |   time_ms |   ns_per_calc |   x_slower_than_core_peak |   kernel_ms |   weight_relayout_ms |   act_relayout_ms |   framework_other_ms | dominant_part                |
|:-------------|:----------|:--------------|---------------:|----------:|--------------:|--------------------------:|------------:|---------------------:|------------------:|---------------------:|:-----------------------------|
| maxpool      | maxpool   | 1x64x112x112  |        1784896 |   10.1677 |        5.6965 |                  381.947  |           0 |                    0 |                 0 |              10.1677 | framework / ATen-native loop |
| layer4.0.bn2 | batchnorm | 1x512x7x7     |          25088 |    0.0296 |        1.1789 |                   79.0165 |           0 |                    0 |                 0 |               0.0296 | framework / ATen-native loop |
| layer4.1.bn1 | batchnorm | 1x512x7x7     |          25088 |    0.0288 |        1.1461 |                   76.8178 |           0 |                    0 |                 0 |               0.0288 | framework / ATen-native loop |
| layer4.2.bn2 | batchnorm | 1x512x7x7     |          25088 |    0.0287 |        1.1433 |                   76.6282 |           0 |                    0 |                 0 |               0.0287 | framework / ATen-native loop |
| layer4.1.bn2 | batchnorm | 1x512x7x7     |          25088 |    0.0285 |        1.1369 |                   76.198  |           0 |                    0 |                 0 |               0.0285 | framework / ATen-native loop |
| layer4.2.bn1 | batchnorm | 1x512x7x7     |          25088 |    0.0279 |        1.1137 |                   74.6459 |           0 |                    0 |                 0 |               0.0279 | framework / ATen-native loop |
| avgpool      | avgpool   | 1x2048x7x7    |         100352 |    0.0772 |        0.7688 |                   51.5337 |           0 |                    0 |                 0 |               0.0772 | framework / ATen-native loop |
| layer3.2.bn2 | batchnorm | 1x256x14x14   |          50176 |    0.0341 |        0.6803 |                   45.5941 |           0 |                    0 |                 0 |               0.0341 | framework / ATen-native loop |
| layer3.4.bn2 | batchnorm | 1x256x14x14   |          50176 |    0.0339 |        0.6747 |                   45.2241 |           0 |                    0 |                 0 |               0.0339 | framework / ATen-native loop |
| layer3.0.bn2 | batchnorm | 1x256x14x14   |          50176 |    0.0327 |        0.6519 |                   43.6959 |           0 |                    0 |                 0 |               0.0327 | framework / ATen-native loop |
| layer3.1.bn1 | batchnorm | 1x256x14x14   |          50176 |    0.0325 |        0.6485 |                   43.4648 |           0 |                    0 |                 0 |               0.0325 | framework / ATen-native loop |
| layer3.5.bn1 | batchnorm | 1x256x14x14   |          50176 |    0.0324 |        0.6455 |                   43.2658 |           0 |                    0 |                 0 |               0.0324 | framework / ATen-native loop |
| layer3.4.bn1 | batchnorm | 1x256x14x14   |          50176 |    0.0323 |        0.6443 |                   43.1857 |           0 |                    0 |                 0 |               0.0323 | framework / ATen-native loop |
| layer3.2.bn1 | batchnorm | 1x256x14x14   |          50176 |    0.0323 |        0.6434 |                   43.1229 |           0 |                    0 |                 0 |               0.0323 | framework / ATen-native loop |
| layer3.1.bn2 | batchnorm | 1x256x14x14   |          50176 |    0.0323 |        0.6429 |                   43.0868 |           0 |                    0 |                 0 |               0.0323 | framework / ATen-native loop |
