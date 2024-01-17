
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_checkboxtile_widget.dart';
import 'package:inquiryapp/common/widgets/app_radiotile_widget.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/common/widgets/app_text_form_field.dart';
import 'package:inquiryapp/screens/add_lead/controller/add_lead_controller.dart';
import 'package:inquiryapp/screens/export/controller/export_lead_controller.dart';
import 'package:inquiryapp/screens/home/controller/home_controller.dart';
import 'package:tab_container/tab_container.dart';

class AllFilterWidget extends StatefulWidget {
  AllFilterWidget({super.key,required this.controller,required this.callback});
  TabContainerController controller = TabContainerController(length: 3);
  final Function(bool) callback;
  @override
  State<AllFilterWidget> createState() => _AllFilterWidgetState();
}

TextEditingController dateController = TextEditingController();
DateTimeRange? selectedRange;
String? radioSelection;
bool isChecked = false;
bool isFilterApplied = false;

class _AllFilterWidgetState extends State<AllFilterWidget> {
  final HomeDataController homeDataController = Get.put(HomeDataController());
  final ExportLeadDataController exportLeadDataController = Get.put(ExportLeadDataController());


  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder:
        (BuildContext context,
        StateSetter mySetState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment:
            MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  AppStrings.filters,
                  style: AppTextStyle
                      .instance.semiBoldBlack16,
                ),
              ),
            ],
          ),
          const Divider(),
          SizedBox(
            height: 0.32.sh,
            child: TabContainer(
              controller: widget.controller,
              tabEdge: TabEdge.left,
              childPadding: EdgeInsets.zero,

              // color: Theme.of(context)
              //     .colorScheme
              //     .secondary,
              tabExtent: 100,
              isStringTabs: false,
              onEnd: () => {mySetState(() {})},
              tabs: <Widget>[
                buildRowCategoryFilter('Class', 0),
                buildRowCategoryFilter(
                    'Category', 1),
                buildRowCategoryFilter('By date', 2)
              ],
              children: [
                wrapperMainContainer([
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "FILTER BY CLASS",
                                style: AppTextStyle
                                    .instance
                                    .lightBlack12,
                              )
                            ],
                          ),
                          GetBuilder<AddLeadDataController>(
                              builder: (addLeadDataController) {
                                return Expanded(
                                  child: addLeadDataController.leadCategory.isNotEmpty ? ListView.builder(
                                    itemBuilder:
                                        (context, index) {
                                      final leadCategory = addLeadDataController.leadCategory[index];
                                      return SizedBox(
                                        height: 40,
                                        child:
                                        AppRadioTileWidget(
                                          title:
                                          leadCategory.name ?? '',
                                          value: leadCategory.id ?? '',
                                          groupValue:
                                          radioSelection,
                                          onChanged:
                                              (value) {
                                            mySetState(() {
                                              radioSelection =
                                                  value
                                                      .toString();
                                            });
                                          },
                                        ),
                                      );
                                    },
                                    itemCount: addLeadDataController.leadCategory.length,
                                  ) : const Center(child: Text("No Category Found")),
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
                wrapperMainContainer([
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "FILTER BY CLASS",
                                style: AppTextStyle
                                    .instance
                                    .lightBlack12,
                              )
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder:
                                  (context, index) {
                                return SizedBox(
                                  height: 40,
                                  child:
                                  AppCheckBoxTileWidget(
                                    title:
                                    "Class-A",
                                    value: index ==
                                        0 ||
                                        index == 1,
                                    groupValue:
                                    isChecked,
                                    onChanged:
                                        (value) {
                                      if (value !=
                                          null) {
                                        mySetState(
                                                () {
                                              isChecked =
                                                  value;
                                            });
                                      }
                                    },
                                  ),
                                );
                              },
                              itemCount: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
                wrapperMainContainer([
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "FILTER BY DATE",
                                style: AppTextStyle
                                    .instance
                                    .lightBlack12,
                              )
                            ],
                          ),
                          const SizedBox(height: 15,),
                          AppTextFormField(
                              title: "Date",
                              hintText:
                              "Please select date",
                              readOnly: true,
                              onTap: () {
                                _showDatePicker(context);
                              },
                              controller:
                              dateController)
                        ],
                      ),
                    ),
                  ),

                ]),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: AppTextButton(
                    title: AppStrings.clearFilters,
                    side: const BorderSide(
                        color: Colors.transparent),
                    backgroundColor:
                    Colors.transparent,
                    titleStyle: AppTextStyle
                        .instance.semiBoldGrey16,
                    onPressed: () async {
                      log("Clear Filter");
                      mySetState(() {
                        dateController = TextEditingController();
                        radioSelection = null;
                        selectedRange = null;
                        widget.callback(false);

                      });
                      Get.back();
                      await homeDataController.getLeads();
                      exportLeadDataController.setLeads(homeDataController.leads);
                    },
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: AppTextButton(
                    title: AppStrings.apply,
                    onPressed: () async {
                      Get.back();
                      if (radioSelection != null || selectedRange != null) {
                        widget.callback(true);
                      }
                      await homeDataController.getLeads(classType: radioSelection,dateRange: selectedRange);
                      exportLeadDataController.setLeads(homeDataController.leads);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  SizedBox wrapperMainContainer(List<Widget> children) {
    return SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppColors.dividerGrey,
              height: 1.sh,
              width: 0.6,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            ),
          ],
        ));
  }

  Row buildRowCategoryFilter(String title, int index) {
    return Row(
      children: [
        if (widget.controller.index == index)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 7,
            decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: widget.controller.index == index
              ? AppTextStyle.instance.semiBoldBlue16
              : AppTextStyle.instance.semiBoldBlack16,
        )
      ],
    );
  }

  _showDatePicker(BuildContext context) async {
    UtilityHelper.instance.hideFocus();
    final date = await UtilityHelper.instance.showDateRangePickerWidget(context);
    if (date != null) {
      selectedRange = date;
      DateTime startDate = date.start;
      DateTime endDate = date.end;
      String selectedDates = '${UtilityHelper.instance.convertDateToString(startDate, "dd/MM/yyyy")} - ${UtilityHelper.instance.convertDateToString(endDate, "dd/MM/yyyy")}';
      dateController.text = selectedDates;
    }
    setState(() {

    });
  }
}
