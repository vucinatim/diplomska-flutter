// import 'package:web_menu_flutter/src/models/models.dart';
//
// List<Restaurant> mockRestaurants = <Restaurant>[
//   Restaurant(
//       id: '1',
//       name: 'Makalonca',
//       description: 'A cozy bar on the deck next to Ljubljanica',
//       thumbnail: 'https://s.inyourpocket.com/gallery/119833.jpg',
//       contactInfo: ContactInfo(
//         location: Location(lat: 46.056707623447615, lng: 14.50387829297478),
//         address: 'Hribarjevo nabrežje 19',
//         city: 'Ljubljana',
//         postNumber: '1000',
//         email: 'makalonca@bar.si',
//         phone: '040 326 438',
//         website:
//             'https://www.tripadvisor.com/Attraction_Review-g274873-d3823510-Reviews-Makalonca-Ljubljana_Upper_Carniola_Region.html',
//       ),
//       supportedLanguages: <String>[
//         'en'
//       ],
//       openingHours: <String, String>{
//         'monday': '11:00 - 22:00',
//         'tuesday': '11:00 - 22:00',
//         'wednesday': '11:00 - 22:00',
//         'thursday': '11:00 - 22:00',
//         'friday': '11:00 - 22:00',
//         'saturday': '11:00 - 22:00',
//         'sunday': '11:00 - 22:00',
//       }),
//   Restaurant(
//       id: '2',
//       name: 'Fanny & Mary',
//       description: 'A chill bar & restaurant by Ljubljanica',
//       thumbnail:
//           'https://www.malcajt.com/upload/restaurant/restavracija-fany-mary-ljubljana.jpg',
//       contactInfo: ContactInfo(
//         location: Location(lat: 46.05219412537654, lng: 14.508355283293918),
//         address: 'Petkovškovo nabrežje 23',
//         city: 'Ljubljana',
//         postNumber: '1000',
//         email: 'fannyandmary@bar.si',
//         phone: '(05) 223 52 23',
//         website: 'https://www.facebook.com/fanymary/',
//       ),
//       supportedLanguages: <String>[
//         'en'
//       ],
//       openingHours: <String, String>{
//         'monday': '11:00 - 22:00',
//         'tuesday': '11:00 - 22:00',
//         'wednesday': '11:00 - 22:00',
//         'thursday': '11:00 - 22:00',
//         'friday': '11:00 - 22:00',
//         'saturday': '11:00 - 22:00',
//         'sunday': '11:00 - 22:00',
//       }),
//   Restaurant(
//       id: '3',
//       name: 'Cantina Mexicana',
//       description:
//           'A Mexican food restaurant with relaxing music and funky pallets',
//       thumbnail:
//           'https://www.malcajt.com/upload/restaurant_gallery/restaurant_gallery1481101682227.jpg',
//       contactInfo: ContactInfo(
//         location: Location(lat: 46.05237146126228, lng: 14.505211657303859),
//         address: 'Knafljev prehod 2',
//         city: 'Ljubljana',
//         postNumber: '1000',
//         email: 'cantina@mexicana.si',
//         phone: '(01) 426 93 25',
//         website: 'https://www.cantina.si/en/',
//       ),
//       supportedLanguages: <String>[
//         'en'
//       ],
//       openingHours: <String, String>{
//         'monday': '11:00 - 22:00',
//         'tuesday': '11:00 - 22:00',
//         'wednesday': '11:00 - 22:00',
//         'thursday': '11:00 - 22:00',
//         'friday': '11:00 - 22:00',
//         'saturday': '11:00 - 22:00',
//         'sunday': '11:00 - 22:00',
//       }),
//   Restaurant(
//       id: '4',
//       name: 'DA BU DA',
//       description:
//           'Dabuda Asian fusion restavracija - sedaj tudi ekspres dostava s kolesi!',
//       thumbnail:
//           'https://mynight.si/wp-content/uploads/2016/12/DA-BU-DA-tajska-restavracija.jpg',
//       contactInfo: ContactInfo(
//         location: Location(lat: 46.05100022940035, lng: 14.501909756305706),
//         address: 'Šubičeva ulica 1a',
//         city: 'Ljubljana',
//         postNumber: '1000',
//         email: 'dabuda@restaurant.si',
//         phone: '(01) 425 30 60',
//         website: 'http://www.dabuda.si/',
//       ),
//       supportedLanguages: <String>[
//         'en'
//       ],
//       openingHours: <String, String>{
//         'monday': '11:00 - 22:00',
//         'tuesday': '11:00 - 22:00',
//         'wednesday': '11:00 - 22:00',
//         'thursday': '11:00 - 22:00',
//         'friday': '11:00 - 22:00',
//         'saturday': '11:00 - 22:00',
//         'sunday': '11:00 - 22:00',
//       }),
//   Restaurant(
//       id: '5',
//       name: 'Makalonca 1',
//       description: 'A cozy bar on the deck next to Ljubljanica',
//       thumbnail: 'https://s.inyourpocket.com/gallery/119833.jpg',
//       contactInfo: ContactInfo(
//         address: 'Hribarjevo nabrežje 19',
//         city: 'Ljubljana',
//         postNumber: '1000',
//         email: 'makalonca@bar.si',
//         phone: '040 326 438',
//         website:
//             'https://www.tripadvisor.com/Attraction_Review-g274873-d3823510-Reviews-Makalonca-Ljubljana_Upper_Carniola_Region.html',
//       ),
//       supportedLanguages: <String>[
//         'en'
//       ],
//       openingHours: <String, String>{
//         'monday': '11:00 - 22:00',
//         'tuesday': '11:00 - 22:00',
//         'wednesday': '11:00 - 22:00',
//         'thursday': '11:00 - 22:00',
//         'friday': '11:00 - 22:00',
//         'saturday': '11:00 - 22:00',
//         'sunday': '11:00 - 22:00',
//       }),
//   Restaurant(
//     id: '6',
//     name: 'Fanny & Mary 1',
//     description: 'A chill bar & restaurant by Ljubljanica',
//     thumbnail:
//         'https://www.malcajt.com/upload/restaurant/restavracija-fany-mary-ljubljana.jpg',
//     contactInfo: ContactInfo(
//       address: 'Petkovškovo nabrežje 23',
//       city: 'Ljubljana',
//       postNumber: '1000',
//       email: 'fannyandmary@bar.si',
//       phone: '(05) 223 52 23',
//       website: 'https://www.facebook.com/fanymary/',
//     ),
//   ),
//   Restaurant(
//     id: '7',
//     name: 'Cantina Mexicana 1',
//     description:
//         'A Mexican food restaurant with relaxing music and funky pallets',
//     thumbnail:
//         'https://www.malcajt.com/upload/restaurant_gallery/restaurant_gallery1481101682227.jpg',
//     contactInfo: ContactInfo(
//       address: 'Knafljev prehod 2',
//       city: 'Ljubljana',
//       postNumber: '1000',
//       email: 'cantina@mexicana.si',
//       phone: '(01) 426 93 25',
//       website: 'https://www.cantina.si/en/',
//     ),
//   ),
//   Restaurant(
//     id: '8',
//     name: 'DA BU DA 1',
//     description:
//         'Dabuda Asian fusion restavracija - sedaj tudi ekspres dostava s kolesi!',
//     thumbnail:
//         'https://mynight.si/wp-content/uploads/2016/12/DA-BU-DA-tajska-restavracija.jpg',
//     contactInfo: ContactInfo(
//       address: 'Šubičeva ulica 1a',
//       city: 'Ljubljana',
//       postNumber: '1000',
//       email: 'dabuda@restaurant.si',
//       phone: '(01) 425 30 60',
//       website: 'http://www.dabuda.si/',
//     ),
//   ),
//   Restaurant(
//     id: '9',
//     name: 'Makalonca 2',
//     description: 'A cozy bar on the deck next to Ljubljanica',
//     thumbnail: 'https://s.inyourpocket.com/gallery/119833.jpg',
//     contactInfo: ContactInfo(
//       address: 'Hribarjevo nabrežje 19',
//       city: 'Ljubljana',
//       postNumber: '1000',
//       email: 'makalonca@bar.si',
//       phone: '040 326 438',
//       website:
//           'https://www.tripadvisor.com/Attraction_Review-g274873-d3823510-Reviews-Makalonca-Ljubljana_Upper_Carniola_Region.html',
//     ),
//   ),
//   Restaurant(
//     id: '10',
//     name: 'Fanny & Mary 2',
//     description: 'A chill bar & restaurant by Ljubljanica',
//     thumbnail:
//         'https://www.malcajt.com/upload/restaurant/restavracija-fany-mary-ljubljana.jpg',
//     contactInfo: ContactInfo(
//       address: 'Petkovškovo nabrežje 23',
//       city: 'Ljubljana',
//       postNumber: '1000',
//       email: 'fannyandmary@bar.si',
//       phone: '(05) 223 52 23',
//       website: 'https://www.facebook.com/fanymary/',
//     ),
//   ),
//   Restaurant(
//     id: '11',
//     name: 'Cantina Mexicana 2',
//     description:
//         'A Mexican food restaurant with relaxing music and funky pallets',
//     thumbnail:
//         'https://www.malcajt.com/upload/restaurant_gallery/restaurant_gallery1481101682227.jpg',
//     contactInfo: ContactInfo(
//       address: 'Knafljev prehod 2',
//       city: 'Ljubljana',
//       postNumber: '1000',
//       email: 'cantina@mexicana.si',
//       phone: '(01) 426 93 25',
//       website: 'https://www.cantina.si/en/',
//     ),
//   ),
//   Restaurant(
//     id: '12',
//     name: 'DA BU DA 2',
//     description:
//         'Dabuda Asian fusion restavracija - sedaj tudi ekspres dostava s kolesi!',
//     thumbnail:
//         'https://mynight.si/wp-content/uploads/2016/12/DA-BU-DA-tajska-restavracija.jpg',
//     contactInfo: ContactInfo(
//       address: 'Šubičeva ulica 1a',
//       city: 'Ljubljana',
//       postNumber: '1000',
//       email: 'dabuda@restaurant.si',
//       phone: '(01) 425 30 60',
//       website: 'http://www.dabuda.si/',
//     ),
//   ),
// ];
