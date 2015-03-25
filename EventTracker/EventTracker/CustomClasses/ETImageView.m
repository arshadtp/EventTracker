//
//  ETImageView.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETImageView.h"

@implementation ETImageView

- (void)loadImageForUrl:(NSString *)urlString withSuccessBlock:(loadImageSuccessBlock) successBlock {
	
	if (urlString) {
		NSURL *url = [NSURL URLWithString:urlString];
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
		[NSURLConnection sendAsynchronousRequest:request
																			 queue:[NSOperationQueue mainQueue]
													 completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
														 if ( !error )
														 {
															 UIImage *image = [[UIImage alloc] initWithData:data];
															 if (image) {
																 [self setImage:image];
															 }
															 successBlock(image,error);
														 }
														 successBlock(nil,error);
														 
													 }];
	}
	successBlock(nil,nil);
}


@end
