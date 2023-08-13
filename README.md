# WeatherIdeoDigital

Technical task, targeting the Senior iOS Engineer role.

## API

The application utilizes weather data from the [OpenWeatherMap Current Weather API](https://openweathermap.org/current).

## Architecture

Built with a modularized architecture and reactive ViewModels, the application consists of several key components:

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

## Main Focus

The primary focus of this project was on architecture and minimalistic UI. While the app consists of only one screen, the underlying 
codebase is rich and complex. Aimed at achieving production-level quality, the code was written with a broad perspective, considering future 
improvements and scalability. Though the app could be built with a single class, the intention was to create a production-level codebase, 
reflecting thoughtful design and execution.
