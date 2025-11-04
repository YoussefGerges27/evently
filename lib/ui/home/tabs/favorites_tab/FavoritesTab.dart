import 'package:evently_c16/core/reusable_components/CustomField.dart';
import 'package:evently_c16/core/source/remote/firestore_service.dart';
import 'package:evently_c16/models/Event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/reusable_components/CustomButton.dart';
import '../home_tab/widgets/EventItem.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  late TextEditingController searchController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomField(
                validation: (value) {
                  return null;
                },
                hint: "Search for Event",
                prefix: "assets/images/Search.svg",
                controller: searchController),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: FutureBuilder(
                future: FirestoreService.getAllEvents(),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
