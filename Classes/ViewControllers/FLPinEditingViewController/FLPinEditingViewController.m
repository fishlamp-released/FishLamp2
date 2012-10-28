//
//	FLPinEditingController.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLPinEditingViewController.h"
#import "FLPinEditingView.h"
#import "FLFloatingViewController.h"


@implementation FLPinEditingViewController

@synthesize delegate = _delegate;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil   
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        if(DeviceIsPad())
        {
            self.contentSizeForViewInFloatingView = FLSizeMake(400, 400);
        }
        else
        {
            self.contentSizeForViewInFloatingView = FLSizeMake(300, 300);
        }
    }
    
    return self;
}

- (FLPinEditingView*) pinEditingView
{
	return (FLPinEditingView*) self.view;
}

- (void)loadView
{
	FLPinEditingView* view = FLReturnAutoreleased([[FLPinEditingView alloc] initWithFrame:CGRectZero]);		   
	view.delegate = self;	 
	self.view = view;

}

- (void) setPinCheckMode:(NSString*) pinToCheck maxAttempts:(NSUInteger) maxAttempts
{
	[self.pinEditingView setPinCheckMode:pinToCheck maxAttempts:maxAttempts];
}

- (void) pinEditViewDidCancel:(FLPinEditingView*) pinEditingView
{
	FLAutorelease(FLReturnRetain(self));
	[self.delegate pinEditViewControllerDidCancel:self];	
	[self dismissViewControllerAnimated:YES];
}

- (void) pinEditView:(FLPinEditingView*) pinEditingView didSetPin:(NSString*) pin
{
	FLAutorelease(FLReturnRetain(self));
	if([self.delegate respondsToSelector:@selector(pinEditViewController:didSetPin:)])
	{
		[self.delegate pinEditViewController:self didSetPin:pin];	
	}
	[self dismissViewControllerAnimated:YES];
}

- (void) pinEditViewUserDidEnterCorrectPin:(FLPinEditingView*) pinEditingView
{
	FLAutorelease(FLReturnRetain(self));
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

