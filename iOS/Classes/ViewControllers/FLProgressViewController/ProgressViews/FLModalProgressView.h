//
//	FLModalProgressView.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLLegacyProgressView.h"
#import "FLGradientWidget.h"

@interface FLModalProgressView : FLLegacyProgressView {
@private
	FLGradientWidget* _gradientView;
}

+ (FLModalProgressView*) modalProgressView;

@end

