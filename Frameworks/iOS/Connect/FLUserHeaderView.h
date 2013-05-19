//
//  FLUserHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLLabel.h"

@class FLUserHeaderView;

@interface FLUserHeaderView : UIView {
@private
	UIImageView* _thumbnail;
	FLLabel* _nameLabel;
	UIActivityIndicatorView* _spinner;
	UIImageView* _logo;
}
@property (readonly, retain, nonatomic) UIImageView* logoView;

@property (readonly, retain, nonatomic) UIImageView* thumbnailView;
@property (readonly, retain, nonatomic) FLLabel* nameLabel;

@property (readwrite, retain, nonatomic) NSString* name;
@property (readwrite, retain, nonatomic) UIImage* thumbnail;

- (void) startSpinner;
- (void) stopSpinner;

@end
