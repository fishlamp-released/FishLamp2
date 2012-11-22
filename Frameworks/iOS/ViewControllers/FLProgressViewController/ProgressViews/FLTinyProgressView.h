//
//  FLBackgroundProgressView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
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
