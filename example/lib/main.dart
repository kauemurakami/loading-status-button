import 'package:flutter/material.dart';
import 'package:loading_status_button/loading_status_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Status Button',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoadingStatusButtonController controller0 =
      LoadingStatusButtonController(initialStatus: StatusButton.enable);
  final LoadingStatusButtonController controller1 =
      LoadingStatusButtonController(initialStatus: StatusButton.enable);
  final LoadingStatusButtonController controller3 =
      LoadingStatusButtonController(initialStatus: StatusButton.disable);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LoadingStatusButtonWidget(
                callback: () async => await fakeCallSuccess(),
                controller: controller0,
                buttonColor: Colors.black,
                loadingColor: Colors.white,
                succesIconColor: Colors.green,
                errorIconColor: Colors.red,
                widget: const Text(
                  'Button Success',
                  style: TextStyle(color: Colors.white, fontSize: 17.0),
                ),
              ),
              LoadingStatusButtonWidget(
                callback: () async => await fakeCallError(),
                controller: controller1,
                buttonColor: Colors.black,
                loadingColor: Colors.white,
                succesIconColor: Colors.green,
                errorIconColor: Colors.red,
                widget: const Text(
                  'Button Error',
                  style: TextStyle(color: Colors.white, fontSize: 17.0),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      width: 200,
                      height: 40.0,
                      child: TextFormField(
                        onChanged: (value) async {
                          if (value.length >= 4) {
                            await controller3.setStatus(StatusButton.enable);
                          } else {
                            await controller3.setStatus(StatusButton.disable);
                          }
                        },
                        validator: (value) => value!.length >= 4
                            ? null
                            : 'Insert a name with min 4 letters',
                        decoration: const InputDecoration(
                          hintText: 'Enter with text',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    LoadingStatusButtonWidget(
                      callback: () async {
                        if (_formKey.currentState!.validate()) {
                          await controller3.setStatus(StatusButton.loading);
                          //fakeCall
                          await Future.delayed(const Duration(seconds: 5));
                          await controller3.setStatus(StatusButton.success);
                          await controller3.setStatus(StatusButton.enable);
                        }
                      },
                      controller: controller3,
                      buttonColor: Colors.black,
                      loadingColor: Colors.white,
                      succesIconColor: Colors.green,
                      errorIconColor: Colors.red,
                      widget: const Text(
                        'Button disable validate',
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  fakeCallSuccess() async {
    await controller0.setStatus(StatusButton.loading);
    //simulando chamada com delay
    await Future.delayed(const Duration(seconds: 5));
    await controller0.setStatus(StatusButton.success);
    await controller0.setStatus(StatusButton.enable);
  }

  fakeCallError() async {
    await controller1.setStatus(StatusButton.loading);
    //simulando chamada com delay
    await Future.delayed(const Duration(seconds: 5));
    await controller1.setStatus(StatusButton.error);
    await controller1.setStatus(StatusButton.enable);
  }
}
