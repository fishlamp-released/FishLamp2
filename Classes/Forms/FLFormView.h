//
//  FLFormView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLArrangeableView.h"
#import "FLEditController.h"

@interface FLFormView : FLArrangeableView<FLEditControllerDelegate> {
@private
    FLEditController* _editController;
}

@property (readonly, strong, nonatomic) FLEditController* editController;

@end
