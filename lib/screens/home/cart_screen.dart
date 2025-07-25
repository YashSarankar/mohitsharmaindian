import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/course_card.dart';
import '../../models/course.dart';
import '../../models/cart_provider.dart';
import '../../models/bottom_nav_provider.dart';
import '../../theme/app_theme.dart';
import 'course_details_screen.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
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
          'Cart',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.2,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        leading: null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.sort_rounded, color: Colors.black, size: 18),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                        ),
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16),
                            const Text('Sort by', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Poppins')),
                            ListTile(
                              leading: const Icon(Icons.arrow_upward),
                              title: const Text('Price: Low to High', style: TextStyle(fontFamily: 'Poppins')),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            ListTile(
                              leading: const Icon(Icons.arrow_downward),
                              title: const Text('Price: High to Low', style: TextStyle(fontFamily: 'Poppins')),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            ListTile(
                              leading: const Icon(Icons.sort_by_alpha),
                              title: const Text('Title: A-Z', style: TextStyle(fontFamily: 'Poppins')),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            ListTile(
                              leading: const Icon(Icons.sort_by_alpha),
                              title: const Text('Title: Z-A', style: TextStyle(fontFamily: 'Poppins')),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      );
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
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: AppTheme.primaryColor.withOpacity(0.5)),
                  const SizedBox(height: 24),
                  const Text(
                    'Your cart is empty!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Browse courses and add them to your cart.',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.textColor.withOpacity(0.6),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final navProvider = Provider.of<BottomNavProvider>(context, listen: false);
                      navProvider.setIndex(0);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Explore Courses'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final course = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CourseCard(
                      course: course,
                      showRemoveButton: true,
                      onRemove: () {
                        cartProvider.removeFromCart(course);
                      },
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final cartProvider = Provider.of<CartProvider>(context, listen: false);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(courses: cartProvider.cartItems),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Checkout'),
                ),
              ),
            )
          : null,
    );
  }
}

class CourseSearchDelegate extends SearchDelegate {
  final List<Course> courses;
  CourseSearchDelegate(this.courses);

  @override
  String get searchFieldLabel => 'Search courses';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = courses.where((course) =>
      course.title.toLowerCase().contains(query.toLowerCase()) ||
      course.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'No courses found.',
              style: TextStyle(fontSize: 18, color: Colors.black54, fontFamily: 'Poppins'),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final course = results[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(14),
            child: CourseCard(
              course: course,
              onTap: () {
                close(context, course);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CourseDetailsScreen(course: course),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = courses.where((course) =>
      course.title.toLowerCase().contains(query.toLowerCase())
    ).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final course = suggestions[index];
        return ListTile(
          title: Text(course.title),
          subtitle: Text(course.description, maxLines: 1, overflow: TextOverflow.ellipsis),
          onTap: () {
            query = course.title;
            showResults(context);
          },
        );
      },
    );
  }
} 