//
//  NSManagedObject+ETManageObjectInitializer.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ETManageObjectInitializer)

+ (instancetype) createNewInstance;
@end
