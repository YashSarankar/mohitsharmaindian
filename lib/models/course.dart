class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final List<String> syllabus;
  final double price;
  final double rating;
  final String category;
  final String thumbnailUrl;
  final String batch;
  final int validityMonths;
  final String medium;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.syllabus,
    required this.price,
    required this.rating,
    required this.category,
    required this.thumbnailUrl,
    required this.batch,
    required this.validityMonths,
    required this.medium,
  });
}

final List<Course> dummyCourses = [
  Course(
    id: '1',
    title: 'Basic Flutter',
    description: 'Learn the basics of Flutter and build your first app.',
    instructor: 'Jane Doe',
    syllabus: ['Introduction', 'Widgets', 'Layouts', 'State Management'],
    price: 4999.99,
    rating: 4.5,
    category: 'Development',
    thumbnailUrl: 'https://picsum.photos/200/300?1',
    batch: 'Batch-6B',
    validityMonths: 72,
    medium: 'English',
  ),
  Course(
    id: '2',
    title: 'Advanced Dart',
    description: 'Deep dive into Dart programming language.',
    instructor: 'John Smith',
    syllabus: ['Dart Basics', 'Async Programming', 'Streams', 'Best Practices'],
    price: 5999.99,
    rating: 4.7,
    category: 'Programming',
    thumbnailUrl: 'https://picsum.photos/200/300?2',
    batch: 'Batch-7A',
    validityMonths: 48,
    medium: 'English',
  ),
  // Add more courses as needed
]; 