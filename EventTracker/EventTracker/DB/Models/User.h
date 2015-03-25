//
//  User.h
//  EventTracker
//
//  Created by Arshad T P on 3/24/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObject+ETManageObjectInitializer.h"

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id eventOrderArray;

@end
