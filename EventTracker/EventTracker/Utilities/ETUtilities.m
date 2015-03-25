//
//  ETUtilities.m
//  EventTracker
//
//  Created by Arshad T P on 3/24/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETUtilities.h"

@implementation ETUtilities

#define STATIC_EVENT_PLIST @"StaticEvents.plist"
+ (NSArray *) getStaticEvents {
	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *customPlistPath = [path stringByAppendingPathComponent:STATIC_EVENT_PLIST];
	
	NSArray *events = [NSArray arrayWithContentsOfFile:customPlistPath];
	return events;
}
@end
