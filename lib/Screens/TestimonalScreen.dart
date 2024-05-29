import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';

class Testimonial {
  final String name;
  final String image;
  final int rating;
  final String review;

  Testimonial({
    required this.name,
    required this.image,
    required this.rating,
    required this.review,
  });
}

class TestimonialScreen extends StatelessWidget {
  final List<Testimonial> testimonials = [
    Testimonial(
      name: 'John Doe',
      image: 'asset/images/pp1.jpg',
      rating: 5,
      review:
          'I recently renovated my home using the app, and I must say, it exceeded my expectations! The AR feature allowed me to visualize how different tiles, marble, furniture, doors, and electronics would look in my space before making any decisions.',
    ),
    Testimonial(
      name: 'Jane Smith',
      image: 'asset/images/pp2.jpg',
      rating: 4,
      review:
          'Amazing AR for design projects. Wide range of products and excellent support.',
    ),
    Testimonial(
      name: 'Michael Smith',
      image: 'asset/images/pp4.jpg',
      rating: 4,
      review:
          'I found Home Provision to offer a great selection of products, and the AR feature was particularly impressive. It helped me visualize how different items would look in my space before making a decision. While the overall experience was positive, I felt that the app navigation could be more intuitive. Nevertheless, I\'m satisfied with my purchase and would recommend it to others.',
    ),
    Testimonial(
      name: 'Sarah Thompson',
      image: 'asset/images/pp3.jpg',
      rating: 5,
      review:
          'Using Home Provision for my design projects has been a delight. The AR functionality is incredibly useful, allowing me to present concepts to clients with ease. I appreciate the wide range of products available, catering to various design styles. Additionally, the customer support team has been exceptional, providing prompt assistance whenever needed. I highly recommend [App Name] to fellow designers and homeowners alike!',
    ),
  ];

  TestimonialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          centerTitle: true,
          backgroundColor: kColorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15.r),
            ),
          ),
          iconTheme: IconThemeData(color: kColorWhite),
          title: Text('Testimonials',
              style: kStyleBlack22600.copyWith(color: kColorWhite)),
        ),
      ),
      body: Column(
        children: [
          20.verticalSpace,
          Expanded(
            child: ListView.builder(
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                return TestimonialCard(testimonial: testimonials[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;

  const TestimonialCard({Key? key, required this.testimonial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: kColorWhite248,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: kColorPrimary.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.0,
                backgroundImage: AssetImage(testimonial.image),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      for (int i = 0; i < testimonial.rating; i++)
                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            testimonial.review,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
