# Kino
Kino is movie catalogue iOS app.

### What is it?
This application is my playground for expiriences with different new API's. Right now it's in development, so all interesting staff comming after v1.0. In this project I use same style guides (except here I will use default property values, cauz they are rock, sorry Michal :D), architectural patterns, naming conventions and etc as in my daily work, in other words this is same code as I paid for.

### How to start
- install pods
- insert your api key in `Configuration.swift`

### Roadmap
#### Functionality
All aplication version should have this minimal functionality:
- Ability to search movies by query string  
##### ----> You are here!
- navigation to movie's details with aditional details downloading
- adding / removing to favorites on detail screen
- list of favorite movies stored localy
#### v0.5 - MVP
Represent minimal product, that able to perform all aplication functions
#### v1.0 - Basis
- Seach screen represented as grid (collection view) of movie posters. Favorite movies have special highlight
- Detail screen start with movie preview and transform to full detail as soon as full detail list loaded
- Flexible navigation architecture allow diferent ways to present detail screen aka basic push, modal fullscreen, interactive transitions
- Favorites screen still really close to search
#### v1.1 - Feature flags (Yay!)
- Introduce feature flags manager and UI as part of Debug screen. It will allow change behaviour / layout / navigation in app on fly just by taping on feature switch!
- Feature flags should allow selection one from group and dependent features
#### v1.2 - Detail transitions
- Feature flaged ways to navigate from search / favorites to detail screen
#### v1.3 - iPad getting some love <3
- Redesign application for iPads! Why would you push detail screen, when here enough place to show it just on half of screen. Basically change layouts / navigations to use iPad screen sizes on maximum.
#### v1.4+ stay tuned.
