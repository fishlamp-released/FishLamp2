
@interface FLGridCell (Internal)
// internal
- (void) cellWillAppearInSuperview:(UIView*) superview 
                    viewController:(FLGridViewController*) controller;
                               
- (void) cellDidDisappearFromSuperview:(UIView*) superview  
                        viewController:(FLGridViewController*) controller;

@end
