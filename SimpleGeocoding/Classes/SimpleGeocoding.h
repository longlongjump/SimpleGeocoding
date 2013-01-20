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
#import "SGWorld.h"

@class SGWorld;

@interface SimpleGeocoding : NSObject
+(SGWorld*)world;
@end
