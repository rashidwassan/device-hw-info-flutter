import 'package:cpu_reader/cpuinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hw_info_app/components/pie_chart_view.dart';
import 'package:flutter_hw_info_app/utils/cpu_utils.dart';

class SoCInfoPage extends StatefulWidget {
  const SoCInfoPage({super.key});

  @override
  State<SoCInfoPage> createState() => _SoCInfoPageState();
}

class _SoCInfoPageState extends State<SoCInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: CPUUtils.readCPUInfo(),
        builder: (context, AsyncSnapshot<CpuInfo> cpuData) {
          if (cpuData.hasData) {
            print(cpuData.data!.minMaxFrequencies![0]!.max.toString());
            print(cpuData.data!.minMaxFrequencies![1]!.max.toString());
            print(cpuData.data!.minMaxFrequencies![2]!.max.toString());
            print(cpuData.data!.minMaxFrequencies![3]!.max.toString());
            print(cpuData.data!.minMaxFrequencies![4]!.max.toString());
            print(cpuData.data!.minMaxFrequencies![5]!.max.toString());
            print(cpuData.data!.minMaxFrequencies![6]!.max.toString());
            print(cpuData.data!.minMaxFrequencies![7]!.max.toString());
            return Column(
              children: [
                StreamBuilder(
                  stream: CPUUtils.getLiveCPUData(),
                  builder: (context, AsyncSnapshot<CpuInfo> cpuInfo) {
                    if (cpuInfo.hasData) {
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          shrinkWrap: true,
                          itemCount: cpuData.data!.numberOfCores,
                          itemBuilder: (context, index) => AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  PieChartView(
                                    centerText:
                                        '${cpuInfo.data!.currentFrequencies![index]} Mhz',
                                    total: double.parse(
                                          cpuInfo.data!
                                              .minMaxFrequencies![index]!.max
                                              .toString(),
                                        ) -
                                        cpuInfo
                                            .data!.currentFrequencies![index]!
                                            .toDouble(),
                                    usage: cpuInfo
                                        .data!.currentFrequencies![index]!
                                        .toDouble(),
                                  ),
                                  Text(
                                    'Core $index',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
