//
//  ETImageView.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loadImageSuccessBlock)(UIImage *image, NSError *error);

@interface ETImageView : UIImageView

- (void)loadImageForUrl:(NSString *)urlString withSuccessBlock:(loadImageSuccessBlock) successBlock;
@end
