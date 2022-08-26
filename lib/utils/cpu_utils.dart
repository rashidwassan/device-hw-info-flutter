import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';

// ignore: avoid_classes_with_only_static_members
class CPUUtils {
  static Future<CpuInfo> readCPUInfo() {
    return CpuReader.cpuInfo;
  }

  static Stream<CpuInfo> getLiveCPUData() {
    return CpuReader.cpuStream(700);
  }
}
