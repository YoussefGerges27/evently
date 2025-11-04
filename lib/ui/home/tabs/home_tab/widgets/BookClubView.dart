import 'package:evently_c16/core/source/remote/firestore_service.dart';
import 'package:evently_c16/models/Event.dart';
import 'package:flutter/material.dart';

import '../../../../../core/reusable_components/CustomButton.dart';

import 'EventItem.dart';

class BookClubView extends StatelessWidget {
  const BookClubView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService.getTypeEvents("book"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // loading state
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Column(
            children: [
              Text(snapshot.error!.toString()),
              CustomButton(title: "Try Again", onPress: () {}),
            ],
          );
        }
        List<Event> events = snapshot.data ?? [];
        return ListView.separated(
            itemBuilder: (context, index) => EventItem(
                  event: events[index],
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 16,
                ),
            itemCount: events.length);
      },
    );
  }
}
