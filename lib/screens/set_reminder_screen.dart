import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_radiotile_widget.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({super.key});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  final TextEditingController leadNameController = TextEditingController();
  final TextEditingController flatNumberController = TextEditingController();
  final TextEditingController areaNameController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController landMark = TextEditingController();

  final SingleValueDropDownController classTypeController =
      SingleValueDropDownController();
  String? radioSelection;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20).r,
                  child: SvgPicture.asset(AppImage.iconBackLightBorder),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        AppStrings.setReminderTitle,
                        style: AppTextStyle.instance.semiBoldBlack20,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.setReminderDescText,
                        style: AppTextStyle.instance.lightGrey16,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      buildRadioButton(AppStrings.everyWeek, "1"),
                      buildRadioButton(AppStrings.everyDay, "2"),
                      buildRadioButton(AppStrings.byDate, "3")
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextButton(
                          title: AppStrings.applyReminder,
                          onPressed: () {
                            if (isValidate()) {
                              Get.back(result: [radioSelection, _selectedDay]);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isValidate() {
    if (radioSelection == null) {
      UtilityHelper.instance
          .showError("Error", "Please select any one reminder");
      return false;
    }
    return true;
  }

  void _showCalender(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: 1.sw,
              height: 0.37.sh,
              child: Column(
                children: [
                  TableCalendar(
                    rowHeight: 35,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: AppTextStyle.instance.lightBlack12,
                      weekendStyle: AppTextStyle.instance.lightBlack12,
                    ),
                    headerStyle: HeaderStyle(
                        titleCentered: true,
                        leftChevronIcon: const Icon(Icons.chevron_left,
                            color: AppColors.black),
                        rightChevronIcon: const Icon(Icons.chevron_right,
                            color: AppColors.black),
                        titleTextStyle: AppTextStyle.instance.lightBlack14),
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.sunday ||
                            day.weekday == DateTime.saturday) {
                          final text = DateFormat.E().format(day);

                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.pinkCalenderWeekDay),
                            ),
                          );
                        }
                      },
                    ),
                    calendarStyle: CalendarStyle(
                        selectedTextStyle: AppTextStyle.instance.semiBoldBlue16,
                        outsideDaysVisible: false,
                        selectedDecoration:
                            const BoxDecoration(color: Colors.transparent),
                        todayDecoration:
                            const BoxDecoration(color: Colors.transparent),
                        disabledTextStyle: AppTextStyle.instance.lightGrey12,
                        todayTextStyle: AppTextStyle.instance.semiBoldBlue16,
                        defaultTextStyle: AppTextStyle.instance.lightGrey12,
                        weekendTextStyle: AppTextStyle.instance.lightGrey12,
                        outsideTextStyle: AppTextStyle.instance.lightGrey12,
                        holidayTextStyle: AppTextStyle.instance.lightGrey12),
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2030, 3, 14),
                    currentDay: _selectedDay,
                    focusedDay: _focusedDay,
                  ),
                ],
              ),
            );
          }),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                      child: AppTextButton(
                    title: AppStrings.cancel,
                    side: const BorderSide(color: Color(0xff4E4E4E)),
                    backgroundColor: Colors.white,
                    titleStyle: AppTextStyle.instance.lightGrey14,
                    onPressed: () {
                      setState(() {
                        radioSelection = null;
                        _selectedDay = null;
                      });

                      Get.back();
                    },
                  )),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: AppTextButton(
                    titleStyle: AppTextStyle.instance.lightWhite14,
                    title: AppStrings.apply,
                    onPressed: () {
                      setState(() {
                        _selectedDay ??= _focusedDay;
                      });

                      Get.back();
                    },
                  ))
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildRadioButton(String title, String value) {
    return AppRadioTileWidget(
      title: title,
      subtitle: _selectedDay != null && value == '3'
          ? Transform.translate(
              offset: const Offset(-18, 0),
              child: Text(
                UtilityHelper.instance
                    .convertDateToString(_selectedDay!, 'dd/MM/yyyy'),
                style: AppTextStyle.instance.lightGrey14,
              ))
          : null,
      value: value,
      groupValue: radioSelection,
      onChanged: (value) {
        setState(() {
          radioSelection = value.toString();
        });
        if (value.toString() == '3') {
          if (_selectedDay == null) {
            _showCalender(context);
          }
        } else {
          _selectedDay = null;
        }
      },
    );
  }
}

