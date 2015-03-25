//
//  Event.h
//  EventTracker
//
//  Created by Arshad T P on 3/24/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSString * eventThumbNailURL;
@property (nonatomic, retain) NSString * eventType;

@property (nonatomic, retain) NSNumber * eventId;

@end
