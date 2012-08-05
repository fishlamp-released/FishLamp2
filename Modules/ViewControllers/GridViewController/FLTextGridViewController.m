//
//  FLTextGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/19/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTextGridViewController.h"

#import "FLGridViewTextCell.h"
#import "FLSingleColumnRowArrangement.h"

@implementation FLTextGridViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.cellArrangement = FLReturnAutoreleased([[FLSingleColumnRowArrangement alloc] init]);
        
        for(int i = 0; i < 500; i++)
        {
//            FLGridViewTextCell* cell = FLReturnAutoreleased([[FLGridViewTextCell alloc] init]);
//            cell.text = [NSString stringWithFormat:@"Line #%d", i];
//            [self.cellManager addCell:cell];
        }
    }
    
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

}


@end
