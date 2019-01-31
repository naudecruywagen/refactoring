# Refactoring

## The Starting Point
The first example from the [Refactoring](https://martinfowler.com/books/refactoring.html) book by Martin Fowler.

This serves as the introduction on how to do refactoring and is the platform for introducing some commons refactorings e.g. Extract Function, Replace Temp with Query, Inline Variable, Change Function Declaration and others.

### Swift Package
The starting point is a Swift package. You can create an Xcode project, if you prefer, by running `swift package generate-xcodeproj` from the terminal in the root directory of the project.

### Guard
[Guard](https://github.com/guard/guard) is set up to run `swift test` whenever changes are made within the `Sources` or `Tests` directories. 

To run, execute `bundle exec guard` from the root of the project.
