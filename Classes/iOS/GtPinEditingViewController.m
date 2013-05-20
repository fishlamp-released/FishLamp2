//
//	GtPinEditingController.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPinEditingViewController.h"
#import "GtPinEditingView.h"
#import "GtHoverViewController.h"


@implementation GtPinEditingViewController

@synthesize delegate = m_delegate;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil   
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        if(DeviceIsPad())
        {
            self.contentSizeForViewInHoverView = CGSizeMake(400, 400);
        }
        else
        {
            self.contentSizeForViewInHoverView = CGSizeMake(300, 300);
        }
    }
    
    return self;
}

- (GtPinEditingView*) pinEditingView
{
	return (GtPinEditingView*) self.view;
}

- (void)loadView
{
	GtPinEditingView* view = GtReturnAutoreleased([[GtPinEditingView alloc] initWithFrame:CGRectZero]);		   
	view.delegate = self;	 
	self.view = view;

}

- (void) setPinCheckMode:(NSString*) pinToCheck maxAttempts:(NSUInteger) maxAttempts
{
	[self.pinEditingView setPinCheckMode:pinToCheck maxAttempts:maxAttempts];
}

- (void) pinEditViewDidCancel:(GtPinEditingView*) pinEditingView
{
	GtReturnAutoreleased(GtRetain(self));
	[self.delegate pinEditViewControllerDidCancel:self];	
	[self dismissViewControllerAnimated:YES];
}

- (void) pinEditView:(GtPinEditingView*) pinEditingView didSetPin:(NSString*) pin
{
	GtReturnAutoreleased(GtRetain(self));
	if([self.delegate respondsToSelector:@selector(pinEditViewController:didSetPin:)])
	{
		[self.delegate pinEditViewController:self didSetPin:pin];	
	}
	[self dismissViewControllerAnimated:YES];
}

- (void) pinEditViewUserDidEnterCorrectPin:(GtPinEditingView*) pinEditingView
{
	GtReturnAutoreleased(GtRetain(self));
	if([self.delegate respondsToSelector:@selector(pinEditViewControllerUserDidEnterCorrectPin:)])
	{
		[self.delegate pinEditViewControllerUserDidEnterCorrectPin:self];	
	}
	[self dismissViewControllerAnimated:YES];
}

- (void) wasPushedOnNavigationController:(UINavigationController *)controller
{
	[controller setNavigationBarHidden:YES animated:NO];
}

@end

