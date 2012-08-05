//
//  FLErrorAlertViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLErrorAlertViewController.h"
#import "FLLabelWidget.h"

@implementation FLErrorAlertViewController



+ (FLErrorAlertViewController*) errorAlertViewController {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.alertView setCornerTriangleWithColorRange:[FLColorRange redGradientColorRange] inCorner:FLTriangleCornerUpperRight];
    
// TODO(MF): unhardcode the triangle business.    
    
    FLLabelWidget* label = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,2,16,14)];
    [self.alertView.cornerTriangle addWidget:label];
    label.contentMode = FLContentModeMake(FLContentModeHorizontalRight, FLContentModeVerticalNone);
    label.text = @"!";
    label.textAlignment = UITextAlignmentLeft;

    FLTextDescriptor* textDescriptor = [FLTextDescriptor textDescriptor];
    textDescriptor.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    textDescriptor.enabledColor = [UIColor grayColor];
    textDescriptor.enabledShadowColor = [UIColor blackColor];
    textDescriptor.shadowOffset = CGSizeMake(0,1);
    label.textDescriptor = textDescriptor;

    FLRelease(label);
}

@end
