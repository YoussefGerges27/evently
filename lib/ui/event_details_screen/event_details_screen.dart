import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/resources/dialog_utils.dart';
import 'package:evently_c16/core/source/remote/firestore_service.dart';
import 'package:evently_c16/models/Event.dart';
import 'package:evently_c16/ui/event_details_screen/widgets/custom_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen({super.key});
  late Event event;

  @override
  Widget build(BuildContext context) {
    Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event Details',
        ),
        actions: event.userId == FirebaseAuth.instance.currentUser!.uid
            ? [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.editEventScreen,
                      arguments: event,
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: ColorsManager.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    DialogUtils.showLoadingDialog(context);
                    await FirestoreService.deleteEvent(event.id!);
                    Navigator.pop(context);
                    DialogUtils.showToast('Event deleted successfully');
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: ColorsManager.redColor,
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showImage(event),
              const SizedBox(height: 16),
              Text(
                event.title ?? '',
                style: const TextStyle(
                  color: ColorsManager.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              CustomContainer(
                event: event,
                imagePath: 'assets/images/Calendar_Days.svg',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${event.dateTime?.toDate().day} ${event.dateTime?.toDate().month} ${event.dateTime?.toDate().year}',
                      style: const TextStyle(
                        color: ColorsManager.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${event.dateTime?.toDate().hour} : ${event.dateTime?.toDate().minute}',
                      style: const TextStyle(
                        color: ColorsManager.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomContainer(
                event: event,
                imagePath: 'assets/images/location.svg',
                hasIcon: true,
                content: const Text(
                  "Cairo , Egypt",
                  style: TextStyle(
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(
                  color: ColorsManager.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                event.desc ?? '',
                style: const TextStyle(
                  color: ColorsManager.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showImage(Event event) {
    if (event.type == 'book') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset('assets/images/Book-Club.png'),
      );
    } else if (event.type == 'sport') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset('assets/images/sport.png'),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset('assets/images/birthday.png'),
      );
    }
  }
}
