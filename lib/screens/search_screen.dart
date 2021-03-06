import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(InitialSearchState()),
      child: BlocConsumer<SearchBloc, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Search Screen',
                ),
              ),
              body:  SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        DefaultTextFieldWidget(
                          icon: const Icon(Icons.search),
                          isSuffixShow: false,
                          hintText: 'Write something',
                          onSubmit: (String text) =>
                              onSearch(context, text),
                          controller: searchController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'search must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        if (state is SearchLoadingState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        if (state is SearchSuccessState)
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                            const Divider(),
                            itemCount: SearchBloc.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length,
                            itemBuilder: (context, index) =>
                                buildListProducts(
                                    SearchBloc.get(context)
                                        .searchModel!
                                        .data!
                                        .data![index],
                                    context,
                                    isOldPrice: false,isOnTap: true),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onSearch(BuildContext context, String text) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    SearchBloc.get(context).add(
      SearchEvent(
        path: 'products/search',
        text: text,
      ),
    );
  }
}
