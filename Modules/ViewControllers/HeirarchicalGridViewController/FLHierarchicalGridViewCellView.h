//
//  FLHierarchicalGridViewCellView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLWidgetView.h"
#import "FLGradientWidget.h"
#import "FLTableViewCellAccessoryWidget.h"
#import "FLLabelWidget.h"
#import "FLGriddableView.h"

@interface FLHierarchicalGridViewCellView : FLGriddableView {
@private
    FLGradientWidget* _gradient1;
    FLGradientWidget* _gradient2;
    FLGradientWidget* _selectedGradient;
    FLTableViewCellAccessoryWidget* _disclosureWidget;
    FLLabelWidget* _label;
    BOOL _disclosureButtonOnLeft;
}

@property (readwrite, assign, nonatomic) BOOL disclosureButtonHidden;
@property (readwrite, assign, nonatomic) BOOL disclosureButtonOnLeft;

@property (readonly, retain, nonatomic) FLLabelWidget* titleWidget;
@property (readonly, retain, nonatomic) FLGradientWidget* titleGradient;
@property (readonly, retain, nonatomic) FLGradientWidget* buttonGradient;
@property (readonly, retain, nonatomic) FLGradientWidget* selectedGradient;
@property (readonly, retain, nonatomic) FLTableViewCellAccessoryWidget* disclosureWidget;

@end