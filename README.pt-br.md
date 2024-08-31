## Loading Status Button

É um pacote flutter que permite gerenciar o estado do botão, junto com uma animação, além de carregar com animação no botão, você pode fornecer feedback visual como `erro` ou `sucesso` também, além de habilitar e desativá-lo através de alguma lógica fornecida.

## Funcionalidades

`LoadingStatusButton` é um pacote Flutter que fornece um botão animado com suporte para vários estados. Ele permite controlar visualmente o `status` do botão, incluindo estados de `loading`, `success` e `error`, além de poder deixar o botão habilitado ou não com `status` `enable` e `disable`.  
Com animações suaves e personalizáveis é ideal para interfaces que exigem feedback visual dinâmico durante operações assíncronas.

## Instalação

```
$ flutter pub add loading_status_button
```
ou adicione em suas `dependencies` em `pubspec.yaml`  
```yaml
dependencies:
  loading_status_button:
```

## Usage

exemplo curto, para um exemplo mais complexo acesse a pasta `/example`:  
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
    await controller.setStatus(StatusButton.enable); // ou outra ação, exemplo, navegar para outra página após o success
  }
}
```

## Informações adicionais



