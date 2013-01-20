//
//  Region.h
//  SimpleGeocoding
//
//  Created by Hellier on 10/1/12.
//  Copyright (c) 2012 Void. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface SGCountry : NSObject
{
    NSMutableArray *polygons;
}

@property (readonly,nonatomic) NSString *alpha_2_code;
@property (readonly,nonatomic) NSString *alpha_3_code;
@property (readonly,nonatomic) NSArray *polygons;
@property (readonly,nonatomic) CGRect boundingBox;

-(BOOL)boundariesContainsCoordinate:(CLLocationCoordinate2D)coordinate;
-(BOOL)boundingBoxContainsCoordinate:(CLLocationCoordinate2D)coordinate;
+(SGCountry*)countryWithCountryDict:(NSDictionary*)dictionary;
+(NSArray*)countriesFromDictionary:(NSDictionary*)dictionary;


@end
