//
//  FLBackgroundProgressView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLLegacyProgressView.h"

@interface FLTinyProgressView : FLLegacyProgressView {
@private
	CGFloat _amountWritten;
	CGFloat _totalAmount;
	UIView* _progressView;
	UIView* _backgroundView;
}

- (id) init;
+ (FLTinyProgressView*) tinyProgressView;

@end
