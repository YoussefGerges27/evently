import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16/core/resources/AppConstants.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/resources/dialog_utils.dart';
import 'package:evently_c16/core/reusable_components/CustomButton.dart';
import 'package:evently_c16/core/reusable_components/CustomField.dart';
import 'package:evently_c16/core/source/remote/firestore_service.dart';
import 'package:evently_c16/models/Event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/resources/ColorsManager.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  int selectedTap = 0;
  late TextEditingController titleController;
  late TextEditingController descController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Event oldEvent;

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {},
    // );
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Event oldEvent = ModalRoute.of(context)!.settings.arguments as Event;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Event"),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.25,
                    child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/Book-Club.png",
                                fit: BoxFit.fill,
                              )),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/sport.png",
                                fit: BoxFit.fill,
                              )),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/birthday.png",
                                fit: BoxFit.fill,
                              )),
                        ]),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TabBar(
                      onTap: (value) {
                        setState(() {
                          selectedTap = value;
                        });
                      },
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      unselectedLabelColor: ColorsManager.primaryColor,
                      labelColor: ColorsManager.lightBackgroundColor,
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      unselectedLabelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      dividerHeight: 0,
                      indicatorColor: Colors.white,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(46),
                        color: ColorsManager.primaryColor,
                      ),
                      tabs: [
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(
                                    color: ColorsManager.primaryColor)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/book-open.svg",
                                  colorFilter: ColorFilter.mode(
                                      selectedTap == 0
                                          ? ColorsManager.lightBackgroundColor
                                          : ColorsManager.primaryColor,
                                      BlendMode.srcIn),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Book Club")
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(
                                    color: ColorsManager.primaryColor)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/bike.svg",
                                  colorFilter: ColorFilter.mode(
                                      selectedTap == 1
                                          ? ColorsManager.lightBackgroundColor
                                          : ColorsManager.primaryColor,
                                      BlendMode.srcIn),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Sport")
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(
                                    color: ColorsManager.primaryColor)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/cake.svg",
                                  colorFilter: ColorFilter.mode(
                                      selectedTap == 2
                                          ? ColorsManager.lightBackgroundColor
                                          : ColorsManager.primaryColor,
                                      BlendMode.srcIn),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Birthday")
                              ],
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Title",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomField(
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Should add event title";
                        }
                      },
                      hint: "Enter the event title",
                      prefix: "assets/images/Note_Edit.svg",
                      controller: titleController),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomField(
                    maxLines: 5,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Should add event description";
                      }
                    },
                    hint: "Enter the event description",
                    controller: descController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/Calendar_Days.svg"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Event Date",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          chooseDate();
                        },
                        child: Text(
                            selectedDate == null
                                ? "Choose Date"
                                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: ColorsManager.primaryColor)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/Clock.svg"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Event Time",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          chooseTime();
                        },
                        child: Text(
                            selectedTime == null
                                ? "Choose Time"
                                : "${selectedTime!.hourOfPeriod}:${selectedTime!.minute}${selectedTime!.period.name}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: ColorsManager.primaryColor)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    title: "Edit Event",
                    onPress: () {
                      createNewEvent(oldEvent);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  chooseDate() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
      });
    }
  }

  TimeOfDay? selectedTime;
  chooseTime() async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (newTime != null) {
      setState(() {
        selectedTime = newTime;
      });
    }
  }

  createNewEvent(Event oldEvent) async {
    if (formKey.currentState!.validate()) {
      if (selectedDate != null && selectedTime != null) {
        Event event = Event(
          type: eventTypes[selectedTap],
          title: titleController.text,
          desc: descController.text,
          dateTime: Timestamp.fromDate(
            DateTime(
              selectedDate!.year,
              selectedDate!.month,
              selectedDate!.day,
              selectedTime!.hour,
              selectedTime!.minute,
            ),
          ),
          userId: FirebaseAuth.instance.currentUser!.uid,
        );
        DialogUtils.showLoadingDialog(context);
        await FirestoreService.updateEvent(oldEvent.id!, event);
        Navigator.pop(context);
        DialogUtils.showToast("Event created successfully");
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.homeScreen,
          (route) => false,
        );
      } else {
        DialogUtils.showToast("Please choose date and time");
      }
    }
  }
}
