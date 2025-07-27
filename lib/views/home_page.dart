import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../constants/themes.dart';
import '../controllers/itembag_controller.dart';
import '../controllers/product_controller.dart';
import '../core/common/widget/Bottom_navigation.dart';
import '../model/product_model.dart';
import '../widgets/ads_banner_widget.dart';
import '../widgets/card_widget.dart';
import '../widgets/chip_widget.dart';
import 'cart_page.dart';
import 'detail_page.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productNotifierProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    final itemBag = ref.watch(itemBagProvider);

    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: SvgPicture.asset(
          'assets/general/store_brand_white.svg',
          colorFilter: const ColorFilter.mode(kWhiteColor, BlendMode.srcIn),
          width: 180,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: Badge(
              label: Text(itemBag.length.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CardPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.local_mall,
                ),
              ),
            ),
          )
        ],
      ),
      // drawer: const Drawer(),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Ads banner section
              const AdsBannerWidget(),
              // Chip section
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: const [
                    ChipWidget(
                      chipLabel: 'All',
                    ),
                    ChipWidget(
                      chipLabel: 'Computers',
                    ),
                    ChipWidget(
                      chipLabel: 'Headsets',
                    ),
                    ChipWidget(
                      chipLabel: 'Accessories',
                    ),
                    ChipWidget(
                      chipLabel: 'Printing',
                    ),
                    ChipWidget(
                      chipLabel: 'Gamers',
                    )
                  ],
                ),
              ),
              // Hot Sales section
              const Gap(12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hot Sales', style: AppTheme.kHeadingOne),
                  Text('See all', style: AppTheme.kSeeAllText),
                ],
              ),

              const ProductCardWidget(),
              // Featured section
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured Products', style: AppTheme.kHeadingOne),
                  Text('See all', style: AppTheme.kSeeAllText),
                ],
              ),
              GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.65),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  product: products[index],
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2),
                      ],
                    ),
                    margin: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 305,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(12),
                            color: kLightBackground,
                            child: Image.asset(products[index].imgUrl),
                          ),
                        ),
                        const Gap(4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].title,
                                style: AppTheme.kCardTitle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(products[index].shortDescription,
                                  style: AppTheme.kBodyText),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Rs${products[index].price}',
                                      style: AppTheme.kCardTitle),
                                  IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              productNotifierProvider.notifier)
                                          .isSelectItem(
                                              products[index].pid, index);

                                      if (products[index].isSelected == false) {
                                        ref
                                            .read(itemBagProvider.notifier)
                                            .addNewItemBag(
                                              ProductModel(
                                                  pid: products[index].pid,
                                                  imgUrl:
                                                      products[index].imgUrl,
                                                  title: products[index].title,
                                                  price: products[index].price,
                                                  shortDescription:
                                                      products[index]
                                                          .shortDescription,
                                                  longDescription:
                                                      products[index]
                                                          .longDescription,
                                                  review:
                                                      products[index].review,
                                                  rating:
                                                      products[index].rating),
                                            );
                                      } else {
                                        ref
                                            .read(itemBagProvider.notifier)
                                            .removeItem(products[index].pid);
                                      }
                                    },
                                    icon: Icon(
                                      products[index].isSelected
                                          ? Icons.check_circle
                                          : Icons.add_circle,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )

              // MasonryGridView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: products.length,
              //   shrinkWrap: true,
              //   gridDelegate:
              //       const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2),
              //   itemBuilder: (context, index) => GestureDetector(
              //     onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => DetailsPage(
              //           getIndex: index,
              //         ),
              //       ),
              //     ),
              //     child: SizedBox(
              //       height: 250,
              //       child: ProductCardWidget(
              //         // productIndex: index,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // import 'custom_bottom_navigation_bar.dart';

// ...

      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
