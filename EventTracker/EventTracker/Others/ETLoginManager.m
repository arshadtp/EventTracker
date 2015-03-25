//
//  ETLoginManager.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETLoginManager.h"
#import "User+EYUserHelper.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "ETUserDefault.h"

static NSString *const USER_LOGGED_IN_NOTIFICATION = @"user login";

@implementation ETLoginManager

+ (void) showUserNameAlert {
	
	UIAlertController *alertController = [UIAlertController
                    alertControllerWithTitle:NSLocalizedString(@"Event Tracker", nil)
																				message:@"Please enter you username"
																				preferredStyle:UIAlertControllerStyleAlert];
	
	[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
	 {
   textField.placeholder = NSLocalizedString(@"Username", nil);
	 }];
	UIAlertAction *okAction = [UIAlertAction
														 actionWithTitle:NSLocalizedString(@"OK", @"OK action")
														 style:UIAlertActionStyleDefault
														 handler:^(UIAlertAction *action)
														 {
															 UITextField *login = alertController.textFields.firstObject;
															 if (!login.text || login.text.length == 0) {
																 [APP_DELEGATE.window.rootViewController presentViewController:alertController animated:YES completion:nil];
																 
															 } else {
																 User *user = [User createNewInstance];
																 user.name = login.text;
																 [User checkAndAddUserWithName:user withCompletionBlock:^(NSError *error) {
																	 [ETUserDefault setCurrentUser:login.text];
																	 [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOGGED_IN_NOTIFICATION object:nil];
																 }];
																 
															 }
														 }];
	[alertController addAction:okAction];
	[APP_DELEGATE.window.rootViewController presentViewController:alertController animated:YES completion:nil];
	
}

+ (void) registerForUserLoginNotifcationWithObserver:(id) observer withSelector:(SEL) selector {
	[[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:USER_LOGGED_IN_NOTIFICATION object:nil];
}

+ (void)  removeForUserLoginNotifcationObserver:(id) observer {
	[[NSNotificationCenter defaultCenter] removeObserver:observer name:USER_LOGGED_IN_NOTIFICATION object:nil];
}
@end
