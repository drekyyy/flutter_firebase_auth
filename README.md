# flutter_shopping_list

Aplikacja mobilna w której użytkownicy znajdujący się w tym samym domu (do którego można dołączyć podając house id), mogą tworzyć wiele list zakupów oraz dodawać do nich produkty


  użyte paczki z pubspec.yaml
  - `firebase_core: ^1.11.0`
  - `firebase_auth: ^3.3.5` (odpowiada za przechowywanie i bezpieczeństwo kont i haseł)
  - `provider: ^6.0.2`  (dostarcza id użytkownika między ekranami)
  - `cloud_firestore: ^3.1.9` (baza danych)
  - `flutter_spinkit: ^5.1.0` (animacje ładowania gdy oczekujemy na dane z serwera firestore)
  - `firebase_messaging: ^12.0.0` (push notifications, pobiera token urządzenia)
  - `flutter_local_notifications: ^9.7.0` (push notifications, opcje wyświetlanie na urządzeniach)
  - `cloud_functions: ^3.3.3` (push notifications, funkcje w chmurze, umożliwiają customizacje powiadomień by reagowały one na zachowania w bazie danych               (dodawanie/usuwanie/modyfikacja) ich)
  - `card_swiper: ^2.0.4` (umożliwają wyświetlanie danych w kartach)
  - `url_launcher: ^6.1.5` (umożliwia otwieranie linków, np. gdy klikniemy w ikone aplikacji)


                    1.                       |                     2.                     |                     3.
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------- |
![](https://i.imgur.com/xoS3q4e.jpg)         | ![](https://i.imgur.com/bXCPynl.jpg)        | ![](https://i.imgur.com/fyhhU6j.jpg)

1. Strona startowa (starting_page.dart).
2. Logowanie z walidacją po stronie klienta i serwera (sign_in.dart).         
3. Rejestracja po stronie klienta  i serwera (sign_up.dart).


                    4.                       |                     5.                     |                6.
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------ |
![](https://i.imgur.com/PFlcP3S.jpg)         |  ![](https://i.imgur.com/Hev47PH.jpg)      |  ![](https://i.imgur.com/Hev47PH.jpg) 

Zdjęcia 4, 5, 6 są ze strony głównej zalogowanego użytkownika. Znajdują się na niej wszystkie listy zakupów z produktami wyświetlane w kartach.
Na samej górze listy zakupów widać, jak wcześnie została ona założona, karta z numerem #1 jest najstarsza (listy sortowane są po timestampie rosnąco).
Po długim przytrzymaniu (onLongPress()), jest opcja usunięcia listy zakupów. Można też dodać produkty. By usunąć produkt trzeba długo go przytrzymać.
Jeśli nie ty dodałeś produkt do listy, będzie on zawierał nazwe użytkownika który ją dodał.




