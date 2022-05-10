# Cash flow iOS

## Description
With this project you will be able to control your expenses and incomes where you also can see a balance.
Here we'll show you a list of registers and a screen where you can add it with some details.

## Topics
* [Architecture](#architecture)
* [Concepts covered](#concepts_covered)
* [In this version](#in_this_version)
* [Future items](#future_items)
* [Dependencies](#dependencies)
* [Requirements](#requirements)
* [Installation](#installation)

## Architecture
For this application was used **MVVM-C** where C stands for Coordinator to manage all the presentations for each flow.
Using this pattern also allow us to manage all the business logic inside the ViewModels, given a good point when we're looking at an application with Scalability, Readability and Maintainability.
Following the same concept we created a components that could be used everywhere inside.

## Concepts covered
* SOLID.
* Inheritance.
* Encapsulation.
* Maintainability.
* Scalability.
* Readability.
* Testability.
* Components.

### In this version

#### Screens
* List of registers(Expenses and Incomes).
* Screen to add a new register.
* Spalsh screen.

#### Components
* List register - it's possible to enable/disable edit mode setting `canDelete` as true.
* Register section.
* Register cell.
* Error.
* Empty.
* Loader.
* Totals card.
* Label title.
* Label detail.
* List type register.
* Currency text.
* Currency stepper with currency text together.

#### Other things
* App icon.
* Unit tests.
* Internationalization(English only).
* TODO search: *every build the project will show a warnning on each TODO tag we keeped.*
* Database using Realm.

## Future items
* Add .frameworks: *Create custom frameworks  to allow to grow scalable in a different teams*
* UI tests, tesing screens and the elements in itself.
* Handle erros with a custom alert component.
* Support both Dark and Light mode.
* Add Crashlytics framework to traking all issues.
* Create helper functions to work around constraint avoiding boilerplates.
* Create topic to show how to use each component.

## Dependencies
* [Cocoapods](https://guides.cocoapods.org/using/getting-started.html) 1.10.2.
* [RealmSwift](https://www.mongodb.com/docs/realm/sdk/swift/) 10.25.2.

## Requirements
* iOS 15.0+.
* Xcode 13.1.
* Swift 5.0.

## Installation
* Make sure we've been installed [Cocoapods](https://guides.cocoapods.org/using/getting-started.html) 1.10.2.
* Open the *Terminal*.
* Go to the project's root folder where should've the **Podfile**.
* Run this command: ```pod install```.

## Screenshots
------------

| App icon | Splashscreen | Empty state |
| ------------- | ------------- | ------------- |
| ![iPhone1](/screenshots/img1.png?raw=true) | ![iPhone2](/screenshots/img2.png?raw=true) | ![iPhone3](/screenshots/img3.png?raw=true) |

| Add register | Select type | List register |
| ------------- | ------------- | ------------- | 
| ![iPhone4](/screenshots/img4.png?raw=true) | ![iPhone5](/screenshots/img5.png?raw=true) | ![iPhone6](/screenshots/img6.png?raw=true) |

| Edit button pressed | Red(delete) option selected | Swipe left on item |
| ------------- | ------------- | ------------- |
| ![iPhone7](/screenshots/img7.png?raw=true) | ![iPhone8](/screenshots/img8.png?raw=true) | ![iPhone9](/screenshots/img9.png?raw=true) |
