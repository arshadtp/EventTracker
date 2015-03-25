//
//  ETCurrentUserSharedManager.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETCurrentUserSharedManager : NSObject

+ (ETCurrentUserSharedManager *)sharedManager;

- (void) updateUserTrackedEventToDB ;
@property (nonatomic, strong) NSMutableArray *trackedEvents;
@end
