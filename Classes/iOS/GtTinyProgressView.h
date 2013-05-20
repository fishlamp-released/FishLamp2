//
//  GtBackgroundProgressView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtProgressProtocol.h"
#import "GtProgressView.h"

@interface GtTinyProgressView : GtProgressView {
@private
	CGFloat m_amountWritten;
	CGFloat m_totalAmount;
	UIView* m_progressView;
	UIView* m_backgroundView;
}

- (id) init;
+ (GtTinyProgressView*) tinyProgressView;

@end
