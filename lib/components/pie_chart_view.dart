import 'package:flutter/material.dart';
import 'package:flutter_hw_info_app/components/pie_chart.dart';

class PieChartView extends StatelessWidget {
  const PieChartView(
      {required this.centerText, required this.total, required this.usage});
  final String centerText;
  final double usage;
  final double total;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => DecoratedBox(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(193, 214, 233, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.white,
              ),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Color.fromRGBO(146, 182, 216, 1),
              )
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.6,
                  child: CustomPaint(
                    foregroundPainter: PieChart(
                      width: constraint.maxWidth * 0.5,
                      categories: [
                        Category('Total Mem', amount: usage),
                        Category('Used Mem', amount: total),
                      ],
                    ),
                    child: const Center(),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: constraint.maxWidth * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      const BoxShadow(
                        blurRadius: 1,
                        offset: Offset(-1, -1),
                        color: Colors.white,
                      ),
                      BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: const Offset(5, 5),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      centerText,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
