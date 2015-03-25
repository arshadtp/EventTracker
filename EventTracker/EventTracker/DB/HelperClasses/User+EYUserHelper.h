//
//  User+EYUserHelper.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "User.h"

@interface User (EYUserHelper)

+ (void) checkAndAddUserWithName:(User *) user withCompletionBlock:(void (^)(NSError *error)) completionBlock;

+ (instancetype) getCurrentUser;

+ (void) updateUser:(User *) user withCompletionBlock:(void (^)(NSError *error)) completionBlock;

- (NSMutableArray *) getTrackedEventDetailsArray;
@end
