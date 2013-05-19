//
//  FLAuxiliaryView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLWidgetView.h"

@interface FLAuxiliaryView : FLWidgetView {
@private
    UIView* _containedView;
}
@property (readwrite, strong, nonatomic) UIView* containedView;
@end