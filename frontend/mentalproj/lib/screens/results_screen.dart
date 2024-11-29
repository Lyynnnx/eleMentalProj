import 'package:flutter/material.dart';
import 'package:mentalproj/widgets/show_rating_widget.dart';

class ResultsScreen extends StatelessWidget {
  final double score = 75.0;
  final List<ResultItem> results = [
    ResultItem(text: "Lorem ipsum odor amet, consectetur adipiscing elit.", isCorrect: true),
    ResultItem(text: "Lorem ipsum odor amet, consectetur adipiscing elit.", isCorrect: true),
    ResultItem(
        text: "Lorem ipsum odor amet, consectetur adipiscing elit. Maecenas placerat tincidunt ac mauris vehicula a nisi facilisis.",
        isCorrect: false),
    ResultItem(text: "Lorem ipsum odor amet, consectetur adipiscing elit.", isCorrect: true),
    ResultItem(text: "Lorem ipsum odor amet, consectetur adipiscing elit.", isCorrect: true),
    ResultItem(
        text: "Lorem ipsum odor amet, consectetur adipiscing elit. Maecenas placerat tincidunt ac mauris vehicula a nisi facilisis.",
        isCorrect: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Добавить функционал меню
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Results',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              child: ShowRatingWidget(),
            ),
            // Container(
            //   padding: EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.green),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Text(
            //     '${score.toInt()}%',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     //Icon(Icons.sentiment_dissatisfied, color: Colors.red, size: 36),
            //     //Icon(Icons.sentiment_satisfied, color: Colors.green, size: 36),
            //     Image.asset('assets/smile_face.png', scale: 10),
            //     Image.asset('assets/sad_face.png', scale: 10)
            //   ],
            // ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        result.isCorrect ? Icons.check : Icons.close,
                        color: result.isCorrect ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          result.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Добавить функционал для "Extended results"
              },
              child: Text('Extended results'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultItem {
  final String text;
  final bool isCorrect;

  ResultItem({required this.text, required this.isCorrect});
}
