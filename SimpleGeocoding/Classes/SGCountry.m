//
//  Region.m
//  SimpleGeocoding
//
//  Created by Hellier on 10/1/12.
//  Copyright (c) 2012 Void. All rights reserved.
//

#import "SGCountry.h"
#import "SimpleGeocoding.h"
#import <QuartzCore/QuartzCore.h>

@implementation SGCountry
@synthesize alpha_2_code, alpha_3_code;
@synthesize polygons;
@synthesize boundingBox;

-(id)init
{
    if (self = [super init])
    {
        polygons = [NSMutableArray array];
    }
    return self;
}

-(void)updateBoundingBox
{
    if (polygons.count == 0)
        return;
    
    UIBezierPath *first_polygon = [polygons objectAtIndex:0];
    CGRect bbox = first_polygon.bounds;
    
    for (int i=1; i<polygons.count; ++i)
    {
        UIBezierPath *polygon = [polygons objectAtIndex:i];
        bbox = CGRectUnion(bbox, polygon.bounds);
    }
    
    boundingBox = bbox;
}


-(void)updateWithDictionary:(NSDictionary*)dict
{
    alpha_2_code = [[dict objectForKey:@"properties"] objectForKey:@"ISO_A2"];
    alpha_3_code = [[dict objectForKey:@"properties"] objectForKey:@"ISO_A3"];

    
    [polygons removeAllObjects];
    NSArray *geometry = [[dict objectForKey:@"geometry"] objectForKey:@"coordinates"];
    
    for (NSArray *country_polygon in geometry)
    {
        UIBezierPath *polygon = [UIBezierPath bezierPath];
        NSArray *first_point = [country_polygon objectAtIndex:0];
        [polygon moveToPoint:CGPointMake([[first_point objectAtIndex:0] floatValue],
                                        [first_point.lastObject floatValue])];
        for (int i = 1; i < country_polygon.count; ++i)
        {
            NSArray *point = [country_polygon objectAtIndex:i];
            [polygon addLineToPoint:CGPointMake([[point objectAtIndex:0] floatValue],
                                            [point.lastObject floatValue])];
        }
    
        [polygon closePath];
        [polygons addObject:polygon];
    }
    
    [self updateBoundingBox];
}

+(NSArray*)countriesFromDictionary:(NSDictionary*)dictionary
{
    NSMutableArray *countries = [NSMutableArray array];
    for (NSDictionary *country_dict in [dictionary objectForKey:@"features"])
    {
        SGCountry *country = [self countryWithCountryDict:country_dict];
        [countries addObject:country];
    }
    return countries;
}

+(SGCountry*)countryWithCountryDict:(NSDictionary*)dictinary
{
    SGCountry *country = [[SGCountry alloc] init];
    [country updateWithDictionary:dictinary];
    return country;
}

-(BOOL)boundariesContainsCoordinate:(CLLocationCoordinate2D)coordinate
{
    CGPoint point = CGPointMake(coordinate.longitude, coordinate.latitude);
    for (UIBezierPath *path in self.polygons)
    {
        if ([path containsPoint:point])
        {
            return YES;
        }
    }
    return NO;
}

-(BOOL)boundingBoxContainsCoordinate:(CLLocationCoordinate2D)coordinate
{
    CGPoint point = CGPointMake(coordinate.longitude, coordinate.latitude);
    for (UIBezierPath *path in self.polygons)
    {
        if (CGRectContainsPoint(path.bounds, point))
        {
            return YES;
        }
    }
    return NO;
}



@end
