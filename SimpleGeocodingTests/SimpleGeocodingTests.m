//
//  SimpleGeocodingTests.m
//  SimpleGeocodingTests
//
//  Created by Hellier on 9/29/12.
//  Copyright (c) 2012 Void. All rights reserved.
//

#import "SimpleGeocodingTests.h"
#import "SimpleGeocoding.h"

@implementation SimpleGeocodingTests

- (void)setUp
{
    NSString *path = [[NSBundle bundleForClass:NSClassFromString(@"SimpleGeocodingTests")] pathForResource:@"world_geo" ofType:@"json"];
    [SimpleGeocoding initializeWithPath:path error:nil];
    
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void)testCountryForCoordinate
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(46.28, 30.44);
    SGCountry *country = [SimpleGeocoding countryForCoordinate:coord];
    STAssertEqualObjects(country.alpha_2_code, @"UA", @"country code should equal Ukraine");
}

@end
