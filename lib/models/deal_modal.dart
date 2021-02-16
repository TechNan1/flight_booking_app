class Deal {
  String imageUrl;
  String name;
  String address;
  int price;

  Deal({
    this.imageUrl,
    this.name,
    this.address,
    this.price,
  });
}

final List<Deal> deals = [
  Deal(
    imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/33/fc/f0/goa.jpg?w=1100&h=600&s=1',
    name: 'Fly to Goa',
    address: 'Trip for goa holiday',
    price: 175,
  ),
  Deal(
    imageUrl: 'https://i0.wp.com/www.director.co.uk/wp-content/uploads/DubaiTopResized.jpg?fit=1000%2C500&ssl=1',
    name: 'Flying Dubai',
    address: 'Make plan for Dubai with us',
    price: 300,
  ),

];


