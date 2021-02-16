class Airport {
  String imageUrl;
  String code;
  String shortName;
  String longName;

  Airport({
    this.imageUrl,
    this.code,
    this.shortName,
    this.longName,
  });
}

final List<Airport> airports = [
  Airport(
    imageUrl: 'https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    code: 'BOM',
    shortName: 'Mumbai',
    longName: 'Chatrapati Shijavi Maharaj International Airport'
  ),
  Airport(
    imageUrl: 'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    code: 'DEL',
    shortName: 'New Delhi',
    longName: 'Indira Gandhi International Airport',
  ),
  Airport(
    imageUrl: 'https://images.pexels.com/photos/1579253/pexels-photo-1579253.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    code: 'CCU',
    shortName: 'Kolkata',
    longName: 'Netaji Subhash chandra',
  ),
];
