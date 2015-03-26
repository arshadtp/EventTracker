//
//  ETCurrentUserSharedManager.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const DID_CHANGE_TRACKED_EVENT = @"did change tracked event";

@interface ETCurrentUserSharedManager : NSObject

+ (ETCurrentUserSharedManager *)sharedManager;

/**
 *  Store the tracked events Ids to User table
 */
- (void) updateUserTrackedEventToDB ;

/**
 *  Method check whether a perticuler event is present in tracked events
 *
 *  @param eventId <#eventId description#>
 *
 *  @return true if eventId present in tracked event
 */
- (BOOL) isEventExistsInTrackedEvents:(NSNumber *) eventId;

+ (void) registerForTrackedEventChangedNotifcationWithObserver:(id) observer withSelector:(SEL) selector;
+ (void)  removeTrackedEventChangedNotifcationObserver:(id) observer ;
@property (nonatomic, strong) NSMutableArray *trackedEvents;
@end
