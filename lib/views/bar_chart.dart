import 'package:expense_management/utils/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {

  List<BarChartGroupData> barGroups;
  double chartHighestSpent;

   _BarChart({this.barGroups, this.chartHighestSpent});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: true),
        maxY: (chartHighestSpent + (0.2 * chartHighestSpent)), // change to max amount spent in duration + 20%
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.transparent,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double numInThousands = number / 1000;
      return numInThousands.toStringAsFixed(1) + 'k';
    } else if (number < 1000000000) {
      double numInMillions = number / 1000000;
      return numInMillions.toStringAsFixed(1) + 'm';
    } else if (number < 1000000000000) {
      double numInBillions = number / 1000000000;
      return numInBillions.toStringAsFixed(1) + 'b';
    } else {
      double numInTrillions = number / 1000000000000;
      return numInTrillions.toStringAsFixed(1) + 't';
    }
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 8,
      fontFamily: 'satoshi-medium'
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    final style = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 6,
        fontFamily: 'satoshi-bold'
    );

    String text = formatNumber(value.round());

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getBottomTitles,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: getLeftTitles,
      ),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
      ),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
      ),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      Colors.white,
      Colors.white,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  // List<BarChartGroupData> get barGroups => [
  //   BarChartGroupData(
  //     x: 0,
  //     barRods: [
  //       BarChartRodData(
  //         toY: 103430,
  //         gradient: _barsGradient,
  //       )
  //     ],
  //     showingTooltipIndicators: [0],
  //   ),
  //   BarChartGroupData(
  //     x: 1,
  //     barRods: [
  //       BarChartRodData(
  //         toY:450323.6,
  //         gradient: _barsGradient,
  //       )
  //     ],
  //     showingTooltipIndicators: [0],
  //   ),
  //   BarChartGroupData(
  //     x: 2,
  //     barRods: [
  //       BarChartRodData(
  //         toY: 214530,
  //         gradient: _barsGradient,
  //       )
  //     ],
  //     showingTooltipIndicators: [0],
  //   ),
  //   BarChartGroupData(
  //     x: 3,
  //     barRods: [
  //       BarChartRodData(
  //         toY: 504540,
  //         gradient: _barsGradient,
  //       )
  //     ],
  //     showingTooltipIndicators: [0],
  //   ),
  //   BarChartGroupData(
  //     x: 4,
  //     barRods: [
  //       BarChartRodData(
  //         toY: 802320,
  //         gradient: _barsGradient,
  //       )
  //     ],
  //     showingTooltipIndicators: [0],
  //   ),
  //   BarChartGroupData(
  //     x: 5,
  //     barRods: [
  //       BarChartRodData(
  //         toY: 1201210,
  //         gradient: _barsGradient,
  //       )
  //     ],
  //     showingTooltipIndicators: [0],
  //   ),
  //   BarChartGroupData(
  //     x: 6,
  //     barRods: [
  //       BarChartRodData(
  //         toY: 550343,
  //         gradient: _barsGradient,
  //       )
  //     ],
  //     showingTooltipIndicators: [0],
  //   ),
  // ];

}

class BarChartSample3 extends StatefulWidget {

  double chartHighestSpent;
  List<BarChartGroupData> list;


  BarChartSample3({this.list, this.chartHighestSpent});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart(chartHighestSpent: widget.chartHighestSpent, barGroups: widget.list,),
    );
  }
}