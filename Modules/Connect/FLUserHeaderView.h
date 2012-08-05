//
//  FLUserHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLLabel.h"

@class FLUserHeaderView;

@interface FLUserHeaderView : UIView {
@private
	UIImageView* m_thumbnail;
	FLLabel* m_nameLabel;
	UIActivityIndicatorView* m_spinner;
	UIImageView* m_logo;
}
@property (readonly, retain, nonatomic) UIImageView* logoView;

@property (readonly, retain, nonatomic) UIImageView* thumbnailView;
@property (readonly, retain, nonatomic) FLLabel* nameLabel;

@property (readwrite, retain, nonatomic) NSString* name;
@property (readwrite, retain, nonatomic) UIImage* thumbnail;

- (void) startSpinner;
- (void) stopSpinner;

@end
