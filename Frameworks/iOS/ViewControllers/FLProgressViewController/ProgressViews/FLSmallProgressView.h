//
//  FLSmallProgressView.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/11/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLLegacyProgressView.h"
#import "FLGradientView.h"

@interface FLSmallProgressView : FLLegacyProgressView {
@private
	FLGradientView* _gradientView;
}

+ (FLSmallProgressView*) smallProgressView;

@end
