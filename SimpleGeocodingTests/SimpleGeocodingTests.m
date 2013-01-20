//
//  SimpleGeocodingTests.m
//  SimpleGeocodingTests
//
//  Created by Hellier on 9/29/12.
//  Copyright (c) 2012 Void. All rights reserved.
//

#import "SimpleGeocodingTests.h"
#import "SimpleGeocoding.h"


@interface SimpleGeocodingTests()
{
    SGWorld *world;
}
@end

@implementation SimpleGeocodingTests

- (void)setUp
{
    [super setUp];
    
    NSBundle *bundle = [NSBundle bundleForClass:[SimpleGeocodingTests class]];
    NSString *path = [bundle pathForResource:@"world" ofType:@"bundle"];
    world = [[SGWorld alloc] initWithPath:path];
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void)testCountryForCoordinate
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(46.28, 30.44);
    SGCountry *country = [world countryForCoordinate:coord];
    STAssertEqualObjects(country.alpha_2_code, @"UA", @"country code should equal Ukraine");
}

-(void)testInnerCountryForCoordinate
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-29.466667, 27.933333);
    SGCountry *country = [world countryForCoordinate:coord];
    STAssertEqualObjects(country.alpha_2_code, @"LS", @"country code should equal Lesoto");
}


-(void)testBorderCoordinate
{
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(18.975, 72.825833);
    SGCountry *country = [world countryForCoordinate:coord];
    STAssertEqualObjects(country.alpha_3_code, @"IND", @"country code should equal India");
}

-(void)testTilburgCoordinate
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(51.557222, 5.091111);
    SGCountry *country = [world countryForCoordinate:coord];
    STAssertEqualObjects(country.alpha_3_code, @"NLD", @"country code should equal NL");
}

-(void)testJerseyCoordinate
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(49.199054718017578, -2.035055637359619);
    SGCountry *country = [world countryForCoordinate:coord];
    STAssertEqualObjects(country.alpha_3_code, @"JEY", @"country code should equal Jersey");
}

-(void)testSingapurCoordinate
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(1.3, 103.8);
    SGCountry *country = [world countryForCoordinate:coord];
    STAssertEqualObjects(country.alpha_3_code, @"SGP", @"country code should equal SGP");
}

@end
