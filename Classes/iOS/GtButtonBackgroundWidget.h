//
//	GtButtonBackgroundWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"
#import "GtGradientWidget.h"

@interface GtButtonBackgroundWidget : GtWidget {
@private
	GtGradientWidget* m_topGradient;
	GtGradientWidget* m_bottomGradient;
}

@property (readwrite, assign, nonatomic) CGFloat alpha;

+ (GtButtonBackgroundWidget*) buttonBackgroundWidget;

@property (readwrite, retain, nonatomic) GtGradientWidget* topGradient;
@property (readwrite, retain, nonatomic) GtGradientWidget* bottomGradient;

@end
