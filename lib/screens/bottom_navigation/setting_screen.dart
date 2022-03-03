import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = HomeBloc.get(context);
          nameController.text = model.userModel!.data!.name!;
          emailController.text = model.userModel!.data!.email!;
          phoneController.text = model.userModel!.data!.phone!;
        return ConditionalBuilder(
            condition:state is! HomeLoadingGetProfileState,
            builder: (context) {
              return  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(constraints:BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight
              ),
                child: IntrinsicHeight(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          if(state is HomeLoadingUpdateProfileDataState)
                            const LinearProgressIndicator(),
                          DefaultTextFieldWidget(
                            icon: const Icon(Icons.text_fields),
                            isSuffixShow: false,
                            controller: nameController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'name must not be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0,),
                          DefaultTextFieldWidget(
                            icon: const Icon(Icons.account_box),
                            isSuffixShow: false,
                            controller: emailController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'email must not be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0,),
                          DefaultTextFieldWidget(
                            icon: const Icon(Icons.phone),
                            isSuffixShow: false,
                            controller: phoneController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'phone must not be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0,),
                          const Spacer(flex: 1,),
                          DefaultButtonWidget(
                            onPressed: () => onUpdate(context),
                            text: 'Update',
                            color: Colors.blue,
                            fontSize: 16.0,
                          ),
                          const SizedBox(height: 20.0,),
                          DefaultButtonWidget(
                            onPressed: () => onLogOut(context),
                            text: 'Sign Out',
                            fontSize: 16.0,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),),
              ),
            );
          },);
        }, fallback: (context){
          return const Center(child: CircularProgressIndicator(),);
        });
      },
    );
  }

  void onLogOut(BuildContext context){
    FocusManager.instance.primaryFocus?.unfocus();
    CacheHelper.removeData(key: 'token').then((value) {
      if(value){
        openNewPage(context, const LoginScreen(),popPreviousPages: true);
      }
    });

  }

  void onUpdate(BuildContext context){
    if(!formKey.currentState!.validate()){
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    HomeBloc.get(context).add(
      HomeUpdateProfileDataEvent(
        phone: phoneController.text,
        name: nameController.text,
        email: emailController.text,
      ),
    );
  }
}
