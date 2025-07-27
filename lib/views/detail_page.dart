import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants/themes.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';

class DetailsPage extends ConsumerWidget {
  final ProductModel product;

  const DetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 238, 216, 216)),
        title: Text(
          'Details Page',
          style: AppTheme.kBigTitle.copyWith(color: kWhiteColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.local_mall_outlined),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: kLightBackground,
              child: Image.asset(product.imgUrl),
            ),
            Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: AppTheme.kBigTitle.copyWith(color: kPrimaryColor),
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        RatingBar(
                          itemSize: 25,
                          initialRating: 1,
                          minRating: 1,
                          maxRating: 5,
                          allowHalfRating: true,
                          ratingWidget: RatingWidget(
                            empty: const Icon(Icons.star_border,
                                color: Colors.amber),
                            full: const Icon(Icons.star, color: Colors.amber),
                            half: const Icon(Icons.star_half_sharp,
                                color: Colors.amber),
                          ),
                          onRatingUpdate: (value) {},
                        ),
                        const Gap(12),
                        const Text('173 reviews'),
                      ],
                    ),
                    const Gap(8),
                    Text(
                      product.longDescription,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rs ${product.price * product.qty}',
                            style: AppTheme.kHeadingOne),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(productNotifierProvider.notifier)
                                      .decreaseQty(product.pid);
                                },
                                icon: const Icon(
                                    Icons.do_not_disturb_on_outlined,
                                    size: 30),
                              ),
                              Text(product.qty.toString(),
                                  style: AppTheme.kCardTitle
                                      .copyWith(fontSize: 24)),
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(productNotifierProvider.notifier)
                                      .incrementQty(product.pid);
                                },
                                icon: const Icon(Icons.add_circle_outline,
                                    size: 30),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: kWhiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: const Size(double.infinity, 50)),
                      onPressed: () {},
                      child: const Text('Add to cart'),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
