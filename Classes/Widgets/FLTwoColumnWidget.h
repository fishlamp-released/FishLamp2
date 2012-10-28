//
//  FLTwoColumnWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"

@interface FLTwoColumnWidget : FLWidget {
@private
	FLWidget* _leftColumn;
	FLWidget* _rightColumn;
}

@property (readonly, retain, nonatomic) FLWidget* leftColumn;
@property (readonly, retain, nonatomic) FLWidget* rightColumn;

@end
