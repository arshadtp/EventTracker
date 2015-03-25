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

+ (void) showUserNameAlert;
+ (void) registerForUserLoginNotifcationWithObserver:(id) observer withSelector:(SEL) selector;
+ (void)  removeForUserLoginNotifcationObserver:(id) observer;
@end
