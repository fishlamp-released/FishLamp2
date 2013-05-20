//
//  GtProgressViewController.m
//  FishLamp2
//
//  Created by Mike Fullerton on 5/17/13.
//
//

#import "GtProgressViewController.h"

#define ForwardProperty(getter, setter, type) \
    - (type) getter { return [self.progressView getter]; } \
    - (void) setter:(type) value { [self.progressView setter:value]; } 

@implementation GtProgressViewController



- (UIView<GtProgressProtocol>*) progressView {
    return (UIView<GtProgressProtocol>*) self.view;
}

- (id) initWithProgressView:(UIView<GtProgressProtocol>*) view {
    self.themeAction = @selector(applyThemeToProgressViewController:);
    return [super initWithView:view];
}
+ (id) progressViewController:(UIView<GtProgressProtocol>*) view {

    return [[[[self class] alloc] initWithView:view] autorelease];
}

ForwardProperty(title, setTitle, NSString*)
ForwardProperty(secondaryText, setSecondaryText, NSString*)
ForwardProperty(progressBarText, setProgressBarText, NSString*)
ForwardProperty(buttonTitle, setButtonTitle, NSString*)
ForwardProperty(startDelay, setStartDelay, NSTimeInterval)

- (void) setButtonTarget:(id)target 
                  action:(SEL) action
                isCancel:(BOOL) isCancel {
    [self.progressView setButtonTarget:target action:action isCancel:isCancel];
}                

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount {
    [self.progressView updateProgress:amountWritten totalAmount:totalAmount];
}            

- (void) setProgressViewAlpha:(float) alpha {
    [self.progressView setProgressViewAlpha:alpha];
}

- (void) showProgressInSuperview:(UIView*) superview {
}

- (void) showProgressInViewController:(UIViewController*) viewController {
}

- (void) showProgress
{
	[[GtNotificationDisplayManager defaultDisplayManager] showProgress:self];
}

- (void) hideProgress {
	[self.progressView hideProgress]; 
}


@end
