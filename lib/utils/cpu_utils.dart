import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';

// ignore: avoid_classes_with_only_static_members
class CPUUtils {
  static void readCPU() async {
    final CpuInfo cpuInfo = await CpuReader.cpuInfo;
    print('Number of Cores ${cpuInfo.numberOfCores}');

    int freq = await CpuReader.getCurrentFrequency(2) ?? 0;
    print('Core number 2 freq $freq Mhz');

    CpuReader.cpuStream(1000)
        .listen((cpuInfo) => print("Temperature: ${cpuInfo.cpuTemperature}"));
  }
}
