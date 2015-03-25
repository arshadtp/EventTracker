//
//  ETEventDetailViewController.m
//  EventTracker
//
//  Created by Arshad T P on 3/26/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETEventDetailViewController.h"
#import "ETCurrentUserSharedManager.h"

@implementation ETEventDetailViewController



- (void)viewDidLoad {
	[super viewDidLoad];
	
	//Fix to issue that navigation bar covers view in iOS 7.0.
	self.edgesForExtendedLayout = UIRectEdgeNone;
	[self loadDataInView];
	[self configureTrackButton];
	[self setTitle:@"Event Details"];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void) dealloc {
}

- (void) configureTrackButton {
	if (![[ETCurrentUserSharedManager sharedManager] isEventExistsInTrackedEvents:_eventDetails.eventId]) {
		UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
		[button addTarget:self action:@selector(addToTrackedEvent) forControlEvents:UIControlEventTouchUpInside];
		[button setTitle:@"Track" forState:UIControlStateNormal];
		button.frame = CGRectMake(0, 0, 60, 30);
		UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
		self.navigationItem.rightBarButtonItem = barButton;
	} else {
		self.navigationItem.rightBarButtonItem  = nil;
	}
	
}
- (void) loadDataInView {
	
	[_eventImageView loadImageForUrl:_eventDetails.eventThumbNailURL withSuccessBlock:^(UIImage *image, NSError *error) {
		if (error) {
			_eventImageView.image = image;
		}
	}];
	_eventNameLabel.text = _eventDetails.eventName;
	_eventTypeLabel.text = _eventDetails.eventType;
	_placeLabel.text = _eventDetails.place;
}

- (void) addToTrackedEvent {
	
	[[[ETCurrentUserSharedManager sharedManager] trackedEvents] addObject:_eventDetails];
	[[ETCurrentUserSharedManager sharedManager] updateUserTrackedEventToDB];
	[self configureTrackButton];
 [[NSNotificationCenter defaultCenter] postNotificationName:DID_CHANGE_TRACKED_EVENT object:nil];
}
@end
