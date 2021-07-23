import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/constant/constant_widget.dart';
import 'package:base_flutter/screen/home/home_cubit.dart';
import 'package:base_flutter/screen/home/home_state.dart';
import 'package:base_flutter/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'currency_input_formatter.dart';

class CreateBillWidget extends StatefulWidget {
  @override
  _CreateBillWidgetState createState() => _CreateBillWidgetState();
}

class _CreateBillWidgetState extends State<CreateBillWidget> {
  final TextEditingController reasonController = TextEditingController();

  final TextEditingController moneyController = TextEditingController();

  late GlobalKey<FormState> reasonKey;

  late GlobalKey<FormState> moneyKey;

  List<int> suggestions = [];

  int checked = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reasonKey = GlobalKey<FormState>();
    moneyKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FractionallySizedBox(
          heightFactor: 3 / 5,
          child: SingleChildScrollView(child: bodyView(context)),
        ),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Form(
            key: reasonKey,
            child: TextFormField(
              controller: reasonController,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              onFieldSubmitted: (value) async {
                if (reasonKey.currentState!.validate() &&
                    moneyKey.currentState!.validate()) {
                  await BlocProvider.of<HomeCubit>(context).addBill(
                    reasonController.text,
                    moneyController.text,
                    checked,
                  );
                  reasonController.text = '';
                  moneyController.text = '';
                  setState(() {
                    checked = 0;
                  });
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: ConstColor.grayF2F,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: ConstColor.colorPrimary,
                    width: 1,
                  ),
                ),
                hintText: 'Nhập tên khoản thu/chi',
              ),
            ),
          ),
          height8view,
          Form(
            key: moneyKey,
            child: TextFormField(
              controller: moneyController,
              onChanged: (value) {
                setState(
                  () {
                    if (value.isEmpty||value == '-') {
                      suggestions.clear();
                      return;
                    }
                    int data = int.parse(value.replaceAll('.', ''));
                    suggestions.clear();
                    if (data == 0) return;
                    suggestions.add(data * 1000);
                    suggestions.add(data * 10000);
                    suggestions.add(data * 100000);
                    suggestions.add(data * 1000000);
                  },
                );
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) async {
                if (reasonKey.currentState!.validate() &&
                    moneyKey.currentState!.validate()) {
                  await BlocProvider.of<HomeCubit>(context).addBill(
                    reasonController.text,
                    moneyController.text,
                    checked,
                  );
                  reasonController.text = '';
                  moneyController.text = '';
                  setState(() {
                    checked = 0;
                  });
                }
              },
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Chưa nhập tiền";
                }
              },
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              inputFormatters: [CurrencyInputFormatter()],
              decoration: InputDecoration(
                hintText: 'Nhập tiền',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: ConstColor.grayF2F,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: ConstColor.colorPrimary,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Container(
              child: Container(
            color: ConstColor.grayF2F,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: suggestions
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        moneyController.text = NumberFormat("#,###").format(e);
                        setState(() {
                          suggestions.clear();
                        });
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: WidgetUtils.borderContainer(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            '${NumberFormat("#,###").format(e)}đ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
