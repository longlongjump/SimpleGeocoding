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

+(SGWorld*)world
{
    static SGWorld *world;
    static dispatch_once_t onceToken;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"world" ofType:@"bundle"];
    dispatch_once(&onceToken, ^{
        world = [[SGWorld alloc] initWithPath:path];
    });
    return world;
}

@end
