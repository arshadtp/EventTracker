//
//  UIViewController+ETNibLoading.m
//  EventTracker
//
//  Created by Arshad T P on 3/26/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "UIViewController+ETNibLoading.h"

@implementation UIViewController (ETNibLoading)

+ (id) initWithViewControllerWithStoryBoardId:(NSString *)storyBoardIdentifier {
	
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:storyBoardIdentifier];
	return vc;
}
@end
