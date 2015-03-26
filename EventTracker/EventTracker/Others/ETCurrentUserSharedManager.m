//
//  ETCurrentUserSharedManager.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETCurrentUserSharedManager.h"
#import "User+EYUserHelper.h"
#import "Event+ETEventHelper.h"

@interface ETCurrentUserSharedManager()

@end
@implementation ETCurrentUserSharedManager

+ (ETCurrentUserSharedManager *)sharedManager {
	
	static ETCurrentUserSharedManager *sharedMyManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedMyManager = [[self alloc] init];
	});
	return sharedMyManager;
}

- (id)init {
	
	if (self = [super init]) {
	}
	return self;
}

- (NSMutableArray *) trackedEvents {

	User *user = [User getCurrentUser];
	_trackedEvents = [user getTrackedEventDetailsArray];
	return _trackedEvents;
}

- (void) updateUserTrackedEventToDB {
	
	NSMutableArray *eventIds = [[NSMutableArray alloc] init];
	[_trackedEvents enumerateObjectsUsingBlock:^(Event *obj, NSUInteger idx, BOOL *stop) {
		[eventIds addObject:obj.eventId];
	}];
	User *user = [User getCurrentUser];
	user.eventOrderArray = eventIds;
	[User updateUser:user withCompletionBlock:^(NSError *error) {
		
	}];
}

- (BOOL) isEventExistsInTrackedEvents:(NSNumber *) eventId {
	
	NSMutableString *predicateFormat = [NSMutableString stringWithFormat:@"%@ == %@",@"eventId", eventId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat];
	NSArray *filteredArray = [_trackedEvents filteredArrayUsingPredicate:predicate];
	if (filteredArray && filteredArray.count > 0) {
		return YES;
	}
	return NO;
}

+ (void) registerForTrackedEventChangedNotifcationWithObserver:(id) observer withSelector:(SEL) selector {
	[[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:DID_CHANGE_TRACKED_EVENT object:nil];
}

+ (void)  removeTrackedEventChangedNotifcationObserver:(id) observer {
	[[NSNotificationCenter defaultCenter] removeObserver:observer name:DID_CHANGE_TRACKED_EVENT object:nil];
}
@end
