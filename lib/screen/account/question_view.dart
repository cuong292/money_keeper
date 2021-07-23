import 'package:base_flutter/screen/home/custom_checkbox.dart';
import 'package:flutter/material.dart';

class QuestionView extends StatefulWidget {
  int index;

  String question;

  void Function(int answer) onAnswerChanged;

  var hint1;

  var hint2;

  @override
  _QuestionViewState createState() => _QuestionViewState();

  QuestionView(
      this.index, this.question, this.hint1, this.hint2, this.onAnswerChanged);
}

class _QuestionViewState extends State<QuestionView> {
  int answer = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.index.toString()}. ${widget.question}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    widget.hint1,
                  ),
                  CustomCheckBox(
                    answer == 1,
                    (checked) {
                      if (checked) {
                        setState(() {
                          answer = 1;
                          widget.onAnswerChanged(answer);
                        });
                      } else {
                        setState(() {
                          answer = -1;
                          widget.onAnswerChanged(answer);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    widget.hint2,
                  ),
                  CustomCheckBox(
                    answer == 2,
                    (checked) {
                      if (checked) {
                        setState(() {
                          answer = 2;
                          widget.onAnswerChanged(answer);
                        });
                      } else {
                        setState(() {
                          answer = -1;
                          widget.onAnswerChanged(answer);
                        });
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
