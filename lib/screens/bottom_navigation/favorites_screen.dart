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
        condition: HomeBloc.get(context).favoritesModel != null,
        builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: HomeBloc.get(context).favoritesModel!.data!.data!.length,
          itemBuilder: (context, index) => buildListProducts(
              HomeBloc.get(context).favoritesModel!.data!.data![index].product,
              context),
        ),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

}
