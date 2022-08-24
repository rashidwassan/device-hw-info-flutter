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
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cpuData.data!.numberOfCores,
                          itemBuilder: (context, index) => Text(
                            cpuInfo.data!.currentFrequencies![index].toString(),
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
