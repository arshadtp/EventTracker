//
//  ETEventCollectionView.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETEventCollectionView.h"
#import "Constants.h"


@implementation ETEventCollectionView

- (void) loadDataInView:(Event *) eventDetails forMenuType:(NSString *)menuType {
	
	[_eventImageView loadImageForUrl:eventDetails.eventThumbNailURL withSuccessBlock:^(UIImage *image, NSError *error) {
		if (error) {
			_eventImageView.image = image;
		}
	}];
	_eventNameLabel.text = eventDetails.eventName;
	_eventTypeLabel.text = eventDetails.eventType;
	_placeLabel.text = eventDetails.place;

	if ([menuType isEqualToString:EVENT_LIST_MENU_TYPE]) {
		_eventTypeLabel.hidden = YES;
		_placeLabel.hidden = YES;
		_widthConttraint.constant = 160;

	} else {
		_eventTypeLabel.hidden = NO;
		_placeLabel.hidden = NO;
		_widthConttraint.constant = 380;

	}
	[self layoutIfNeeded];
}
@end
