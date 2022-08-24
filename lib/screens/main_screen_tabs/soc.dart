import 'package:cpu_reader/cpuinfo.dart';
import 'package:flutter/material.dart';
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
                StreamBuilder(
                  stream: CPUUtils.getLiveCPUData(),
                  builder: (context, AsyncSnapshot<CpuInfo> cpuInfo) {
                    if (cpuInfo.hasData) {
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          shrinkWrap: true,
                          itemCount: cpuData.data!.numberOfCores,
                          itemBuilder: (context, index) => AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Core $index',
                                  ),
                                  Text(
                                    '${cpuInfo.data!.currentFrequencies![index]} Mhz',
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
