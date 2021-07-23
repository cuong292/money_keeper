import 'package:base_flutter/base/bloc/base_cubit.dart';
import 'package:base_flutter/base/bloc/base_state.dart';
import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/constant/constant_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BaseCubitAppBar<B extends BaseCubit<S>, S extends BaseState>
    extends PreferredSize {
  final IconData? leftIconRsc;
  final IconData? rightIconRsc;
  VoidCallback? onLeftCLick;
  VoidCallback? onRightClick;
  bool showRightAction;

  Widget? rightActionBuilder;

  bool showLeftAction;

  @override
  Widget build(BuildContext mainContext) {
    // TODO: implement build
    return BlocBuilder<B, S>(
      buildWhen: (previous, current) =>
          previous.screenTitle != current.screenTitle,
      builder: (context, state) => Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: 20),
        color: ConstColor.colorPrimary,
        child: state.screenTitle.length > 15 &&
                (showRightAction && rightActionBuilder != null)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  showLeftAction
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child: IconButton(
                            icon: Icon(
                              leftIconRsc ?? Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => onLeftCLick != null
                                ? onLeftCLick!()
                                : back(mainContext),
                          ),
                        )
                      : emptyView,
                  Expanded(
                    child: Text(
                      state.screenTitle,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  showRightAction
                      ? rightActionBuilder ??
                          GestureDetector(
                            onTap: () =>
                                onRightClick != null ? onRightClick : () {},
                            behavior: HitTestBehavior.translucent,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(rightIconRsc, color: Colors.white)),
                          )
                      : emptyView
                ],
              )
            : Stack(
                children: <Widget>[
                  showLeftAction
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: IconButton(
                              onPressed: () => onLeftCLick != null
                                  ? onLeftCLick!()
                                  : back(mainContext),
                              icon: Icon(
                                leftIconRsc,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : emptyView,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      state.screenTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  showRightAction
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: rightActionBuilder ??
                              GestureDetector(
                                onTap: () => onRightClick!(),
                                behavior: HitTestBehavior.translucent,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(rightIconRsc,
                                        color: Colors.white)),
                              ),
                        )
                      : emptyView
                ],
              ),
      ),
    );
  }

  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  BaseCubitAppBar({
    this.rightIconRsc,
    this.showRightAction = false,
    this.onLeftCLick,
    this.onRightClick,
    this.leftIconRsc = Icons.arrow_back,
    this.showLeftAction = true,
    this.rightActionBuilder,
  }) : super(preferredSize: const Size.fromHeight(56), child: emptyView);
}

class CalendarWidget extends StatefulWidget {
  final Function _onDateSelectedCallBack;
  final int defaultDate;

  CalendarWidget(this._onDateSelectedCallBack, this.defaultDate);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalendarWidget> {
  DateTime _selectedDate = DateTime.now();

  void _showPicker() async {
    var newDateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (newDateTime != null && newDateTime != _selectedDate) {
      setState(() {
        _selectedDate = newDateTime;
      });
      widget._onDateSelectedCallBack(_selectedDate);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _selectedDate =
        DateTime.fromMillisecondsSinceEpoch(widget.defaultDate, isUtc: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showPicker,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              DateFormat('dd/MM/yyyy').format(_selectedDate),
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Icon(
              Icons.date_range,
              color: Colors.white,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
