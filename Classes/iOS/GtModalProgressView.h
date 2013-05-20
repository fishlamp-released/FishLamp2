//
//	GtModalProgressView.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtProgressView.h"
#import "GtGradientWidget.h"
#import "GtGradientView.h"
#import "GtAction.h"

@interface GtModalProgressView : GtProgressView{
	GtGradientWidget* m_gradientView;
}

+ (GtModalProgressView*) modalProgressView;

@end

