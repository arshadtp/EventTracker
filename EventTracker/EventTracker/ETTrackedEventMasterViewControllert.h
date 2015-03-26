//
//  ETTrackedEventMasterViewControllert.h
//  EventTracker
//
//  Created by Arshad T P on 3/22/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Event+ETEventHelper.h"

typedef void (^didSelectEventBlock)(Event *event) ;
@class ETEventListViewController;

@interface ETTrackedEventMasterViewControllert : UITableViewController <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) ETEventListViewController *ETEventListViewController;
@property (strong, nonatomic) didSelectEventBlock didSelectEvent;

@end

