# Technical task, targeting the Senior iOS Engineer role.
## API

The application utilizes weather data from the [OpenWeatherMap Current Weather API](https://openweathermap.org/current).

## Main Focus

The primary focus of this project was on architecture and minimalistic UI. While the app consists of only one screen, the underlying 
codebase is rich and complex. Aimed at achieving production-level quality, the code was written with a broad perspective, considering future 
improvements and scalability. Though the app could be built with a single class, the intention was to create a production-level codebase, 
reflecting thoughtful design and execution.

<p align="left">
  <img src="https://github.com/tornikegomareli/WeatherIdeoDigital/blob/main/Images/gif1.gif" alt="Gif1" width="25%" />
  <img src="https://github.com/tornikegomareli/WeatherIdeoDigital/blob/main/Images/gif2.gif" alt="Gif2" width="25%" />
</p>

## Tools and Libraries Used

This project relies on the following tools and libraries:

- [Alamofire](https://github.com/Alamofire/Alamofire) - Elegant HTTP Networking in Swift
- [Better SegmentedControl](https://github.com/gmarm/BetterSegmentedControl) - An improved replacement for UISegmentedControl
- [combine-schedulers](https://github.com/pointfreeco/combine-schedulers) - Time traveling schedulers for Combine
- [Gifu](https://github.com/kaishin/Gifu) - GIF support using Swift
- [Kingfisher](https://github.com/onevcat/Kingfisher) - A lightweight and pure Swift implemented library for downloading and caching image
- [Lottie](https://github.com/airbnb/lottie-ios) - An iOS library for a real time animation rendering by Airbnb
- [MarqueeLabel](https://github.com/cbpowell/MarqueeLabel) - A drop-in replacement for UILabel, which automatically adds a scrolling marquee effect
- [Moya](https://github.com/Moya/Moya) - Network abstraction layer written in Swift
- [NotificationBannerSwift](https://github.com/Daltron/NotificationBanner) - The easiest way to display highly customizable in app notification banners in iOS
- [PermissionKit](https://github.com/kishikawakatsumi/PermissionKit) - A toolkit for handling permissions in iOS
- [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift) - Streams of values over time
- [RxSwift](https://github.com/ReactiveX/RxSwift) - Reactive Programming in Swift
- [Snapkit](https://github.com/SnapKit/SnapKit) - A Swift Autolayout DSL for iOS & OS X
- [Swift-Dependencies](https://github.com/pointfreeco/swift-dependencies) - A dependency management library inspired by SwiftUI's "environment."
- [XCCoordinator](https://github.com/quickthyme/XCoordinator) - Navigation framework for a Model-View-ViewModel-Coordinator architecture

# Architecture

- Built with a modularized architecture and reactive ViewModels + Coordinators. UI is built with code, using SnapKit. 
- Network layer is built with Moya + Alamofire
- Using structured concurrency with async/await and Tasks.
- AppCoordinator is main coordinator which starts the app
- MainTabBarCoordinator is coordinator which is responsible to handle tab bar logics.
- For Dependency Management & Dependency injection using Swift-Dependencies (Tool with Protocol-witness ideas behind it) 
  
Currently we don't have tab-bar, but as already said focus it to make app ready for scalability options.

The application consists of several key components:

### Core

The core layer provides fundamental tools utilized across the entire application.

### BusinessDomain

This module houses the business repositories and models, defining the core business logic of the application.

### Networking Layer

Responsible for managing all networking calls and creating custom providers and services, this module ensures seamless communication with external data sources.

### WeatherUI

Serving as the foundational UI layer, WeatherUI contains the Design System's knowledge. Future redesigns can be easily implemented by updating this module.

### ApplicationLayer

This presentation layer coordinates all modules, orchestrating the overall flow and user experience.

## Scalability

The architecture's design allows for efficient scaling, with each module serving as a separate target. Integration with [Bazel](https://github.com/bazelbuild/bazel) is possible to further enhance build performance and dependency management.

## Installation

To get started, clone or download the project and open it with Xcode. The minimum iOS version required is iOS 15.0. If running on a device, remember to trust the developer account from Settings. For convenience, testing on a simulator is recommended, although the shaking feature will not be available.

## Features

- Animated background layer, providing an engaging visual experience.
- If you shake your device, the background animation will automatically change and re-render the layer
- Seamless updates without loading or progress bars, thanks to a looped background animation.
- Current location updates with the ability to switch between Celsius and Fahrenheit.
- Updates for three hardcoded locations.
- No unit tests are included due to the two-day deadline.

Most important feature of this codebase is pre-scalability opportunities. 
We already have customized TabBarCoordinator, MainCoordinator, AppCoordinator, custom navigation controller and navigation bar.
We have very general Network Layer and app is ready to integrate and add tons of amount services + repositories. 

App needs some tinkering to integrate Quick + Nimble for unit testing, but yea I just had 2 days to finish it.
