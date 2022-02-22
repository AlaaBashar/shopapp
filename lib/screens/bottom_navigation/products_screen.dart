import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_feature.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeBloc = HomeBloc.get(context);
        return ConditionalBuilder(
          condition:
              homeBloc.homeModel != null && homeBloc.categoriesModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) =>
              productsBuilder(homeBloc.homeModel, homeBloc.categoriesModel,context),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel? homeModel, CategoriesModel? categoriesModel,BuildContext? context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel!.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image!),
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(
                          categoriesModel!.data!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel!.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'New Products ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                childAspectRatio: 1 / 1.6,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  homeModel.data!.products!.length,
                  (index) => buildGridProducts(homeModel.data!.products![index],context

                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(DataModel? model) => SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              image: NetworkImage(
                model!.image!,
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.7),
              child: Text(
                model.name!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProducts(ProductsModel? model,BuildContext? context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model!.image!),
                  width: double.infinity,
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10.0,
                            color: Colors.grey,
                          ),
                        ),
                      const Spacer(
                        flex: 1,
                      ),
                      IconButton(
                        onPressed: () {
                          HomeBloc.get(context).add(HomeChangeFavoritesDataEvent(id:model.id));
                        },
                        icon:CircleAvatar(
                          radius: 15.0,
                          backgroundColor: HomeBloc.get(context).favorites![model.id] == false ? Colors.grey: Colors.red,
                          child:const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
