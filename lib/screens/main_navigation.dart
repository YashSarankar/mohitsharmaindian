import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home/home_screen.dart';
import 'dart:ui';
import 'home/cart_screen.dart';
import 'home/my_courses_screen.dart';
import 'home/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false; // Prevent app exit
        } else {
          // Show professional confirmation dialog
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              titlePadding: const EdgeInsets.only(top: 24),
              title: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red[50],
                    radius: 28,
                    child: Icon(Icons.exit_to_app, color: Colors.red[400], size: 32),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Exit Application',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              content: const Text(
                'Are you sure you want to exit the app?',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Exit', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
          return shouldExit ?? false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            const MyCoursesScreen(),
            const CartScreen(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey[200]!,
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              clipBehavior: Clip.none,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildNavItem(
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home_rounded,
                        label: 'Home',
                        index: 0,
                      )),
                      Expanded(child: _buildNavItem(
                        icon: Icons.menu_book_outlined,
                        activeIcon: Icons.menu_book_rounded,
                        label: 'Courses',
                        index: 1,
                      )),
                      // Empty space for center button
                      Container(width: 80),
                      Expanded(child: _buildNavItem(
                        icon: Icons.shopping_cart_outlined,
                        activeIcon: Icons.shopping_cart_rounded,
                        label: 'Cart',
                        index: 2,
                      )),
                      Expanded(child: _buildNavItem(
                        icon: Icons.person_outline_rounded,
                        activeIcon: Icons.person_rounded,
                        label: 'Profile',
                        index: 3,
                      )),
                    ],
                  ),
                  // Floating center button
                  Positioned(
                    top: -15,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: _buildCenterExploreButton(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onTabTapped(index),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected 
                    ? theme.primaryColor
                    : Colors.grey[500],
                size: 22,
              ),
              const SizedBox(height: 1),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected 
                      ? theme.primaryColor
                      : Colors.grey[500],
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterExploreButton() {
    final theme = Theme.of(context);

    return Container(
      height: 60,
      width: 60,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showExploreBottomSheet(),
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.explore_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  void _showExploreBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildExploreBottomSheet(),
    );
  }

  Widget _buildExploreBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6, // Reduced from 0.85
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18), // Slightly less rounded
          topRight: Radius.circular(18),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 4), // Less margin
            width: 32, // Smaller handle
            height: 3,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4), // Less padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Explore Our Courses',
                      style: TextStyle(
                        fontSize: 18, // Smaller font
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 2), // Less space
                const Text(
                  'Browse categories and discover the right courses and resources for your UPSC journey.',
                  style: TextStyle(
                    fontSize: 11, // Smaller font
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10), // Less padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8, // Less spacing
                    mainAxisSpacing: 8, // Less spacing
                    childAspectRatio: 1.7, // Slightly more compact
                    children: [
                      _buildCategoryCard('GS Foundation', Icons.school, Colors.blue),
                      _buildCategoryCard('IAS Prelims', Icons.quiz, Colors.green),
                      _buildCategoryCard('IAS Mains', Icons.assignment, Colors.orange),
                      _buildCategoryCard('Optional', Icons.book, Colors.purple),
                      _buildCategoryCard('Test Series', Icons.analytics, Colors.red),
                      _buildCategoryCard('Mentorship', Icons.people, Colors.teal),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Less rounded
        color: color.withOpacity(0.08), // Slightly lighter
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: color), // Smaller icon
          const SizedBox(height: 4), // Less space
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: 11, // Smaller font
            ),
          ),
        ],
      ),
    );
  }
} 