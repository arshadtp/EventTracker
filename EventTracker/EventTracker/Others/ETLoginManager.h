//
//  ETLoginManager.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ETLoginManager : NSObject

/**
 *  Show the login page as alert
 */
+ (void) showUserNameAlert;
/**
 *  Method to register the login notification
 *
 *  @param observer object to be notified
 *  @param selector <#selector description#>
 */
+ (void) registerForUserLoginNotifcationWithObserver:(id) observer withSelector:(SEL) selector;
/**
 *  Method to remove the login notification observer
 *
 *  @param observer <#observer description#>
 */
+ (void)  removeForUserLoginNotifcationObserver:(id) observer;
@end
