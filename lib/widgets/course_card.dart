import 'package:flutter/material.dart';
import '../models/course.dart';
import '../theme/app_theme.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;
  final bool showRemoveButton;
  final VoidCallback? onRemove;
  const CourseCard({Key? key, required this.course, this.onTap, this.showRemoveButton = false, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        shadowColor: Colors.black12,
        clipBehavior: Clip.antiAlias,
        child: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                course.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16, 
                  fontFamily: 'Poppins', 
                  color: AppTheme.textColor
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                course.batch,
                style: TextStyle(
                  color: AppTheme.textColor.withOpacity(0.7),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
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
                            child: const Text('• Live', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(course.medium, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
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
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(Icons.live_tv, color: AppTheme.accentColor, size: 22),
                        const SizedBox(height: 3),
                        Text('Live', style: TextStyle(fontSize: 9, color: AppTheme.accentColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                      ],
                    ),
                  ),
                ],
              ),
             if (showRemoveButton) ...[
               const SizedBox(height: 12),
               SizedBox(
                 width: double.infinity,
                 child: OutlinedButton.icon(
                   onPressed: onRemove,
                   icon: const Icon(Icons.remove_shopping_cart, color: Colors.redAccent, size: 18),
                   label: const Text(
                     'Remove from Cart',
                     style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                   ),
                   style: OutlinedButton.styleFrom(
                     side: const BorderSide(color: Colors.redAccent),
                     foregroundColor: Colors.redAccent,
                     padding: const EdgeInsets.symmetric(vertical: 12),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                   ),
                 ),
               ),
             ],
            ],
          ),
        ),
      ),
    );
  }
} 