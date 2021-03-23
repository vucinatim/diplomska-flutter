import 'package:web_menu_flutter/src/models/models.dart';

class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants({String? searchEntry}) async {
    return Future<List<Restaurant>>.delayed(const Duration(seconds: 1), () {
      if (searchEntry != null) {
        return mockRestaurants
            .where((Restaurant element) =>
                element.name!.toLowerCase().contains(searchEntry.toLowerCase()))
            .toList();
      } else {
        return mockRestaurants;
      }
    });
  }

  Future<Restaurant> getRestaurant(String? id) async {
    return Future<Restaurant>.delayed(const Duration(seconds: 1), () {
      return mockRestaurants
          .singleWhere((Restaurant element) => element.id == id)
          .copyWith(menu: mockItemCategories);
    });
  }
}

List<ItemCategory> mockItemCategories = <ItemCategory>[
  ItemCategory(
    title: <String, String>{'en': 'Non-alcoholic drinks'},
    description: <String, String>{
      'en': 'Refreshing and warm drinks without alcohol'
    },
    items: <MenuItem>[
      MenuItem(
        title: <String, String>{'en': 'Espresso'},
        description: <String, String>{'en': 'Small amount of black coffee'},
        imageUrl:
            'https://www.meinlcoffee.com/wp-content/uploads/2020/04/nw_espresso_cup-2_cut-1.png',
        price: 1.80,
        amount: '100ml',
      ),
      MenuItem(
        title: <String, String>{'en': 'Mint Tea'},
        description: <String, String>{
          'en': 'A refreshing tea from fresh mint leaves'
        },
        imageUrl: 'https://static.toiimg.com/photo/msid-76446497/76446497.jpg',
        price: 2.10,
        amount: '330ml',
      ),
    ],
  ),
  ItemCategory(
    title: <String, String>{'en': 'Alcoholic drinks'},
    description: <String, String>{
      'en': 'Finest vine, home brewed beer and freshly mixed cocktails'
    },
    items: <MenuItem>[
      MenuItem(
        title: <String, String>{'en': 'Beer Union'},
        description: <String, String>{'en': 'Best beer in Slovenia'},
        imageUrl: 'https://www.umer.si/wp-content/uploads/2017/04/zmaj-1.jpg',
        price: 2.80,
        amount: '0,5l',
      ),
      MenuItem(
        title: <String, String>{'en': 'Traminec - White Wine'},
        description: <String, String>{'en': 'Half-dry sweet desert vine'},
        imageUrl:
            'https://253qv1sx4ey389p9wtpp9sj0-wpengine.netdna-ssl.com/wp-content/uploads/2019/09/White_Wine_Getty_HERO_1920x1280.jpg',
        price: 2.10,
        amount: '0,1l',
      ),
    ],
  ),
  ItemCategory(
    title: <String, String>{'en': 'Burgers'},
    description: <String, String>{'en': 'Fine blend tasty burgers'},
    items: <MenuItem>[
      MenuItem(
        title: <String, String>{'en': 'Burger Classic'},
        description: <String, String>{
          'en':
              'Classic burger with special homemade sauce and only the best blend.'
        },
        imageUrl:
            'https://cilipipp.si/storage/_sites/cilipipp/app/media/Recepti/domaci-burger.jpg',
        price: 6.5,
        amount: '250g',
      ),
    ],
  ),
  ItemCategory(
    title: <String, String>{'en': 'Other'},
    description: <String, String>{'en': 'Cigarettes'},
    items: <MenuItem>[
      MenuItem(
        title: <String, String>{'en': 'Marlboro Red'},
        description: <String, String>{'en': 'A pack of 20 cigarettes'},
        imageUrl:
            'https://miro.medium.com/max/1532/1*FQ2qwoaNXdubTAVp4do6ag.png',
        price: 3.80,
        amount: '20',
      ),
    ],
  ),
];

List<MenuItem> mockMenuItems = <MenuItem>[
  MenuItem(
    title: <String, String>{'en': 'Espresso'},
    description: <String, String>{'en': 'Small amount of black coffee'},
    imageUrl:
        'https://www.meinlcoffee.com/wp-content/uploads/2020/04/nw_espresso_cup-2_cut-1.png',
    price: 1.80,
    amount: '100ml',
  ),
  MenuItem(
    title: <String, String>{'en': 'Beer Union'},
    description: <String, String>{'en': 'Best beer in Slovenia'},
    imageUrl: 'https://www.umer.si/wp-content/uploads/2017/04/zmaj-1.jpg',
    price: 2.80,
    amount: '0,5l',
  ),
  MenuItem(
    title: <String, String>{'en': 'Burger Classic'},
    description: <String, String>{
      'en':
          'Classic burger with special homemade sauce and only the best blend.'
    },
    imageUrl:
        'https://cilipipp.si/storage/_sites/cilipipp/app/media/Recepti/domaci-burger.jpg',
    price: 6.5,
    amount: '250g',
  ),
  MenuItem(
    title: <String, String>{'en': 'Marlboro Red'},
    description: <String, String>{'en': 'A pack of 20 cigarettes'},
    imageUrl: 'https://miro.medium.com/max/1532/1*FQ2qwoaNXdubTAVp4do6ag.png',
    price: 3.80,
    amount: '20',
  ),
];

List<Restaurant> mockRestaurants = <Restaurant>[
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
  Restaurant(
      id: '4',
      name: 'DA BU DA',
      description:
          'Dabuda Asian fusion restavracija - sedaj tudi ekspres dostava s kolesi!',
      imageUrl:
          'https://mynight.si/wp-content/uploads/2016/12/DA-BU-DA-tajska-restavracija.jpg',
      contactInfo: ContactInfo(
        location: Location(lat: 46.05100022940035, lng: 14.501909756305706),
        address: 'Šubičeva ulica 1a',
        city: 'Ljubljana',
        postNumber: '1000',
        email: 'dabuda@restaurant.si',
        phone: '(01) 425 30 60',
        website: 'http://www.dabuda.si/',
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
      id: '5',
      name: 'Makalonca 1',
      description: 'A cozy bar on the deck next to Ljubljanica',
      imageUrl: 'https://s.inyourpocket.com/gallery/119833.jpg',
      contactInfo: ContactInfo(
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
    id: '6',
    name: 'Fanny & Mary 1',
    description: 'A chill bar & restaurant by Ljubljanica',
    imageUrl:
        'https://www.malcajt.com/upload/restaurant/restavracija-fany-mary-ljubljana.jpg',
    contactInfo: ContactInfo(
      address: 'Petkovškovo nabrežje 23',
      city: 'Ljubljana',
      postNumber: '1000',
      email: 'fannyandmary@bar.si',
      phone: '(05) 223 52 23',
      website: 'https://www.facebook.com/fanymary/',
    ),
    supportedLanguages: <String>['en'],
  ),
  Restaurant(
    id: '7',
    name: 'Cantina Mexicana 1',
    description:
        'A Mexican food restaurant with relaxing music and funky pallets',
    imageUrl:
        'https://www.malcajt.com/upload/restaurant_gallery/restaurant_gallery1481101682227.jpg',
    contactInfo: ContactInfo(
      address: 'Knafljev prehod 2',
      city: 'Ljubljana',
      postNumber: '1000',
      email: 'cantina@mexicana.si',
      phone: '(01) 426 93 25',
      website: 'https://www.cantina.si/en/',
    ),
    supportedLanguages: <String>['en'],
  ),
  Restaurant(
    id: '8',
    name: 'DA BU DA 1',
    description:
        'Dabuda Asian fusion restavracija - sedaj tudi ekspres dostava s kolesi!',
    imageUrl:
        'https://mynight.si/wp-content/uploads/2016/12/DA-BU-DA-tajska-restavracija.jpg',
    contactInfo: ContactInfo(
      address: 'Šubičeva ulica 1a',
      city: 'Ljubljana',
      postNumber: '1000',
      email: 'dabuda@restaurant.si',
      phone: '(01) 425 30 60',
      website: 'http://www.dabuda.si/',
    ),
    supportedLanguages: <String>['en'],
  ),
  Restaurant(
    id: '9',
    name: 'Makalonca 2',
    description: 'A cozy bar on the deck next to Ljubljanica',
    imageUrl: 'https://s.inyourpocket.com/gallery/119833.jpg',
    contactInfo: ContactInfo(
      address: 'Hribarjevo nabrežje 19',
      city: 'Ljubljana',
      postNumber: '1000',
      email: 'makalonca@bar.si',
      phone: '040 326 438',
      website:
          'https://www.tripadvisor.com/Attraction_Review-g274873-d3823510-Reviews-Makalonca-Ljubljana_Upper_Carniola_Region.html',
    ),
    supportedLanguages: <String>['en'],
  ),
  Restaurant(
    id: '10',
    name: 'Fanny & Mary 2',
    description: 'A chill bar & restaurant by Ljubljanica',
    imageUrl:
        'https://www.malcajt.com/upload/restaurant/restavracija-fany-mary-ljubljana.jpg',
    contactInfo: ContactInfo(
      address: 'Petkovškovo nabrežje 23',
      city: 'Ljubljana',
      postNumber: '1000',
      email: 'fannyandmary@bar.si',
      phone: '(05) 223 52 23',
      website: 'https://www.facebook.com/fanymary/',
    ),
    supportedLanguages: <String>['en'],
  ),
  Restaurant(
    id: '11',
    name: 'Cantina Mexicana 2',
    description:
        'A Mexican food restaurant with relaxing music and funky pallets',
    imageUrl:
        'https://www.malcajt.com/upload/restaurant_gallery/restaurant_gallery1481101682227.jpg',
    contactInfo: ContactInfo(
      address: 'Knafljev prehod 2',
      city: 'Ljubljana',
      postNumber: '1000',
      email: 'cantina@mexicana.si',
      phone: '(01) 426 93 25',
      website: 'https://www.cantina.si/en/',
    ),
    supportedLanguages: <String>['en'],
  ),
  Restaurant(
    id: '12',
    name: 'DA BU DA 2',
    description:
        'Dabuda Asian fusion restavracija - sedaj tudi ekspres dostava s kolesi!',
    imageUrl:
        'https://mynight.si/wp-content/uploads/2016/12/DA-BU-DA-tajska-restavracija.jpg',
    contactInfo: ContactInfo(
      address: 'Šubičeva ulica 1a',
      city: 'Ljubljana',
      postNumber: '1000',
      email: 'dabuda@restaurant.si',
      phone: '(01) 425 30 60',
      website: 'http://www.dabuda.si/',
    ),
    supportedLanguages: <String>['en'],
  ),
];
