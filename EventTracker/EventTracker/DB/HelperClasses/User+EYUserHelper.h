//
//  User+EYUserHelper.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "User.h"

@interface User (EYUserHelper)

/**
 *  Mothod check whether whether a perticur user exists in DB. If not exists the insert a new user
 *
 *  @param user <#user description#>
 */
+ (void) checkAndAddUserWithName:(User *) user withCompletionBlock:(void (^)(NSError *error)) completionBlock;

/**
 *  Method returns the details of current user
 *
 *  @return User details
 */
+ (instancetype) getCurrentUser;

/**
 *  Method update the details of current user
 *
 *  @param user New detais to be updated
 */
+ (void) updateUser:(User *) user withCompletionBlock:(void (^)(NSError *error)) completionBlock;

- (NSMutableArray *) getTrackedEventDetailsArray;
@end
