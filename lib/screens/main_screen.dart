import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:system_info_plus/system_info_plus.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  void getDeviceMemory() async {
    int? deviceMemory = await SystemInfoPlus.physicalMemory; // returns in MB
  }

  void readCPU() async {
    CpuInfo cpuInfo = await CpuReader.cpuInfo;
    print('Number of Cores ${cpuInfo.numberOfCores}');

    int freq = await CpuReader.getCurrentFrequency(2) ?? 0;
    print('Core number 2 freq ${freq} Mhz');

    CpuReader.cpuStream(1000)
        .listen((cpuInfo) => print("Temperature: ${cpuInfo.cpuTemperature}"));
  }

  void getSensorInfo() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      print(event);
    });
// [AccelerometerEvent (x: 0.0, y: 9.8, z: 0.0)]

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      print(event);
    });
// [UserAccelerometerEvent (x: 0.0, y: 0.0, z: 0.0)]

    gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);
    });
// [GyroscopeEvent (x: 0.0, y: 0.0, z: 0.0)]

    magnetometerEvents.listen((MagnetometerEvent event) {
      print(event);
    });
// [MagnetometerEvent (x: -23.6, y: 6.2, z: -34.9)]
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.green,
        title: const Text('Mobile HW Info'),
      ),
      body: Column(children: [TabBar(tabs: [])]),
    );
  }
}
