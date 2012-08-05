//
//  FLFormViewRow.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLArrangeableView.h"
#import "FLEditController.h"

@interface FLFormElementView : FLArrangeableView {
@private
}
@property (readwrite, strong, nonatomic) NSString* dataKey;
@property (readwrite, strong, nonatomic) FLEditController* editController;
@end


