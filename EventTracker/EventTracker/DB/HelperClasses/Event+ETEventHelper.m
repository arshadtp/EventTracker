//
//  Event+ETEventHelper.m
//  EventTracker
//
//  Created by Arshad T P on 3/24/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "Event+ETEventHelper.h"

@implementation Event (ETEventHelper)

+ (void) loadStaticEvents {
	
	[self fetchAllEventsWithCompletionBlock:^(NSArray *array, NSError *error) {
		if (!array || array.count == 0) {
			NSManagedObjectContext *context = [[ETDBManager sharedManager] managedObjectContext];
			
			NSArray *staticEvents = [ETUtilities getStaticEvents];
			if (staticEvents) {
				[staticEvents enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
					NSManagedObject *newEvents = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
					[newEvents setValuesForKeysWithDictionary:obj];
					if (*stop) {
						NSError *error;
						if (![context save:&error]) {
							// Handle the error.
						}
						
					}
				}];
			}
		}
	}];
	
}

+(void) fetchAllEventsWithCompletionBlock:(didFetchEvents) completionBlock {
	
	NSManagedObjectContext *context = [[ETDBManager sharedManager] managedObjectContext];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
	__block NSError *error;
	NSArray *objects = [context executeFetchRequest:request error:&error];
	completionBlock(objects, error);
}

+(instancetype) getEventWithEventId:(NSNumber *) eventId {
	
	NSManagedObjectContext *context = [[ETDBManager sharedManager] managedObjectContext];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventId == %@", eventId];
	[request setPredicate:predicate];
	__block NSError *error;
	NSArray *objects = [context executeFetchRequest:request error:&error];
	if (error) {
		// handle error
	} else if(objects && objects.count > 0){
		return [objects firstObject];
	}
	return nil;	
}


@end
