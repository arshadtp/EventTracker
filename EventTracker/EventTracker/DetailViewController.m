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
	
	viewType = @"menu";
	[Event fetchAllEventsWithCompletionBlock:^(NSArray *array, NSError *error) {
		events = array;
		[_menuCollectionView reloadData];
	}];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureView];
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
	if (indexPath.row % 2 == 0) {
		cell.backgroundColor = [UIColor redColor];
	} else {
		cell.backgroundColor = [UIColor greenColor];
	}
	[cell configure:viewType];
	Event *event = [events objectAtIndex:indexPath.row];
	NSLog(@"======%@",event.eventName);
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([viewType isEqualToString:@"menu"]) {
		return CGSizeMake(200, 200);
	} else
		return CGSizeMake(500, 200);
}

#pragma mark - #


- (IBAction)changeMenuTypeButtonAction:(id)sender {
	
	
	if ([viewType isEqualToString:@"menu"]) {
		viewType = @"table";
	} else {
		viewType = @"menu";
	}
	
	[self.menuCollectionView performBatchUpdates:^{
		[self.menuCollectionView.collectionViewLayout invalidateLayout];
		[self.menuCollectionView setCollectionViewLayout:self.menuCollectionView.collectionViewLayout animated:YES];
	} completion:^(BOOL finished) {
//		[self.menuCollectionView reloadData];
	}];

//	[_menuCollectionView reloadData];
}
@end
