//
//	FLModalProgressView.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/26/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

