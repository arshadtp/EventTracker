//
//  ETUserDefault.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const CURRENT_USER_KEY = @"current user";
@interface ETUserDefault : NSObject

+ (NSString *) getCurrentUserName;
+ (void) setCurrentUser:(NSString *) userName;
@end
