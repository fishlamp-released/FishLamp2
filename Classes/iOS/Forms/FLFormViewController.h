//
//  FLFormViewController.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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