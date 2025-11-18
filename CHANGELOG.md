# CHANGELOG

## 7.0.1 - [18.11-2025]

- Fixes:

  - Fixed an error on initial [ViewRoot] dependencies loading about missing directionality widget for loading message.

- Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | get_it                                  | 8.0.3            | 9.0.5           |
    | go_router                               | 15.2.3           | 17.0.0          |
    | device_info_plus                        | 11.5.0           | 12.2.0          |

- Dev Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | lints                                   | 6.0.0            | 6.0.0           |

## 7.0.0 - [23.06-2025]

- Notes:

  - Changed the theming concept from a static ThemeManagerI dependency injected to an InheritedWidget implementation calling ThemeManager.of(context).
  
  - Refactorized PackageLanding concept to match this new Theming management.

- Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | get_it                                  | 8.0.3            | 8.0.3           |
    | go_router                               | 15.2.3           | 15.1.2          |
    | device_info_plus                        | 11.5.0           | 11.4.0          |

- Dev Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | lints                                   | 6.0.0            | 6.0.0           |

## 6.1.1 - [25.05-2025]

- Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | get_it                                  | 8.0.3            | 8.0.3           |
    | go_router                               | 15.1.2           | 15.1.2          |
    | device_info_plus                        | 11.4.0           | 11.4.0          |

- Dev Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | flutter_lints                           | 5.0.0            | X.X.X           |
    | flutter_lints                           | ---              | 6.0.0           |

## 6.1.0 - [21.05-2025]

- Notes:

  - Added a callback for [PackageLanding] at the end of the app init phase to use freely [Injector] operations and another dependencies calculations.

- Fixes:

  - Fixed a bug with the [PackageLanding] builder at the {Menu} about not rendering correctly the Scroll View when there were more buttons than the available height.

- Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | get_it                                  | 8.0.3            | 8.0.3           |
    | go_router                               | 15.1.1           | 15.1.2          |
    | device_info_plus                        | 11.4.0           | 11.4.0          |

- Dev Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | flutter_lints                           | 5.0.0            | 5.0.0           |

## 6.0.0 - [29.04-2025]

- Notes:

    1. Changed concept name from [components] to [Widgets].

    2. Added the new [Adaptive] concept, this handles a set of tools to calculate easier the way to display complex views on different platforms.
        - Added a new base class to build adaptive components [AdaptiveWidgetB].
        - Added a new method to evaluate the correct property to set [adaptProperty<'T>].

    3. Added new properties to [Platforms].
        - [name] Descriptive name.
        - [color] Identification color.

    4. Added the new [PackageLanding] concept enhancing the way that package example applications are made.
        - Now the landing packages have a straightforward component to automatically build a good-look application to browser throughout the component library [PackageLanding].
        - All the component library can be customized depending on needs to display configurations and handle states through [PackageLandingEntryI] interface.

    5. Refactorized file organization and concept handling.

    6. Created a new [Injector] with static methods to handle dependencies injection along the application runtime.

    7. Renamed some [Widgets] and injected automatically [Router], [ThemeManager] and [WidgetAdaptiveness] to the application [Injector].

- Fixes:

    1. Fixed an issue where the [PackageLanding] was overflowing render for the collapsible menu.

- Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | get_it                                  | ---              | 8.0.3           |
    | go_router                               | 14.3.0           | 15.1.1          |
    | device_info_plus                        | ---              | 11.4.0          |

- Dev Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | flutter_lints                           | ---              | 5.0.0           |

## 5.0.0 - [29.10-2024]

- Notes:

    1. Fixed a problem was causing application handler wasn't linstening at Theme Changes.
    2. Self theme storing utilities got deprecated.
    3. Removed property [storeKey] from [UpdateTheme] method to avoid is usage.

- Dependencies:

    1. go_router ([14.3.0])

## 4.0.0  - [24.10-2024]

- Notes:

    1. Upgrade of GoRouter.

- Dependencies Upgrade:

    1. go_router ([14.3.0])

## 3.1.0

- Notes:

    1. Updates in [tws_consumer]

        - Added [isVoid] to indicate the [consumer] property is expected to return null and avoid the component
        detects an error when is actually an expected behavior.

- Dependencies Upgrade:

    [NO CHANGES]

## 3.0.0

- Notes:

    1. Renamed the package from [csm_foundation_view] to [csm_view]

- Dependencies upgrade:

    1. go_router ([14.2.0] -> [14.2.7])

## 2.3.0

- Notes:
    1. Added the [pop()] function to the native application Router.

## 2.2.0

- Notes:

    1. Performance improvements.
    2. Theming initialization management, is no longer neccesary initialize mandatory the defaultTheme to use a CSM Applicaiton.
    3. A Landing project page was created to welcome new applications.
    4. Now the bundle size was reduced and the performance was improved.

## 2.1.1

- Notes:

    1. Implements [Agent] conept that handles low level widgets with complex state management more efficient way.
    2. Fixed the [CSMConsume] widget that was auto refreshing and not animating the transition between results, and miss calculating the correct widget per requests state.

## 2.0.1

- Notes:

    1. Fixes for CSMConsume widget being refreshed after a layout builder

## 0.0.1

- Notes:

    1. TODO: Describe initial release.
