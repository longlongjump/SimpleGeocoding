//
//  SimpleGeocoding.m
//  SimpleGeocoding
//
//  Created by Hellier on 9/29/12.
//  Copyright (c) 2012 Void. All rights reserved.
//

#import "SimpleGeocoding.h"
#import "SBJsonParser.h"

static NSMutableArray *countries = nil;


@implementation SimpleGeocoding

+(void)initializeWithPath:(NSString*)path error:(NSError *)error
{
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *geo_data = [parser objectWithData: [NSData dataWithContentsOfFile:path]];
    NSArray *features = [geo_data objectForKey:@"features"];
    countries = [NSMutableArray array];
    for (NSDictionary *feature in features)
    {
        SGCountry *country = [SGCountry countryWithCountryDict:feature];
        [countries addObject:country];
    }
}

+(NSArray*)allCountries
{
    return countries;
}

+(SGCountry*) countryForCoordinate:(CLLocationCoordinate2D)coordinate
{
    SGCountry *possible_country = nil;
    for (SGCountry *country in countries)
    {
        if ([country boundingBoxContainsCoordinate:coordinate])
        {
            possible_country = country;
        }
        else
        {
            continue;
        }
        
        if ([country boundariesContainsCoordinate:coordinate])
        {
            return country;
        }
    }
    return possible_country;
}

@end
