//
//  UIViewController+ETNibLoading.h
//  EventTracker
//
//  Created by Arshad T P on 3/26/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ETNibLoading)

+ (id) initWithViewControllerWithStoryBoardId:(NSString *)storyBoardIdentifier;
@end
