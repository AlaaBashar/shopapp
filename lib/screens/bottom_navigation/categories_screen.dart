import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_feature.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, index) {},


      builder: (context, index) =>ConditionalBuilder(
        condition: HomeBloc.get(context).categoriesModel != null,
        builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: HomeBloc.get(context).categoriesModel!.data!.data!.length,
          itemBuilder: (context, index) => buildCatItem(
              HomeBloc.get(context).categoriesModel!.data!.data![index]),
        ),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),



    );
  }

  Widget buildCatItem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: model!.image!,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),

            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      );
}
