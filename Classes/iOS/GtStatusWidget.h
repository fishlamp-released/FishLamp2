//
//  GtStatusWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtActionWidget.h"

#import "GtThumbnailWidget.h"
#import "GtLabelWidget.h"
#import "GtGradientWidget.h"

#import "GtTableView.h"

#import "GtTwoColumnWidget.h"

@interface GtStatusWidget : GtWidget<GtTableViewRowHeightCalculator> {
@private
	GtGradientWidget* m_gradient;
	GtLabelWidget* m_userName;
	GtLabelWidget* m_message;
	GtThumbnailWidget* m_thumbnail;
	GtLabelWidget* m_postedTime;
	GtWidget* m_rightColumn;
	GtWidget* m_nameAndPostDateWidget;
}

@property (readonly, retain, nonatomic) GtGradientWidget* gradientWidget;
@property (readonly, retain, nonatomic) GtLabelWidget* userNameWidget;
@property (readonly, retain, nonatomic) GtLabelWidget* messageWidget;
@property (readonly, retain, nonatomic) GtLabelWidget* postedTimeWidget;
@property (readonly, retain, nonatomic) GtThumbnailWidget* thumbnailWidget;

@end
