//
//  GtGridViewCellHighlightTouchHandler.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/9/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGridViewCellHighlightTouchHandler.h"
#import "GtGridViewCellController.h"

@implementation GtGridViewCellHighlightTouchHandler

GtSynthesizeSingleton(GtGridViewCellHighlightTouchHandler);

- (void)touchesBeganInGridViewCell:(GtGridViewCellController*) cell
                        superview:(UIView*) superview 
                        touches:(NSSet *)touches 
                      withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:superview];
    cell.highlighted = [cell touchPointSelectsCell:loc];
}                   
        
- (void)touchesMovedInGridViewCell:(GtGridViewCellController*) cell
                        superview:(UIView*) superview 
                        touches:(NSSet *)touches 
                      withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:superview];
    cell.highlighted = [cell touchPointSelectsCell:loc];
}
        
- (void)touchesEndedInGridViewCell:(GtGridViewCellController*) cell
                         superview:(UIView*) superview 
                           touches:(NSSet *)touches 
                         withEvent:(UIEvent *)event
{

    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:superview];
    cell.highlighted = NO;

    if([cell touchPointSelectsCell:loc])
    {
        [self performBlockOnMainThread:^{
            cell.selected = YES;
            [cell.selectionHandler gridViewCellWasSelected:cell];
            }];
    }
}
        
- (void)touchesCancelledInGridViewCell:(GtGridViewCellController*) cell
                        superview:(UIView*) superview 
                        touches:(NSSet *)touches 
                      withEvent:(UIEvent *)event
{
    cell.highlighted = NO;
}



@end
