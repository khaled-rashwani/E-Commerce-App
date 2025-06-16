// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// class PieChartSample extends StatefulWidget {
//   @override
//   _PieChartSampleState createState() => _PieChartSampleState();
// }
//
// class _PieChartSampleState extends State<PieChartSample> {
//   late int touchedIndex=0;
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: PieChart(
//         PieChartData(
//           pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
//             setState(() {
//               final desiredTouch = event is! PointerExitEvent && event is! PointerUpEvent;
//               if (desiredTouch && pieTouchResponse?.touchedSection != null) {
//                 touchedIndex = pieTouchResponse!.touchedSection!.touchedSectionIndex;
//               } else {
//                 touchedIndex = -1;
//               }
//             });
//           }),
//           borderData: FlBorderData(
//             show: false,
//           ),
//           sectionsSpace: 0,
//           centerSpaceRadius: 40,
//           sections: showingSections(),
//         ),
//       ),
//     );
//   }
//
//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = i == touchedIndex;
//       final double fontSize = isTouched ? 25 : 16;
//       final double radius = isTouched ? 60 : 50;
//
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: Colors.red,
//             value: 40,
//             title: '40%',
//             radius: radius,
//             titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: Colors.green,
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: Colors.blue,
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: Colors.yellow,
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }