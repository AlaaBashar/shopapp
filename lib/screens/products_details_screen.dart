import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../export_feature.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final int? id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String? image;
  final String? name;
  final String? description;
  final bool? inFavorite;
  final bool? inCart;
  final List<String>? images;

  ProductsDetailsScreen({
    Key? key,
    List<String>? images,
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.inFavorite,
    this.inCart,
  })  : images = images ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products Details',
        ),
      ),
      body: BlocConsumer<HomeBloc,HomeStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 300,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: images!.length,
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemBuilder: (context, index) {
                              return InteractiveViewer(
                                child: CachedNetworkImage(
                                  imageUrl: images![index],
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 25.0,),
                        Text('$name',style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 26.0),),
                        const SizedBox(height: 16.0,),
                        Row(
                          children: [
                            const Text('USD.',style:  TextStyle(fontWeight: FontWeight.w700,fontSize: 16.0,),),
                            Text('$price\$',style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 16.0,color: Colors.blue),),
                            const SizedBox(width: 8.0,),
                            if(discount != 0 )
                              Text('$oldPrice',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.0,
                                ),
                              ),
                            const Spacer(flex: 1,),
                            IconButton(
                              onPressed: () {
                                HomeBloc.get(context).add(HomeChangeFavoritesDataEvent(id:id));
                              },
                              icon:CircleAvatar(
                                radius: 15.0,
                                backgroundColor: HomeBloc.get(context).favorites![id] == false ? Colors.grey: Colors.red,
                                child:const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0,),
                        Text('$description',style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 14.0),),



                      ],
                    ),
                  ),
                ),),
            );
          },);
    },

      ),
    );
  }
}
