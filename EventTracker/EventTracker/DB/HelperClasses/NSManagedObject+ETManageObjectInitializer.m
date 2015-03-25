//
//  NSManagedObject+ETManageObjectInitializer.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "NSManagedObject+ETManageObjectInitializer.h"
#import "ETDBManager.h"

@implementation NSManagedObject (ETManageObjectInitializer)

+ (instancetype) createNewInstance {
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[ETDBManager sharedManager] managedObjectContext]];
	return [[[self class] alloc]initWithEntity:entity insertIntoManagedObjectContext:nil];
}
@end
