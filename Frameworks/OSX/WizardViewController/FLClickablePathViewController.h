//
//  FLClickablePathViewController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol FLClickablePathViewControllerDelegate;

@interface FLClickablePathViewController : NSViewController {
@private 
    id<FLClickablePathViewControllerDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) IBOutlet id<FLClickablePathViewControllerDelegate> delegate;

@end

@protocol FLClickablePathViewControllerDelegate <NSObject>

@end