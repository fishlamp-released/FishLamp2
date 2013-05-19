//
//  FLErrorAlert.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLErrorAlert.h"
#import "FLLabelWidget.h"
#import "FLColorRange.h"

@implementation FLErrorAlert

+ (FLErrorAlert*) errorAlertViewController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.alertView setCornerTriangleWithColorRange:[FLColorRange redGradientColorRange] inCorner:FLTriangleCornerUpperRight];
    
// TODO(MF): unhardcode the triangle business.    
    
    FLLabelWidget* label = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,2,16,14)];
    [self.alertView.cornerTriangle addWidget:label];
    label.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalRight, FLRectLayoutVerticalNone);
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
