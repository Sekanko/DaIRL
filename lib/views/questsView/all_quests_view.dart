import 'package:dairl/constants/colors.dart';
import 'package:flutter/material.dart';

class AllQuestsView extends StatefulWidget {
  const AllQuestsView({super.key});

  @override
  State<AllQuestsView> createState() => _AllQuestsViewState();
}

class _AllQuestsViewState extends State<AllQuestsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your quests", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ChronosQuestContainerList(),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       Expanded(child: ChronosQuestContainerList(color: dailyMainColor)),
      //       Expanded(child: ChronosQuestContainerList(color: monthlyMainColor)),
      //       Expanded(child: ChronosQuestContainerList(color: yearlyMainColor)),
      //     ],
      //   ),
      // ),
    );
  }
}

class ChronosQuestContainerList extends StatelessWidget {
  const ChronosQuestContainerList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// return Container(
//   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   decoration: BoxDecoration(
//     color: _colors[index].withValues(alpha: 0.6),
//     borderRadius: BorderRadius.circular(20),
//   ),
//   alignment: Alignment.topLeft,
//   padding: const EdgeInsets.all(20),
//   child: const Text('tak'),
// );
