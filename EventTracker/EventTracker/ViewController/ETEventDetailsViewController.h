//
//  ETEventDetailsViewController.h
//  EventTracker
//
//  Created by Arshad T P on 3/26/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event+ETEventHelper.h"
#import "ETImageView.h"
@interface ETEventDetailsViewController : UIViewController

@property (nonatomic, strong) Event *eventDetails;

@property (nonatomic, weak) IBOutlet ETImageView *eventImageView;
@property (nonatomic, weak) IBOutlet UILabel *eventNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *placeLabel;
@property (nonatomic, weak) IBOutlet UILabel *eventTypeLabel;

@end
