//
//  FLFormViewController.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLEditController.h"

@interface FLFormViewController : FLViewController<FLEditControllerDelegate> {
@private
    FLEditController* _dataSource;
}

@property (readonly, strong, nonatomic) FLEditController* dataSource;

@end

@interface FLFormViewControllerDelegate <NSObject>

@end