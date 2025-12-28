import 'package:flutter/material.dart';
import 'package:lenga_edu/ui/widgets/home/home_disciplines_section.dart';
import 'package:lenga_edu/ui/widgets/home/home_featured_section.dart';
import 'package:lenga_edu/ui/widgets/home/home_header.dart';
import 'package:lenga_edu/ui/widgets/home/home_recent_activity_section.dart';
import 'package:lenga_edu/ui/widgets/home/home_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Column(
        children: [
          HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeStatus(), // Keeping this small helper here or move it? It's small.
                  SizedBox(height: 32),
                  HomeFeaturedSection(),
                  SizedBox(height: 32),
                  HomeDisciplinesSection(),
                  SizedBox(height: 32),
                  HomeRecentActivitySection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
