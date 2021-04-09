import 'package:web_menu_flutter/src/models/models.dart';

class ProfileRepository {
  Future<Profile> getProfile() async {
    return Future<Profile>.delayed(const Duration(seconds: 1), () {
      return mockProfile;
    });
  }
}

Profile mockProfile = Profile(
  id: '1',
  fullName: 'John Doe',
  email: 'john.doe@gmail.com',
  favourites: mockFavourites,
);

List<Restaurant> mockFavourites = <Restaurant>[
  Restaurant(
      id: '1',
      name: 'Makalonca',
      description: 'A cozy bar on the deck next to Ljubljanica',
      imageUrl: 'https://s.inyourpocket.com/gallery/119833.jpg',
      contactInfo: ContactInfo(
        location: Location(lat: 46.056707623447615, lng: 14.50387829297478),
        address: 'Hribarjevo nabrežje 19',
        city: 'Ljubljana',
        postNumber: '1000',
        email: 'makalonca@bar.si',
        phone: '040 326 438',
        website:
            'https://www.tripadvisor.com/Attraction_Review-g274873-d3823510-Reviews-Makalonca-Ljubljana_Upper_Carniola_Region.html',
      ),
      supportedLanguages: <String>[
        'en'
      ],
      openingHours: <String, String>{
        'monday': '11:00 - 22:00',
        'tuesday': '11:00 - 22:00',
        'wednesday': '11:00 - 22:00',
        'thursday': '11:00 - 22:00',
        'friday': '11:00 - 22:00',
        'saturday': '11:00 - 22:00',
        'sunday': '11:00 - 22:00',
      }),
  Restaurant(
      id: '2',
      name: 'Fanny & Mary',
      description: 'A chill bar & restaurant by Ljubljanica',
      imageUrl:
          'https://www.malcajt.com/upload/restaurant/restavracija-fany-mary-ljubljana.jpg',
      contactInfo: ContactInfo(
        location: Location(lat: 46.05219412537654, lng: 14.508355283293918),
        address: 'Petkovškovo nabrežje 23',
        city: 'Ljubljana',
        postNumber: '1000',
        email: 'fannyandmary@bar.si',
        phone: '(05) 223 52 23',
        website: 'https://www.facebook.com/fanymary/',
      ),
      supportedLanguages: <String>[
        'en'
      ],
      openingHours: <String, String>{
        'monday': '11:00 - 22:00',
        'tuesday': '11:00 - 22:00',
        'wednesday': '11:00 - 22:00',
        'thursday': '11:00 - 22:00',
        'friday': '11:00 - 22:00',
        'saturday': '11:00 - 22:00',
        'sunday': '11:00 - 22:00',
      }),
  Restaurant(
      id: '3',
      name: 'Cantina Mexicana',
      description:
          'A Mexican food restaurant with relaxing music and funky pallets',
      imageUrl:
          'https://www.malcajt.com/upload/restaurant_gallery/restaurant_gallery1481101682227.jpg',
      contactInfo: ContactInfo(
        location: Location(lat: 46.05237146126228, lng: 14.505211657303859),
        address: 'Knafljev prehod 2',
        city: 'Ljubljana',
        postNumber: '1000',
        email: 'cantina@mexicana.si',
        phone: '(01) 426 93 25',
        website: 'https://www.cantina.si/en/',
      ),
      supportedLanguages: <String>[
        'en'
      ],
      openingHours: <String, String>{
        'monday': '11:00 - 22:00',
        'tuesday': '11:00 - 22:00',
        'wednesday': '11:00 - 22:00',
        'thursday': '11:00 - 22:00',
        'friday': '11:00 - 22:00',
        'saturday': '11:00 - 22:00',
        'sunday': '11:00 - 22:00',
      }),
];
