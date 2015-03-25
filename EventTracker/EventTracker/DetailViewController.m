//
//  DetailViewController.m
//  EventTracker
//
//  Created by Arshad T P on 3/22/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "DetailViewController.h"
#import "Event+ETEventHelper.h"
#import "ETEventCollectionView.h"
#import "UIViewController+ETNibLoading.h"
#import "ETEventDetailViewController.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "MasterViewController.h"

@interface DetailViewController () {
	
	NSString *viewType;
	NSArray *events;
}

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
	if (_detailItem != newDetailItem) {
	    _detailItem = newDetailItem;
	        
	    // Update the view.
	    [self configureView];
	}
}

- (void)configureView {
	// Update the user interface for the detail item.
	if (self.detailItem) {
	    self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	//Fix to issue that navigation bar covers view in iOS 7.0.
	self.edgesForExtendedLayout = UIRectEdgeNone;

	viewType = EVENT_LIST_MENU_TYPE;
	[Event fetchAllEventsWithCompletionBlock:^(NSArray *array, NSError *error) {
		events = array;
		[_menuCollectionView reloadData];
	}];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureView];
//	vc.didSelectEvent = ^(Event *eventDetails) {
//		[self showEventWithDetails:eventDetails];
//	};
//	MasterViewController *controller = (MasterViewController *)masterNavigationController.topViewController;
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
		[button setTitle:viewType forState:UIControlStateNormal];
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
	NSLog(@"======%@",event.eventName);
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	[self showEventWithDetails:[events objectAtIndex:indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([viewType isEqualToString:EVENT_LIST_MENU_TYPE]) {
		return CGSizeMake(200, 200);
	} else
		return CGSizeMake(600, 200);
}

#pragma mark - #


- (IBAction)changeMenuTypeButtonAction:(id)sender {
	
	
	[self changeMenuType];
//	[_menuCollectionView reloadData];
}
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
	
	ETEventDetailViewController *vc = [ETEventDetailViewController initWithViewControllerWithStoryBoardId:NSStringFromClass([ETEventDetailViewController class])];
	vc.eventDetails = eventDatails;
	[self.navigationController pushViewController:vc animated:YES];

}
@end
