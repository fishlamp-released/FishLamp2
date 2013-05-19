//
//  FLFormView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
