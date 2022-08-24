import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hw_info_app/components/tabbar_item.dart';
import 'package:flutter_hw_info_app/screens/general.dart';
import 'package:flutter_hw_info_app/screens/soc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:system_info_plus/system_info_plus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
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

  late TabController _tabController;

  final List<Widget> _tabBarItemList = [
    const TabBarItem(text: 'GENERAL'),
    const TabBarItem(text: 'SOC'),
    const TabBarItem(text: 'MEMORY'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBarItemList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.green,
        title: const Text('Mobile HW Info'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(color: Colors.green.shade300, width: 5),
              ),
            ),
            tabs: _tabBarItemList,
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              GeneralInfoPage(),
              SoCInfoPage(),
              SoCInfoPage(),
            ]),
          )
        ],
      ),
    );
  }
}
