# LaunchApplication

LaunchApplication é uma biblioteca para você criar um sequencia de inicailização de forma simples e rápida.

[![CI Status](http://img.shields.io/travis/jjfernandes87/LaunchApplication.svg?style=flat)](https://travis-ci.org/jjfernandes87/LaunchApplication)
[![Version](https://img.shields.io/cocoapods/v/LaunchApplication.svg?style=flat)](http://cocoapods.org/pods/LaunchApplication)
[![License](https://img.shields.io/cocoapods/l/LaunchApplication.svg?style=flat)](http://cocoapods.org/pods/LaunchApplication)
[![Platform](https://img.shields.io/cocoapods/p/LaunchApplication.svg?style=flat)](http://cocoapods.org/pods/LaunchApplication)

## Features

- [x] Cria uma lista de etapas para serem executas de forma sincrona
- [x] Cria uma lista "LaunchSequence"
- [x] Cria uma lista "RelaunchSequence"
- [x] Tenha o controle sobre os erros

## Requirements

- iOS 9.3+
- Xcode 9.0+
- Swift 4.0+

## Communication

- Se você **encontrou um bug**, abra uma issue.
- Se você **tem uma nova feature**, abra uma issue.
- Se você **quer contribuir**, envie uma pull request.

## Example

Para rodar o projeto de exemplo, clone o repositório, e rode o comando `pod install` no diretório Example primeiro.

## Installation

LaunchApplication esta disponível através [CocoaPods](http://cocoapods.org). Para instalar, basta adicionar a linha abaixo no seu Podfile:

```ruby
pod 'LaunchApplication', :git => 'https://github.com/jjfernandes87/LaunchApplication.git'
```
Crie uma classe e extenda da LaunchApplication

```swift
class AppSequence: LaunchApplication {
    ...
}
```
Impemente o metodo launchAndRelaunchSequence, responsável por carregar a lista de launchSequence e relaunchSequence.
Obs: No swift 4 é necessário informar @objc na frente do método.

```swift
class AppSequence: LaunchApplication {
    /// Metodo responsável por carregar a lista de launch e relaunch
    @objc func launchAndRelaunchSequence() {
        launchSequence.append("LaunchStage_bootOne")
        launchSequence.append("LaunchStage_bootTwo")
        relaunchSequence.append("LaunchStage_bootOne")
        relaunchSequence.append("LaunchStage_bootTwo")
    }
}
```
Impemente os métodos que foram adicionar na lista de launchSequence e relaunchSequence.
Obs: No swift 4 é necessário informar @objc na frente do método.

```swift
class AppSequence: LaunchApplication {
    /// Metodo responsável por carregar a lista de launch e relaunch
    @objc func launchAndRelaunchSequence() {
        launchSequence.append("LaunchStage_bootOne")
        launchSequence.append("LaunchStage_bootTwo")
        relaunchSequence.append("LaunchStage_bootOne")
        relaunchSequence.append("LaunchStage_bootTwo")
    }

    /// Metodo 1 para ser executado
    @objc func bootOne() {
        print("bootOne")
        nextLaunchStage()
    }

    /// Metodo 2 para ser executado
    @objc func bootTwo() {
        print("bootTwo")
        nextLaunchStage()
    }
}
```

Agora que todos os métodos foram implementados, precisam chamar nossa classe no app delegate para que o processo de inicialização seja feito.
Obs: Ao chamar o método launchWithDelegate(delegate: LaunchApplicationProtocol), lembre-se de implementar seu delegate.

```swift
class AppDelegate: UIResponder, UIApplicationDelegate, LaunchApplicationProtocol {

    ...
    var launchSequence = AppSequence()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        launchSequence.launchWithDelegate(delegate: self)
        ...
    }

    func didFinishLaunchSequence(application: LaunchApplication) {
        print("Sucesso")
    }

}
```

## Author

jjfernandes87, julio.fernandes87@gmail.com

## License

LaunchApplication is available under the MIT license. See the LICENSE file for more info.
