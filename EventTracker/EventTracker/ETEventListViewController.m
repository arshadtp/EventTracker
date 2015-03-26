//
//  ETEventListViewController.m
//  EventTracker
//
//  Created by Arshad T P on 3/22/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETEventListViewController.h"
#import "Event+ETEventHelper.h"
#import "ETEventCollectionView.h"
#import "UIViewController+ETNibLoading.h"
#import "ETEventDetailsViewController.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "ETTrackedEventMasterViewControllert.h"

@interface ETEventListViewController () {
	
	NSString *viewType;
	NSArray *events;
}

@end

@implementation ETEventListViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	//Fix to issue that navigation bar covers view in iOS 7.0.
	self.edgesForExtendedLayout = UIRectEdgeNone;

	viewType = EVENT_LIST_MENU_TYPE;
	// Load events from DB
	[Event fetchAllEventsWithCompletionBlock:^(NSArray *array, NSError *error) {
		events = array;
		[_menuCollectionView reloadData];
	}];
	// Do any additional setup after loading the view, typically from a nib.
	[self addMenuBarButton];
}


- (void) addMenuBarButton {
	
	UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
	[button addTarget:self action:@selector(changeMenuType) forControlEvents:UIControlEventTouchUpInside];
	if ([viewType isEqualToString:EVENT_LIST_MENU_TYPE]) {
		[button setTitle:EVENT_LIST_TABLE_TYPE forState:UIControlStateNormal];
	} else {
		[button setTitle:EVENT_LIST_MENU_TYPE forState:UIControlStateNormal];
	}
	[button setTintColor:[UIColor redColor]];
	button.frame = CGRectMake(0, 0, 60, 30);
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
	self.navigationItem.rightBarButtonItem = barButton;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Collection view delegate  methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	
	return events.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	ETEventCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ETEventCollectionView class]) forIndexPath:indexPath];
	Event *event = [events objectAtIndex:indexPath.row];

	[cell loadDataInView:event forMenuType:viewType];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	[self showEventWithDetails:[events objectAtIndex:indexPath.row]];
}

#define MENU_TYPE_CELL_SIZE CGSizeMake(200, 200)
#define LIST_TYPE_CELL_SIZE CGSizeMake(600, 200)

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([viewType isEqualToString:EVENT_LIST_MENU_TYPE]) {
		return MENU_TYPE_CELL_SIZE;
	} else
		return LIST_TYPE_CELL_SIZE;
}

#pragma mark - #

/**
 *  Change the list view type
 */
- (void) changeMenuType {
	if ([viewType isEqualToString:EVENT_LIST_MENU_TYPE]) {
		viewType = EVENT_LIST_TABLE_TYPE;
	} else {
		viewType = EVENT_LIST_MENU_TYPE;
	}
	
	[self.menuCollectionView performBatchUpdates:^{
		[self.menuCollectionView.collectionViewLayout invalidateLayout];
		[self.menuCollectionView setCollectionViewLayout:self.menuCollectionView.collectionViewLayout animated:YES];
	} completion:^(BOOL finished) {
		[self.menuCollectionView reloadData];
		[self addMenuBarButton];
	}];

}

- (void) showEventWithDetails:(Event *) eventDatails {
	
	ETEventDetailsViewController *vc = [ETEventDetailsViewController initWithViewControllerWithStoryBoardId:NSStringFromClass([ETEventDetailsViewController class])];
	vc.eventDetails = eventDatails;
	[self.navigationController pushViewController:vc animated:YES];

}


@end
