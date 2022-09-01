# flutter_shopping_list (ENGLISH README VERSION FIRST, POLISH BELOW)


Mobile app for Android system, in which users that belong to the same "household" can create many shopping lists and add products to them. PUSH notifications are utilized to increase user engagement with this application.


  used tools (`pubspec.yaml`):
  - `firebase_core: ^1.11.0` (core of firebase tools, required for them to run).
  - `firebase_auth: ^3.3.5` (responsible for storage and safety of accounts and passwords).
  - `provider: ^6.0.2`  (provides user id for every screen that needs it).
  - `cloud_firestore: ^3.1.9` (cloud database).
  - `flutter_spinkit: ^5.1.0` (loading animations, e.g when waiting for data from cloud firestore to be fetched).
  - `firebase_messaging: ^12.0.0` (push notifications, makes grabbing device token and sending notifications from firebase console possible).
  - `flutter_local_notifications: ^9.7.0` (push notifications - helps with display options for devices).
  - `cloud_functions: ^3.3.3` (push notifications - cloud functions that make it possible for developer to customize push notifications to react with our cloud database, eg send notificaiton on add/modify or data deletion).
  - `card_swiper: ^2.0.4` (makes it possible to display data in interactive and clean lookin cards).
  - `url_launcher: ^6.1.5` (enables link opening, e.g when we click on icon button).


| 1.                                        |  2.                                        |  3.                                        |
| ----------------------------------------- | ------------------------------------------ | ------------------------------------------ | 
| ![](https://i.imgur.com/xoS3q4e.jpg)      | ![](https://i.imgur.com/bXCPynl.jpg)       | ![](https://i.imgur.com/fyhhU6j.jpg)       |

1. Starting page `(starting_page.dart)`.
2. Sign in with server and client side validation `(sign_in.dart)`.         
3. Sign up with server and client side validation `(sign_up.dart)`.


  
|                   4.                       |                     5.                     |                6.                          |
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------ |
| ![](https://i.imgur.com/qNFYfU0.jpg)       | ![](https://i.imgur.com/PFlcP3S.jpg)       | ![](https://i.imgur.com/Hev47PH.jpg)       |

Screenshots 4, 5, 6 are all from the main screen of logged in user `(home_page.dart)`. Here we can find all of our shopping lists with products displayed in neat cards.
At the top of each shopping list, you can see when it was created, they are also numbered starting from #1 for the oldest (sorted by timestamp, ascending).
After pressing that area for some time `(onLongPress())`, an option to delete the shopping list will pop up. You can also obviously add products to the list.
To delete the product you need to hold it for 1 second. If there are products added to the shopping list not by you, a name of user who added it will be visible on the right side of the product name.


|                   7.                       |                     8.                     |                9.                          |
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------ |
| ![](https://i.imgur.com/hmB90jn.jpg)       | ![](https://i.imgur.com/HkGJoV7.jpg)       | ![](https://i.imgur.com/I8rH1Va.jpg)       |

7. Hamburger menu with 3 features `(hamburger_menu.dart)`.
8. A window with house ID which can be shared to a user that we would like to join our house to participate in creating and viewing the shopping lists.
9. Changing house, client and server side validation included `(change_house_page.dart)`.


|                   10.                      |                     11.                    |                12.                         |
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------ |
| ![](https://i.imgur.com/DdwXPKK.jpg)       | ![](https://i.imgur.com/XxYEBks.jpg)       | ![](https://i.imgur.com/TlGTEDr.jpg)       |

10. Screen with users that are in the house, you can change your name here from the default value which is e-mail `(settings_page)`.
11. PUSH notification when shopping list is created by some other user. This variant shows a situation when our app is open, you can see a snackbar at the bottom of the screen. 
12. Same notification but when we were to receive it when our app is running in the background. 


#POLISH VERSION

Aplikacja mobilna na system Android w której użytkownicy znajdujący się w tym samym domu mogą tworzyć wiele list zakupów oraz dodawać do nich produkty. Aplikacja posiada powiadomienia push by podnieść jakość korzystania przez użytkownika z tej aplikacji.


  użyte narzędzia (`pubspec.yaml`):
  - `firebase_core: ^1.11.0` (rdzeń usług firebase, wymagany by one działały).
  - `firebase_auth: ^3.3.5` (odpowiada za przechowywanie i bezpieczeństwo kont i haseł).
  - `provider: ^6.0.2`  (dostarcza id użytkownika między ekranami).
  - `cloud_firestore: ^3.1.9` (baza danych w chmurze).
  - `flutter_spinkit: ^5.1.0` (animacje ładowania np. gdy oczekujemy na dane z serwera firestore).
  - `firebase_messaging: ^12.0.0` (push notifications, pobiera token urządzenia oraz umożliwia wysyłania prostych powiadomień z poziomu konsoli firebase).
  - `flutter_local_notifications: ^9.7.0` (push notifications, opcje wyświetlanie na urządzeniach).
  - `cloud_functions: ^3.3.3` (push notifications, funkcje w chmurze, umożliwiają programiście na customizacje powiadomień by reagowały one na zachowania w bazie danych (dodawanie/usuwanie/modyfikacja) ich).
  - `card_swiper: ^2.0.4` (umożliwają wyświetlanie danych w kartach).
  - `url_launcher: ^6.1.5` (umożliwia otwieranie linków, np. gdy klikniemy w ikone aplikacji).


| 1.                                        |  2.                                        |  3.                                        |
| ----------------------------------------- | ------------------------------------------ | ------------------------------------------ | 
| ![](https://i.imgur.com/xoS3q4e.jpg)      | ![](https://i.imgur.com/bXCPynl.jpg)       | ![](https://i.imgur.com/fyhhU6j.jpg)       |

1. Strona startowa `(starting_page.dart)`.
2. Logowanie z walidacją po stronie klienta i serwera `(sign_in.dart)`.         
3. Rejestracja z walidacją po stronie klienta  i serwera `(sign_up.dart)`.


  
|                   4.                       |                     5.                     |                6.                          |
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------ |
| ![](https://i.imgur.com/qNFYfU0.jpg)       | ![](https://i.imgur.com/PFlcP3S.jpg)       | ![](https://i.imgur.com/Hev47PH.jpg)       |

Zdjęcia 4, 5, 6 są ze strony głównej zalogowanego użytkownika `(home_page.dart)`. Znajdują się na niej wszystkie listy zakupów z produktami wyświetlane w kartach.
Na samej górze listy zakupów widać, jak wcześnie została ona założona. Karta z numerem #1 jest najstarsza (listy sortowane są po timestampie rosnąco).
Po długim przytrzymaniu `(onLongPress())`, jest opcja usunięcia listy zakupów. Można też dodać produkty. By usunąć produkt trzeba długo go przytrzymać.
Jeśli nie ty dodałeś produkt do listy, będzie on zawierał nazwe użytkownika który ją dodał, po prawej stronie od nazwy produktu.


|                   7.                       |                     8.                     |                9.                          |
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------ |
| ![](https://i.imgur.com/hmB90jn.jpg)       | ![](https://i.imgur.com/HkGJoV7.jpg)       | ![](https://i.imgur.com/I8rH1Va.jpg)       |

7. Hamburger menu z trzema funkcjonalnościami `(hamburger_menu.dart)`.
8. Okno z ID domu które możemy udostępnić użytkownikowi, którego chcemy zaprosić do domu by wspólnie tworzyć i wyświetlać listy zakupów.
9. Zmiana domu z walidacją po stronie klienta i serwera`(change_house_page.dart)`.


|                   10.                      |                     11.                    |                12.                         |
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------ |
| ![](https://i.imgur.com/DdwXPKK.jpg)       | ![](https://i.imgur.com/XxYEBks.jpg)       | ![](https://i.imgur.com/TlGTEDr.jpg)       |

10. Ekran członków domu, można zmienić swoją nazwe, domyślnie jest to e-mail `(settings_page)`.
11. Notyfikacja stworzenia listy zakupów przez innego niż my użytkownika w tym domu. Wariant gdy mamy otwartą aplikacje, pokazuje się snackbar na dole ekranu.
12. Również ta sama notyfikacja, ale gdy przyjdzie ona nam gdy aplikacja działa w tle.
