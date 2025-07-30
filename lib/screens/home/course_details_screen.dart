import 'package:flutter/material.dart';
import '../../models/course.dart';
import '../../theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../../models/cart_provider.dart';
import 'checkout_screen.dart';
import 'demo_class_screen.dart';
import 'features_screen.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Course course;
  const CourseDetailsScreen({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double oldPrice = course.price * 1.5;
    return Scaffold(
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
          'Course Detail',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.2,
            color: AppTheme.textColor,
            fontFamily: 'Poppins',
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFE0E0E0)),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppTheme.textColor, size: 18),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.tightFor(width: 32, height: 32),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Course Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFF8F9FA),
                            Color(0xFFE8EAF6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    color: AppTheme.textColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  course.batch,
                                  style: TextStyle(
                                    color: AppTheme.textColor.withOpacity(0.7),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'बैच आरंभ : 11 अगस्त',
                                          style: TextStyle(
                                            color: AppTheme.textColor.withOpacity(0.8),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: AppTheme.accentColor,
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: const Text(
                                                '• Live', 
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 11, 
                                                  fontWeight: FontWeight.w600, 
                                                  fontFamily: 'Poppins'
                                                )
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: AppTheme.primaryColor,
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                course.medium, 
                                                style: const TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 11, 
                                                  fontWeight: FontWeight.w600, 
                                                  fontFamily: 'Poppins'
                                                )
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.live_tv, color: AppTheme.accentColor, size: 28),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Live', 
                                            style: TextStyle(
                                              fontSize: 10, 
                                              color: AppTheme.accentColor, 
                                              fontWeight: FontWeight.bold, 
                                              fontFamily: 'Poppins'
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Info Table
                    Column(
                      children: [
                        _infoRow('Validity', '${course.validityMonths} Months'),
                        const SizedBox(height: 4),
                        _infoRow('Category', course.category),
                        const SizedBox(height: 4),
                        _infoRow('Medium', course.medium),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price', 
                                style: TextStyle(
                                  fontFamily: 'Poppins', 
                                  fontSize: 15, 
                                  color: Colors.black54
                                )
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\u20B9${oldPrice.toStringAsFixed(0)}/-',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '\u20B9${course.price.toStringAsFixed(0)}/-',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 17,
                                      color: AppTheme.accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Action Tiles
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const DemoClassScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.ondemand_video, color: AppTheme.primaryColor, size: 28),
                            const SizedBox(height: 8),
                            Text(
                              'Demo Class', 
                              style: TextStyle(
                                fontFamily: 'Poppins', 
                                fontWeight: FontWeight.w500, 
                                color: AppTheme.textColor
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const FeaturesScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.featured_play_list, color: AppTheme.primaryColor, size: 28),
                            const SizedBox(height: 8),
                            Text(
                              'Features', 
                              style: TextStyle(
                                fontFamily: 'Poppins', 
                                fontWeight: FontWeight.w500, 
                                color: AppTheme.textColor
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80), // For bottom buttons
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, _) {
                  final inCart = cartProvider.isInCart(course);
                  return ElevatedButton.icon(
                    onPressed: inCart
                        ? null
                        : () {
                            cartProvider.addToCart(course);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Added to cart!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: Text(inCart ? 'Added' : 'Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryColor,
                      side: BorderSide(color: AppTheme.primaryColor),
                      elevation: 0,
                      textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(courses: [course]),
                    ),
                  );
                },
                child: const Text('Buy Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label, 
          style: const TextStyle(
            fontFamily: 'Poppins', 
            fontSize: 15, 
            color: Colors.black54
          )
        ),
        Text(
          value, 
          style: const TextStyle(
            fontFamily: 'Poppins', 
            fontSize: 15, 
            color: Colors.black87, 
            fontWeight: FontWeight.w500
          )
        ),
      ],
    ),
  );
} 