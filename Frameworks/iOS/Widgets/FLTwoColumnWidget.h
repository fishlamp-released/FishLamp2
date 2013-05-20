//
//  FLTwoColumnWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
