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
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('CPU Architecture\nNumber of Cores'),
                          Container(
                            height: 20,
                            width: 2,
                            color: Colors.white,
                          ),
                          Text(
                            "${cpuData.data!.abi!}\n${cpuData.data!.numberOfCores}",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TweenAnimationBuilder(
                                    tween: Tween<double>(
                                      begin: 0,
                                      end: cpuInfo
                                          .data!.currentFrequencies![index]!
                                          .toDouble(),
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    builder: (context, value, child) =>
                                        PieChartView(
                                      centerText:
                                          '${double.parse(value.toString()).floor()}Mhz',
                                      total: double.parse(
                                            cpuInfo.data!
                                                .minMaxFrequencies![index]!.max
                                                .toString(),
                                          ) -
                                          cpuInfo
                                              .data!.currentFrequencies![index]!
                                              .toDouble(),
                                      usage: double.parse(value.toString()),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Core $index',
                                    style:
                                        const TextStyle(color: Colors.black54),
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
