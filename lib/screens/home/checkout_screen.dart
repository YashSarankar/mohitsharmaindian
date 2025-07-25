import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/course.dart';
import '../../widgets/course_card.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Course> courses;
  const CheckoutScreen({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = courses.fold<double>(0, (sum, course) => sum + course.price);

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
          'Checkout',
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
                border: Border.all(color: const Color(0xFFE0E0E0)),
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeading('Items Added', fontSize: 17),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final course = courses[index];
                return CourseCard(
                  course: course,
                  showRemoveButton: false,
                );
              },
            ),
            const SizedBox(height: 16),
            _sectionHeading('Address', fontSize: 17),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        '123 Main Street, New Delhi, Delhi, 110001',
                        style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: 'Poppins'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: AppTheme.primaryColor, size: 18),
                        onPressed: () {
                          _showEditAddressSheet(context);
                        },
                        splashRadius: 18,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _sectionHeading('Bill Summary', fontSize: 17),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Course Amount', style: TextStyle(fontSize: 15, fontFamily: 'Poppins', color: Colors.black)),
                        Text(
                          '\u20B9${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.textColor, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Payable Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins', color: Colors.black)),
                        Text(
                          '\u20B9${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primaryColor, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Place order logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Place Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showEditAddressSheet(BuildContext context) {
  final addressController = TextEditingController(text: '123 Main Street');
  final cityController = TextEditingController(text: 'New Delhi');
  final stateController = TextEditingController(text: 'Delhi');
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Edit Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Poppins', color: Colors.black)),
          const SizedBox(height: 18),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: 'Address',
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: cityController,
            decoration: const InputDecoration(
              labelText: 'City',
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: stateController,
            decoration: const InputDecoration(
              labelText: 'State',
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Save address logic
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _sectionHeading(String text, {double fontSize = 20}) {
  return Row(
    children: [
      Container(
        width: 5,
        height: 20,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      const SizedBox(width: 10),
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: fontSize,
          color: AppTheme.textColor,
          fontFamily: 'Poppins',
          letterSpacing: 0.2,
        ),
      ),
    ],
  );
} 