# MoexCalculator

## Purpose and goals of the application ##

The calculator application works with currencies (RUR, CNY, EUR, USD), exchange rates and amounts. Current currency quotes are received from the Moscow Exchange website, then displaysed as a list and converted.

Application goal:

Provide a simple user-friendly interface for currency conversion.

## Description of the application ##
The main screen of the application is the fields for entering and displaying currency amounts with the flags of the issuing countries and currency codes. Clicking on the flag or currency code opens the currency selector at the bottom of the screen. In it, the list of currencies on the left corresponds to the upper input field, and on the right corresponds to the lower one. If user changes the currency type in it, the flag and the currency code change automatically. When user enters a currency amount in the upper or lower field, the currency amount in the other field is recalculated automatically.

## Tasks of the application ## 
- Creating UI screens using SwiftUI, including elements implementing the View protocol, and modifying them with modifiers. Adding functionality, such as handling button clicks.
- Processing data with different loading states: "Data is being loaded", "Data is loaded", "Error loading data". This includes displaying the progressView indicator, error messages, and successful download.
- Using the MVVM pattern to create a calculator screen and link Model, View and ViewModel elements.
- The implementation of input fields on the calculator screen and their relationship to the ViewModel.
- Working with network requests to download data.
- Using identifiers for the elements required to implement the Identifiable protocol.
- Applying a declarative approach to development using SwiftUI.
- Using SwiftUI and Combine to bind ViewModel and View using the ObservableObject protocol, @Published attributes, and the @ObservedObject type.
- Working with application and screen states, changing the user interface when states change, and processing data received from network requests.

## Technology stack ##
- SwiftUI, Combine
- Architecture: MVVM
- Protocols View, Identifiable, ObservableObject
- URLSession
- ProgressView 

## Installation ##
Installation and launch via Xcode. By default, the XCode project supports network requests over the secure HTTPS protocol, but not over the unsecured HTTP protocol. To make the application work, you need to add the XCode project settings.
The application takes currency exchange rates from the Moscow Exchange website using a network request.

To allow access to the site http://iss.moex.com over the HTTP protocol, do everything as in the illustration:
![Image (2)](https://github.com/MiraiChan/MoexCalculator/assets/39549759/4e5067aa-baf6-40cb-9f7f-6cd96e41c347)

## Links ##
[Design Figma](https://www.figma.com/file/2CBt6djM0qB1GB3Js9HMUA/%D0%9A%D0%BE%D0%BD%D0%B2%D0%B5%D1%80%D1%82%D0%B5%D1%80-%D0%B2%D0%B0%D0%BB%D1%8E%D1%82-(vol.2)?type=design&node-id=0-1&mode=design&t=Tj6D0fPQtghJQKGO-0)



https://github.com/MiraiChan/MoexCalculator/assets/39549759/11bac3a1-4ec5-4b0d-865f-b3a1874969f1

