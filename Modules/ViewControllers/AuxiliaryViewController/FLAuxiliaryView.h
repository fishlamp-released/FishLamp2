//
//  FLAuxiliaryView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidgetView.h"

@interface FLAuxiliaryView : FLWidgetView {
@private
    UIView* _containedView;
}
@property (readwrite, strong, nonatomic) UIView* containedView;
@end