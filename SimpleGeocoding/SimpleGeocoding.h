//
//  SimpleGeocoding.h
//  SimpleGeocoding
//
//  Created by Hellier on 9/29/12.
//  Copyright (c) 2012 Void. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SGCountry.h"

@interface SimpleGeocoding : NSObject
+(SGCountry*) countryForCoordinate:(CLLocationCoordinate2D)coordinate;
+(NSArray*)allCountries;

+(void)initializeWithPath:(NSString*)path error:(NSError*)error;
@end
