//
//  FLStatusWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLActionWidget.h"

#import "FLThumbnailWidget.h"
#import "FLLabelWidget.h"
#import "FLGradientWidget.h"

#import "FLTableView.h"

#import "FLTwoColumnWidget.h"

@interface FLStatusWidget : FLWidget<FLTableViewRowHeightCalculator> {
@private
	FLGradientWidget* m_gradient;
	FLLabelWidget* m_userName;
	FLLabelWidget* m_message;
	FLThumbnailWidget* m_thumbnail;
	FLLabelWidget* m_postedTime;
	FLWidget* m_rightColumn;
	FLWidget* m_nameAndPostDateWidget;
}

@property (readonly, retain, nonatomic) FLGradientWidget* gradientWidget;
@property (readonly, retain, nonatomic) FLLabelWidget* userNameWidget;
@property (readonly, retain, nonatomic) FLLabelWidget* messageWidget;
@property (readonly, retain, nonatomic) FLLabelWidget* postedTimeWidget;
@property (readonly, retain, nonatomic) FLThumbnailWidget* thumbnailWidget;

@end
