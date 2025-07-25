import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        leading: IconButton(
          icon: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFE0E0E0)),
            ),
            child: const Center(
              child: Icon(Icons.arrow_back, color: AppTheme.textColor, size: 18),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          splashRadius: 18,
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppTheme.textColor,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        toolbarHeight: 48,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _notificationTile(
            icon: Icons.notifications_active_rounded,
            title: 'Welcome!',
            message: 'Thank you for joining MohitSharmaIndian.',
            time: 'Just now',
          ),
          _notificationTile(
            icon: Icons.play_circle_fill_rounded,
            title: 'Course Unlocked',
            message: 'You have unlocked the Flutter Basics course.',
            time: '2h ago',
          ),
          _notificationTile(
            icon: Icons.receipt_long_rounded,
            title: 'Order Confirmed',
            message: 'Your order #12345 has been confirmed.',
            time: 'Yesterday',
          ),
          _notificationTile(
            icon: Icons.download_rounded,
            title: 'Download Complete',
            message: 'Your course materials are ready to view offline.',
            time: '2 days ago',
          ),
        ],
      ),
    );
  }
}

Widget _notificationTile({
  required IconData icon,
  required String title,
  required String message,
  required String time,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(icon, color: AppTheme.primaryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
} 