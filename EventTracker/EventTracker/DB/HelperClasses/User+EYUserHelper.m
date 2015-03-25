//
//  User+EYUserHelper.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "User+EYUserHelper.h"
#import "ETDBManager.h"
#import "ETUserDefault.h"
#import "Event+ETEventHelper.h"

@implementation User (EYUserHelper)


+ (void) checkAndAddUserWithName:(User *) user withCompletionBlock:(void (^)(NSError *error)) completionBlock {
	
	[self isUserExists:user withCompletionBlock:^(BOOL isUserExists, NSError *error) {
		if (error) {
			completionBlock(error);
			return;
		}
		if (!isUserExists) {
			[self insertUserWithName:user withCompletionBlock:^(NSError *error) {
				completionBlock(error);
			}];
		} else {
			completionBlock(nil);
		}
	}];
}


+ (void) isUserExists:(User *) user withCompletionBlock:(void (^)(BOOL isUserExists, NSError *error)) completionHandler  {
	
	NSManagedObjectContext *context = [[ETDBManager sharedManager] managedObjectContext];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", user.name];
	[request setPredicate:predicate];
	__block NSError *error;
	NSArray *objects = [context executeFetchRequest:request error:&error];
	if(error) {
		completionHandler(NO, error);
	} else if (objects && objects.count > 0) {
		completionHandler (YES, error);
	} else {
		completionHandler(NO,error);
	}
}

+ (instancetype) getUserWithName:(User *) user  {
	
	NSManagedObjectContext *context = [[ETDBManager sharedManager] managedObjectContext];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", user.name];
	[request setPredicate:predicate];
	__block NSError *error;
	NSArray *objects = [context executeFetchRequest:request error:&error];
	if(error) {
		//handle error
	} else if (objects && objects.count > 0) {
		return ([objects firstObject]);
	}
	return nil;
}

+ (void) insertUserWithName:(User *) user withCompletionBlock:(void (^)(NSError *error)) completionBlock {
	
	NSManagedObjectContext *context = [[ETDBManager sharedManager] managedObjectContext];
	
	NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
	if (user.name) {
		[newUser setValue:user.name forKey:@"name"];

	}
	if (user.eventOrderArray) {
		[newUser setValue:user.eventOrderArray forKey:@"eventOrderArray"];
	}
	NSError *error;
	if (![context save:&error]) {
					// Handle the error.
	}
	completionBlock(error);
}

+ (void) updateUser:(User *) user withCompletionBlock:(void (^)(NSError *error)) completionBlock {
	
	NSManagedObjectContext *context = [[ETDBManager sharedManager] managedObjectContext];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", user.name];
	[request setPredicate:predicate];
	__block NSError *error;
	NSArray *objects = [context executeFetchRequest:request error:&error];
	if(error) {
		completionBlock(error);
		//handle error
	} else if (objects && objects.count > 0) {
		NSManagedObject *obj = [objects firstObject];
		[obj setValue:user.eventOrderArray forKey:@"eventOrderArray"];
		NSError *error;
		if (![context save:&error]) {
			// Handle the error.
		}
		completionBlock(error);

	}

}

+ (instancetype) getCurrentUser  {
	
	NSString *userName = [ETUserDefault getCurrentUserName];
	if (userName) {
		User *user = [User createNewInstance];
		user.name = userName;
		return [self getUserWithName:user];
	}
	return nil;

}

- (NSMutableArray *) getTrackedEventDetailsArray {
	
	NSMutableArray *trackedEvents = [[NSMutableArray alloc]init];
	for (NSNumber *eventId in self.eventOrderArray) {
		
	 Event *event = [Event getEventWithEventId:eventId];
		if (event) {
			[trackedEvents addObject:event];
			
		}
	}
	return trackedEvents;
}
@end
