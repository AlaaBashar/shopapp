import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../export_feature.dart';

class DefaultButtonWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? height;
  final double? fontSize;
  final double? horizontalPadding;
  final Color? color;
  final Function()? onPressed;

  const DefaultButtonWidget({
    Key? key,
    required this.text,
    this.height,
    this.color,
    required this.onPressed,
    this.textColor,
    this.horizontalPadding,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding!)
          : const EdgeInsets.symmetric(horizontal: 0.0),
      child: MaterialButton(
        minWidth: double.infinity,
        color: color ?? Colors.grey,
        height: height ?? 50.0,
        textColor: textColor ?? Colors.white,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: fontSize ?? 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class DefaultTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final Color? hintTextColor;
  final double? height;
  final double? horizontalPadding;
  final bool? isObscure;
  final Icon? icon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? isSuffixShow;
  final VoidCallback? suffixOnPressed;
  final ValueChanged<String>? onSubmit;
  final IconData? suffixIcon;

  const DefaultTextFieldWidget({
    Key? key,
    this.hintText,
    required this.controller,
    this.isObscure,
    required this.validator,
    this.icon,
    this.height,
    this.horizontalPadding,
    this.isSuffixShow,
    this.suffixOnPressed,
    this.suffixIcon,
    this.onSubmit, this.hintTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding!)
          : const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: height ?? 50.0,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 10),
            )
          ],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextFormField(
            controller: controller,
            obscureText: isObscure ?? false,
            onChanged: onSubmit,
            decoration: InputDecoration(
              icon: icon,
              hintText: hintText,
              hintStyle:TextStyle(color: hintTextColor ?? Colors.grey),
              border: InputBorder.none,
              enabled: true,
              suffixIcon: isSuffixShow != false
                  ? IconButton(
                      icon: Icon(suffixIcon!),
                      splashColor: Colors.transparent,
                      onPressed: suffixOnPressed,
                    )
                  : null,
            ),
            validator: validator),
      ),
    );
  }
}

Widget buildListProducts(model, BuildContext context, {bool isOldPrice = true ,isOnTap = false}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: isOnTap ? SizedBox(
        height: 120.0,
        child: InkWell(
          onTap: (){
            openNewPage(context, ProductsDetailsScreen(
              id: model.id,
              description: model.description,
              discount: model.discount,
              image: model.image,
              name: model.name,
              oldPrice: '',
              price: model.price,
              images: model.images,
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.image!,
                    width: 120,
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                  if (model.discount != 0 && isOldPrice)
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
                      model.name!,
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
                          model.price.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            model.oldPrice.toString(),
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
                            HomeBloc.get(context).add(
                                HomeChangeFavoritesDataEvent(id: model.id));
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                            HomeBloc.get(context).favorites![model.id] !=
                                false
                                ? Colors.red
                                : Colors.grey,
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
      ):SizedBox(
        height: 120.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CachedNetworkImage(
                  imageUrl: model.image!,
                  width: 120,
                  height: 120.0,
                  fit: BoxFit.fill,
                ),
                if (model.discount != 0 && isOldPrice)
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
                    model.name!,
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
                        model.price.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
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
                          HomeBloc.get(context).add(
                              HomeChangeFavoritesDataEvent(id: model.id));
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          HomeBloc.get(context).favorites![model.id] !=
                              false
                              ? Colors.red
                              : Colors.grey,
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

Future showMyDialog(context) async => showDialog(
  context: context,
  //barrierDismissible: false, // user must tap button!
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      titlePadding:EdgeInsets.zero ,
      title: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius:BorderRadius.only(topLeft:Radius.circular(15.0),topRight:Radius.circular(15.0 )),
            ),
            height: 70.0,
            width: double.infinity,
            child: const Icon(Icons.warning_amber_rounded,size: 55.0,color: Colors.white,),
          ),
          const SizedBox(height: 10.0,),
            Text('Warning!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24.0,color:Theme.of(context).appBarTheme.titleTextStyle!.color),),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children:  [
            Text('Do you want to exit an App?',style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color),),
          ],
        ),
      ),
      actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Colors.white,
              child: const Text('No'),
              splashColor: Colors.redAccent,
              elevation: 8.0,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Colors.white,
              child: const Text('Yes'),
              splashColor: Colors.greenAccent,
              elevation: 8.0,

            ),
          ],
        );
  },
);