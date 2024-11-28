import 'package:flutter/material.dart';

class ShowRatingWidget extends StatefulWidget {
  ShowRatingWidget({super.key});

  @override
  State<ShowRatingWidget> createState() => _ShowRatingWidgetState();
}

class _ShowRatingWidgetState extends State<ShowRatingWidget> {
  @override
  Widget build(BuildContext context) {
    double score = 1;
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              borderOnForeground: true,
              margin: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Text("${(score * 100).toInt()}%"),
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Divider(
                  color: Colors.black,
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width *
                      0.63 *
                      score, // Вычисляем позицию кружка
                  top: -2, // Поднимаем кружок, чтобы он был на уровне линии
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    width: 19, // Размер кружка
                    height: 19,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  'assets/sad_face.png',
                  scale: 10,
                ),
                const Spacer(),
                Image.asset('assets/smile_face.png', scale: 10)
              ],
            )
          ],
        ),
      ),
    );
  }
}
