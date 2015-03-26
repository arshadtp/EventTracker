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

/**
 *  Method check if there is any event in Event Table. If not then populate the table with static content
 */
+ (void) loadStaticEvents;
/**
 *  MEthod to fetch all events
 *
 *  @param completionBlock success callback
 */
+(void) fetchAllEventsWithCompletionBlock:(didFetchEvents) completionBlock;
/**
 *  Method returns a details of a perticur evetn
 *
 *  @param eventId id of evetn whose details to be returned
 *
 *  @return evetn details
 */
+(instancetype) getEventWithEventId:(NSNumber *) eventId;
@end
