## Simple Reverse Geocoding framework

  Convert map coordinate to country offline. Can be used with MKReverseGeocoder.
  Contains ISO 3166-1 alpha-3 and ISO 3166-1 alpha-2 country codes. All data is sliced by 30 degree square regions so it would not use much memory.

## Usage

    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(46.28, 30.44)
    SGCountry *country = [[SimpleGeocoding world] countryForCoordinate:coord];
    NSLog(@"%@ %@", country.alpha_2_code, country.alpha_3_code);


Map datasource is from http://www.naturalearthdata.com/
