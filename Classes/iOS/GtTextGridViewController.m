//
//  GtTextGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextGridViewController.h"

#import "GtGridViewTextCell.h"

@implementation GtTextGridViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.viewLayout = GtReturnAutoreleased([[GtRowViewLayout alloc] init]);
        
        for(int i = 0; i < 500; i++)
        {
//            GtGridViewTextCell* cell = GtReturnAutoreleased([[GtGridViewTextCell alloc] init]);
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
