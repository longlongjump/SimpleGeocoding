//
//  SGWorld.m
//  SimpleGeocoding
//
//  Created by Hellier on 19.01.13.
//  Copyright (c) 2013 Void. All rights reserved.
//

#import "SGWorld.h"
#import "SimpleGeocoding.h"
#import "SBJson.h"

static CGRect rectFromFileName(NSString *filename)
{
    NSArray *coords = [[filename stringByDeletingPathExtension] componentsSeparatedByString:@"_"];
    CGRect rect = CGRectZero;
    rect.origin.x = [[coords objectAtIndex:0] doubleValue];
    rect.origin.y = [[coords objectAtIndex:1] doubleValue];
    rect.size.width = [[coords objectAtIndex:2] doubleValue] - rect.origin.x;
    rect.size.height = [[coords objectAtIndex:3] doubleValue] - rect.origin.y;
    return rect;
}


@interface SGWorld()
{
    SGCountry *last_country;
    NSString *world_path;
    NSMutableDictionary *world_regions;
}
-(NSString*)regionFilePathForCoordinate:(CLLocationCoordinate2D)coordinate;
@end

@implementation SGWorld
@synthesize countries;


-(id)initWithPath:(NSString *)path
{
    if (self = [super init])
    {
        world_path = path;
        world_regions = [NSMutableDictionary dictionary];
    }
    return self;
}

-(NSArray*)findRegionForCoordinate:(CLLocationCoordinate2D)coordinate
{
    CGPoint point = CGPointMake(coordinate.longitude, coordinate.latitude);
    for (NSString *key in world_regions)
    {
        CGRect rect = CGRectFromString(key);
        if (CGRectContainsPoint(rect, point))
        {
            return [world_regions objectForKey:key];
        }
    }
    return nil;
}

-(NSArray*)regionForCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSArray *region_countries = [self findRegionForCoordinate:coordinate];
    if (region_countries)
    {
        return region_countries;
    }
    
    NSString *region_file_path = [self regionFilePathForCoordinate:coordinate];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *region = [parser objectWithData:[NSData dataWithContentsOfFile:region_file_path]];
    
    region_countries = [SGCountry countriesFromDictionary:region];
    
    [world_regions setObject:region_countries
                      forKey:NSStringFromCGRect(rectFromFileName([region_file_path lastPathComponent]))];
    
    return region_countries;
}


-(NSString*)regionFilePathForCoordinate:(CLLocationCoordinate2D)coordinate
{
    CGPoint point = CGPointMake(coordinate.longitude, coordinate.latitude);
    NSFileManager *file_manager = [[NSFileManager alloc] init];
    NSArray *files = [file_manager contentsOfDirectoryAtPath:world_path
                                      error:nil];
    for (NSString *file_name in files)
    {
        CGRect rect = rectFromFileName(file_name);
        if (CGRectContainsPoint(rect, point))
        {
            return [world_path stringByAppendingPathComponent:file_name];
        }
    }
    
    return nil;
}

-(SGCountry*)findCountryAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    SGCountry *possible_country = nil;
    for (SGCountry *country in [self regionForCoordinate:coordinate])
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

-(SGCountry*)countryForCoordinate:(CLLocationCoordinate2D)coordinate
{
    if ([last_country boundariesContainsCoordinate:coordinate])
    {
        return last_country;
    }
    
    last_country = [self findCountryAtCoordinate:coordinate];
    return last_country;
}

@end
