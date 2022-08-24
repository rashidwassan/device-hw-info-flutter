import 'package:flutter/material.dart';
import 'package:flutter_hw_info_app/components/tabbar_item.dart';
import 'package:flutter_hw_info_app/screens/main_screen_tabs/battery.dart';
import 'package:flutter_hw_info_app/screens/main_screen_tabs/camera.dart';
import 'package:flutter_hw_info_app/screens/main_screen_tabs/general.dart';
import 'package:flutter_hw_info_app/screens/main_screen_tabs/memory.dart';
import 'package:flutter_hw_info_app/screens/main_screen_tabs/screen.dart';
import 'package:flutter_hw_info_app/screens/main_screen_tabs/soc.dart';
import 'package:flutter_hw_info_app/screens/main_screen_tabs/system.dart';
import 'package:flutter_hw_info_app/screens/main_screen_tabs/thermal.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:system_info_plus/system_info_plus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  void getDeviceMemory() async {
    int? deviceMemory = await SystemInfoPlus.physicalMemory; // returns in MB
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
    const TabBarItem(text: 'SYSTEM'),
    const TabBarItem(text: 'SCREEN'),
    const TabBarItem(text: 'MEMORY'),
    const TabBarItem(text: 'CAMERA'),
    const TabBarItem(text: 'BATTERY'),
    const TabBarItem(text: 'THERMAL'),
    // const TabBarItem(text: 'SENSORS'),
    // const TabBarItem(text: 'APPLICATIONS'),
    // const TabBarItem(text: 'PARTITIONS'),
    // const TabBarItem(text: 'Wi-Fi'),
    // const TabBarItem(text: 'BLUETOOTH'),
    // const TabBarItem(text: 'INPUT'),
    // const TabBarItem(text: 'CODECS'),
    // const TabBarItem(text: 'USB'),
    // const TabBarItem(text: 'MY APPS'),
  ];

  final List<Widget> _tabViewItemList = [
    const GeneralInfoPage(),
    const SoCInfoPage(),
    const SystemInfoPage(),
    const ScreenInfoPage(),
    const MemoryInfoPage(),
    const CameraInfoPage(),
    const BatteryInfoPage(),
    const ThermalInfoPage(),
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
            isScrollable: true,
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                controller: _tabController,
                children: _tabViewItemList,
              ),
            ),
          )
        ],
      ),
    );
  }
}
