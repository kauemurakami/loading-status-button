## Loading Status Button

It's a flutter package that allows you to manage the state of the button, along with an animation, in addition to loading with animation on the button, you can provide visual feedback like `error` or `success` too, in addition to enabling and disabling it through some logic provided.

## Features

`LoadingStatusButton` is a Flutter package that provides an animated button with support for multiple states. It allows you to visually control the `status` of the button, including `loading`, `success` and `error` states, in addition to being able to leave the button enabled or not with `status` `enable` and `disable`.  
With smooth and customizable animations, it is ideal for interfaces that require dynamic visual feedback during asynchronous operations.

## Getting started

```
$ flutter pub add loading_status_button
```
or add in your dependencies in `pubspec.yaml`  
```yaml
dependencies:
  loading_status_button:
```

## Usage

Short example, for a more complex example go to the `/example` folder:  
```dart
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
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final LoadingStatusButtonController controller =
      LoadingStatusButtonController(initialStatus: StatusButton.enable);

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
                controller: controller,
                buttonColor: Colors.black,
                loadingColor: Colors.white,
                succesIconColor: Colors.green,
                errorIconColor: Colors.red,
                widget: const Text(
                  'Button Success',
                  style: TextStyle(color: Colors.white, fontSize: 17.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fakeCallSuccess() async {
    await controller.setStatus(StatusButton.loading);
    //fake fetchData
    await Future.delayed(const Duration(seconds: 5));
    await controller.setStatus(StatusButton.success);
    await controller.setStatus(StatusButton.enable); // or another action, example navigate to another page after success
  }
}
```


