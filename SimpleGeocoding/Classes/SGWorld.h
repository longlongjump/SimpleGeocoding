//
//  SGWorld.h
//  SimpleGeocoding
//
//  Created by Hellier on 19.01.13.
//  Copyright (c) 2013 Void. All rights reserved.
//

#import "SimpleGeocoding.h"

@interface SGWorld : NSObject
@property (readonly,nonatomic) NSArray *countries;

-(id)initWithPath:(NSString*)path;
-(SGCountry*)countryForCoordinate:(CLLocationCoordinate2D)coordinate;

@end
