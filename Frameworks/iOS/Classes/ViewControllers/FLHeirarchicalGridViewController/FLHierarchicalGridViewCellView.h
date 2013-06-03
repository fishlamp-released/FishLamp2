//
//  FLHierarchicalGridViewCellView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWidgetView.h"
#import "FLGradientWidget.h"
#import "FLTableViewCellAccessoryWidget.h"
#import "FLLabelWidget.h"
#import "FLGridCellView.h"

@interface FLHierarchicalGridViewCellView : FLGridCellView {
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