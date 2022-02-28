import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_feature.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: state is! HomeChangeFavoritesState,
        builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: HomeBloc.get(context).favoritesModel!.data!.data!.length,
          itemBuilder: (context, index) => buildFavItem(
              HomeBloc.get(context).favoritesModel!.data!.data![index],
              context),
        ),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildFavItem(FavoritesData model, BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.product!.image!,
                    width: 120,
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                  if (model.product!.discount != 0)
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
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        Text(
                          model.product!.price.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            model.product!.oldPrice.toString(),
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
                            HomeBloc.get(context).add(HomeChangeFavoritesDataEvent(id: model.product!.id));
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: HomeBloc.get(context).favorites![model.product!.id] !=false ? Colors.red : Colors.grey,
                            child: const Icon(
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
        ),
      );
}
