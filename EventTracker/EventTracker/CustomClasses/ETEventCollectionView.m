//
//  ETEventCollectionView.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETEventCollectionView.h"

@implementation ETEventCollectionView

- (void) loadDataInView:(Event *) eventDetails {
	
	[_eventImageView loadImageForUrl:eventDetails.eventThumbNailURL withSuccessBlock:^(UIImage *image, NSError *error) {
		if (error) {
			_eventImageView.image = image;
		}
	}];
	_eventNameLabel.text = eventDetails.eventName;
	_eventTypeLabel.text = eventDetails.eventType;
	_placeLabel.text = eventDetails.place;
}
@end
