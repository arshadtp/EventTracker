//
//  ETEventCollectionView.h
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ETImageView.h"

@interface ETEventCollectionView : UICollectionViewCell

@property (nonatomic, weak) IBOutlet ETImageView *eventImageView;
@property (nonatomic, weak) IBOutlet UILabel *eventNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *placeLabel;
@property (nonatomic, weak) IBOutlet UILabel *eventTypeLabel;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *widthSpaceContraint;

- (void) configure:(NSString *) type;
@end
