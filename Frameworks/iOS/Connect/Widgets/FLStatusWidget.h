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
	FLGradientWidget* _gradient;
	FLLabelWidget* _userName;
	FLLabelWidget* _message;
	FLThumbnailWidget* _thumbnail;
	FLLabelWidget* _postedTime;
//	FLWidget* _rightColumn;
//	FLWidget* _nameAndPostDateWidget;
}

@property (readonly, retain, nonatomic) FLGradientWidget* gradientWidget;
@property (readonly, retain, nonatomic) FLLabelWidget* userNameWidget;
@property (readonly, retain, nonatomic) FLLabelWidget* messageWidget;
@property (readonly, retain, nonatomic) FLLabelWidget* postedTimeWidget;
@property (readonly, retain, nonatomic) FLThumbnailWidget* thumbnailWidget;

@end
