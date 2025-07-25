import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home/home_screen.dart';
import 'dart:ui';
import 'dart:math';
import '../widgets/course_card.dart';
import '../models/course.dart';
import 'home/cart_screen.dart';
import 'home/my_courses_screen.dart';
import 'home/profile_screen.dart';
import 'package:provider/provider.dart';
import '../models/bottom_nav_provider.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double iconSize = 20;
    final double indicatorWidth = 48;
    final double indicatorHeight = 28;
    final double barHeight = 65;
    final List<IconData> icons = [
      CupertinoIcons.home,
      CupertinoIcons.book,
      CupertinoIcons.cart,
      CupertinoIcons.person,
    ];
    final List<Widget> screens = const [
      HomeScreen(),
      MyCoursesScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return Consumer<BottomNavProvider>(
      builder: (context, navProvider, _) {
        final _selectedIndex = navProvider.selectedIndex;
        return Scaffold(
          body: screens[_selectedIndex],
          bottomNavigationBar: LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              final slotWidth = barWidth / icons.length;
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: barHeight,
                    width: barWidth,
                    color: Colors.white,
                  ),
                  Positioned(
                    bottom: barHeight - 6,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 6,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0x10000000),
                            Color(0x00000000),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.elasticOut,
                    left: (_selectedIndex * slotWidth) + (slotWidth - indicatorWidth) / 2,
                    bottom: (barHeight - indicatorHeight) / 2,
                    child: Container(
                      width: indicatorWidth,
                      height: indicatorHeight,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: barHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(icons.length, (index) {
                        final isSelected = _selectedIndex == index;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              final overlay = Overlay.of(context);
                              final renderBox = context.findRenderObject() as RenderBox?;
                              final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
                              final tapPosition = offset + Offset(slotWidth * index + slotWidth / 2, barHeight / 2);
                              late OverlayEntry entry;
                              entry = OverlayEntry(
                                builder: (context) => Positioned(
                                  left: tapPosition.dx - 24,
                                  top: tapPosition.dy - 24,
                                  child: IgnorePointer(
                                    child: AnimatedOpacity(
                                      opacity: 0,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeOut,
                                      onEnd: () => entry.remove(),
                                      child: Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: theme.colorScheme.primary.withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              overlay?.insert(entry);
                              navProvider.setIndex(index);
                            },
                            behavior: HitTestBehavior.opaque,
                            child: AnimatedScale(
                              scale: isSelected ? 1.15 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              child: Container(
                                alignment: Alignment.center,
                                height: barHeight,
                                child: Icon(
                                  icons[index],
                                  size: iconSize,
                                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
} 