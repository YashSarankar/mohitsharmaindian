import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../theme/app_theme.dart';
import 'notification_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 48,
        titleSpacing: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.2,
            color: AppTheme.textColor,
            fontFamily: 'Poppins',
          ),
        ),
        leading: null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none_rounded, color: AppTheme.textColor, size: 18),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const NotificationScreen()),
                      );
                    },
                    splashRadius: 18,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints.tightFor(width: 32, height: 32),
                    alignment: Alignment.center,
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Center(
                      child: Text('2', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(top: 4, bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xFFF5F5F5),
                      child: Icon(Icons.person, size: 28, color: Colors.blueGrey[300]),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Yash shaft', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Poppins', color: Colors.black)),
                          SizedBox(height: 1),
                          Text('8085042656', style: TextStyle(fontSize: 12, color: Colors.black87, fontFamily: 'Poppins')),
                          SizedBox(height: 1),
                          Text('yashshaft@gmail.com', style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Poppins')),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                            );
                          },
                          child: Icon(CupertinoIcons.square_pencil_fill , color: AppTheme.primaryColor, size: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                            );
                          },
                          child: const Text('Edit Profile', style: TextStyle(fontSize: 10, color: AppTheme.primaryColor, fontFamily: 'Poppins')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Progress Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('My Progress', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black, fontFamily: 'Poppins')),
                  Icon(Icons.insights_sharp, color: AppTheme.primaryColor, size: 26),
                ],
              ),
              const SizedBox(height: 18),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AppTheme.primaryColor.withOpacity(0.12), Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('0.0%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: AppTheme.primaryColor, fontFamily: 'Poppins')),
                            SizedBox(height: 2),
                            Text('Overall', style: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'Poppins')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Overall Completion of the Course!',
                  style: TextStyle(fontSize: 15, color: Colors.black87, fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 24),
              // Stats Cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.6,
                children: const [
                  _StatCard(title: '00/00', subtitle: 'Test Series', description: 'Test your mettle'),
                  _StatCard(title: '00/00', subtitle: 'Class Videos', description: 'Learn from the best'),
                  _StatCard(title: '00/00', subtitle: 'AWM', description: 'AWM'),
                  _StatCard(title: '00/00', subtitle: 'Notes', description: 'Notes'),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  const _StatCard({required this.title, required this.subtitle, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black38, fontFamily: 'Poppins')),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black, fontFamily: 'Poppins')),
          const SizedBox(height: 2),
          Text(description, style: const TextStyle(fontSize: 13, color: Colors.black54, fontFamily: 'Poppins')),
        ],
      ),
    );
  }
} 