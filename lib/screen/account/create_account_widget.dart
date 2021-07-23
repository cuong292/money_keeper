import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/constant/constant_widget.dart';
import 'package:base_flutter/screen/account/account_cubit.dart';
import 'package:base_flutter/screen/account/login_input.dart';
import 'package:base_flutter/screen/account/question_view.dart';
import 'package:base_flutter/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountWidget extends StatefulWidget {
  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  late TextEditingController nameController;
  late TextEditingController imageController;
  late AccountCubit bloc;

  List<int> answer = List.filled(5, 0);

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    imageController = TextEditingController();
    bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(
          15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            LoginInput(
              controller: nameController,
              hintText: 'Nhập tên',
              icon: Icons.supervised_user_circle,
            ),
            height12view,
            LoginInput(
              controller: imageController,
              hintText: 'Đường dẫn ảnh',
              icon: Icons.image,
            ),
            height5view,
            QuestionView(
              1,
              'Xuân có dồ không?',
              'Có',
              'Không',
              (value) {
                answer[0] = value;
              },
            ),
            height5view,
            QuestionView(
              2,
              'Cường có đẹp trai không không?',
              'Có',
              'Không',
              (value) {
                answer[1] = value;
              },
            ),
            height5view,
            QuestionView(
              3,
              'Khi chồng hỏi thì phải trả lời tnao?',
              'Dạ',
              'Cái đéo gì?',
              (value) {
                answer[2] = value;
              },
            ),
            height5view,
            QuestionView(
              4,
              'Con chuột có hoá nhựa đc không?',
              'Hoá ác luốn',
              'Không hoá đc',
              (value) {
                answer[3] = value;
              },
            ),
            height5view,
            QuestionView(
              5,
              'Chồng nói có được nhăn mặt không?',
              'Có',
              'Không',
              (value) {
                answer[4] = value;
              },
            ),
            height12view,
            GestureDetector(
              onTap: () {
                List<int> wrong = [];
                if (answer[0] != 1) {
                  wrong.add(1);
                }
                if (answer[1] != 1) {
                  wrong.add(2);
                }
                if (answer[2] != 1) {
                  wrong.add(3);
                }
                if (answer[3] != 1) {
                  wrong.add(4);
                }
                if (answer[4] != 2) {
                  wrong.add(5);
                }
                if (wrong.length > 0) {
                  String wrongQuestion = '';
                  wrong.forEach((element) {
                    wrongQuestion += element.toString() + ', ';
                  });
                  bloc.showError(
                      'Các câu $wrongQuestion sai r. Trả lời lại đê :))');
                } else {
                  bloc.createAccount(context,nameController.text, imageController.text);
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: WidgetUtils.borderContainer(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Tạo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: ConstColor.colorPrimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
