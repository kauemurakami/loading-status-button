[![Star on GitHub](https://img.shields.io/github/stars/kauemurakami/loading-status-button.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/kauemurakami/loading-status-button) 
## loading_status_button

É um pacote flutter que permite gerenciar o estado do botão, junto com uma animação, além de carregar com animação no botão, você pode fornecer feedback visual como `erro` ou `sucesso` também, além de habilitar e desativá-lo através de alguma lógica fornecida.

<img src="https://github.com/kauemurakami/loading-status-button/raw/main/example/assets/loadingstatusbutton.gif" width="240" height="350"/>

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

Exemplo curto, para um exemplo mais complexo acesse a pasta `/example`:  
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
Caso queira remover esse controlador da memoria, podemos utilizar o método herdado de `ChangeNotifier`, `dispose` para isso:
```dart
controller.dispose();
```




