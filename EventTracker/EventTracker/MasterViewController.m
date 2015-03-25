//
//  MasterViewController.m
//  EventTracker
//
//  Created by Arshad T P on 3/22/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ETLoginManager.h"
#import "User+EYUserHelper.h"
#import "ETCurrentUserSharedManager.h"
#import "Constants.h"
#import "ETLoginManager.h"
#import "ETEventDetailViewController.h"
#import "UIViewController+ETNibLoading.h"
#import "DetailViewController.h"

@interface MasterViewController () {
	NS_ENUM(NSInteger, SectionType){
		All_Events,
		Tracked_Events
	};
	NSMutableArray *trackeEvents;
}

@end

@implementation MasterViewController

- (void)awakeFromNib {
	[super awakeFromNib];
	self.clearsSelectionOnViewWillAppear = NO;
	self.preferredContentSize = CGSizeMake(320.0, 600.0);
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[ETLoginManager registerForUserLoginNotifcationWithObserver:self withSelector:@selector(userDidLogin)];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
//	self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
	[ETLoginManager showUserNameAlert];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self loadTrackedEvents];
	[ETCurrentUserSharedManager registerForTrackedEventChangedNotifcationWithObserver:self withSelector:@selector(loadTrackedEvents)];
}

- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[ETCurrentUserSharedManager removeTrackedEventChangedNotifcationObserver:self];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void) dealloc {
	[ETLoginManager removeForUserLoginNotifcationObserver:self];
}
- (void) userDidLogin {
	[self loadTrackedEvents];
}

- (void) loadTrackedEvents {
	
	trackeEvents = [[ETCurrentUserSharedManager sharedManager] trackedEvents];
	[self.tableView reloadData];

}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == All_Events) {
		return 1;
	}
	return  [trackeEvents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	if (indexPath.section == All_Events) {
		cell.textLabel.text = @"All Events";
	} else {
		[self configureCell:cell atIndexPath:indexPath];
	}
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == All_Events) {
		return NO;
	}
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[trackeEvents removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		[[ETCurrentUserSharedManager sharedManager] updateUserTrackedEventToDB];
	}
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == All_Events) {
		DetailViewController *vc = [DetailViewController initWithViewControllerWithStoryBoardId:NSStringFromClass([DetailViewController class])];
		UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
		[self.splitViewController showDetailViewController:nvc sender:self];

	} else {
		ETEventDetailViewController *vc = [ETEventDetailViewController initWithViewControllerWithStoryBoardId:NSStringFromClass([ETEventDetailViewController class])];
		vc.eventDetails = [trackeEvents objectAtIndex:indexPath.row];
		UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
		[self.splitViewController showDetailViewController:nvc sender:self];

	}
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == All_Events) {
		return UITableViewCellEditingStyleNone;
	}

	return UITableViewCellEditingStyleDelete;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == All_Events) {
		return NO;
	}

	if (indexPath.row == [trackeEvents count]) {
		return NO;
	}
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	Event *item = [trackeEvents objectAtIndex:fromIndexPath.row];
	[trackeEvents removeObjectAtIndex:fromIndexPath.row];
	[trackeEvents insertObject:item atIndex:toIndexPath.row];
	[[ETCurrentUserSharedManager sharedManager] updateUserTrackedEventToDB];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
	if ([proposedDestinationIndexPath row] < [trackeEvents count]) {
		return proposedDestinationIndexPath;
	}
	NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[trackeEvents count]-1 inSection:0];
	return betterIndexPath;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	if (trackeEvents && indexPath.row < trackeEvents.count)  {
		Event *event = [trackeEvents objectAtIndex:indexPath.row];
		cell.textLabel.text = event.eventName;

	}
}


@end
