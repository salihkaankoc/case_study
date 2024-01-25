import 'dart:convert';
import 'package:case_study/providers/api_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userValue = ref.watch(usersProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: userValue.when(
            data: (users) {
              return ListView.builder(
                itemCount: (users['data'] as List<dynamic>).length,
                itemBuilder: (context, index) {
                  final user = users['data'][index];
                  return ListTile(
                    title: Text(user['first_name']),
                    subtitle: Text(user['email']),
                  );
                },
              );
            },
            loading: () => const CircularProgressIndicator(
              color: Colors.deepPurpleAccent,
            ),
            error: (error, stackTrace) => Text('Error: $error'),
          ),
        ),
      ),
    );
  }
}
