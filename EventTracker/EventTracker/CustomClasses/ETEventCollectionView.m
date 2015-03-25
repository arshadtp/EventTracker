//
//  ETEventCollectionView.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETEventCollectionView.h"

@implementation ETEventCollectionView

- (void) configure:(NSString *) type {
	
	if ([type isEqualToString:@"menu"]) {
		_widthSpaceContraint.constant = 150;

	} else {
		_widthSpaceContraint.constant = 350;

	}
	[self layoutIfNeeded];
	
}
@end
