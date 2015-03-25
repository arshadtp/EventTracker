//
//  Event+ETEventHelper.h
//  EventTracker
//
//  Created by Arshad T P on 3/24/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "Event.h"
#import "ETDBManager.h"
#import "ETUtilities.h"

typedef void (^didFetchEvents)(NSArray *array, NSError *error);
@interface Event (ETEventHelper)

+ (void) loadStaticEvents;
+(void) fetchAllEventsWithCompletionBlock:(didFetchEvents) completionBlock;
+(instancetype) getEventWithEventId:(NSNumber *) eventId;
@end
