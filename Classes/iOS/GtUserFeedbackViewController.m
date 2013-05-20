//
//	GtBetaFeedbackEmail.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserFeedbackViewController.h"
#import "GtViewAnimator.h"

#import "GtEmailer.h"
#import "GtStringBuilder.h"
#import "NSFileManager+GtExtras.h"
#import "GtBannerTableViewCell.h"
#import "GtUserNotificationView.h"

#import "GtButtonCell.h"
#import "GtGradientButton.h"
#import "GtApplicationDelegate.h"

@implementation GtUserFeedbackViewController

@synthesize emailAddress = m_emailAddress;
@synthesize stringArray = m_stringArray;

#define kStringCount 2

+ (NSArray*) defaultStringArray
{
	return [NSArray arrayWithObjects:@"It'd be cool if...",
		@"It crashed when I did something specific",
		@"A specific feature could be improved if...",
		@"Something keeps randomly happening...",
		@"I love it!",
		@"I have a suggestion",
		@"I found a bug",
		@"Something I'm doing takes too long",
		nil];
}

- (id) init
{
	if((self = [self initWithNibName:DeviceIsPad() ? @"GtUserFeedbackViewController-iPad" : @"GtUserFeedbackViewController" bundle:nil]))
	{
	}
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		self.stringArray = [GtUserFeedbackViewController defaultStringArray];
		self.wantsFullScreenLayout = YES;
		self.title = NSLocalizedString(@"Send Feedback", nil);
	}
	return self;
}

+ (GtUserFeedbackViewController*) userFeedbackViewController:(NSString*) emailAddress buttonTitleArray:(NSArray*) buttonTitleArray
{
   GtUserFeedbackViewController* controller = GtReturnAutoreleased([[GtUserFeedbackViewController alloc] init]);
   controller.emailAddress = emailAddress;
   controller.stringArray = buttonTitleArray;
   return controller; 
}

- (void) dealloc
{
	GtReleaseWithNil(m_stringArray);
	GtReleaseWithNil(m_emailAddress);
	GtSuperDealloc();
}

- (void) onButtonClicked:(GtButton*) button
{
// TODO: this is hack. We're presenting this from a modal view controller, so we can't nest these.
    GtReturnAutoreleased(GtRetain(self));

    [[GtViewController presentingModalViewController] dismissModalViewControllerAnimated:NO]; // this will dismiss us and our parents.


	GtEmailer* email = [[GtEmailer alloc] init];
//	email.delegate = self;
	email.subject = button.titleLabel.text;
	email.toRecipients = [NSArray arrayWithObject:m_emailAddress];
	
	GtStringBuilder* builder = [[GtStringBuilder alloc] initWithPrettyPrint:NO];
	
//	[builder appendLine:[m_stringArray objectAtIndex:indexPath.row]];
//	[builder appendLine:@"<br/><br/>"];
	[builder appendLine:NSLocalizedString(@"Details:<br/><br/><br/>", nil)];
	[builder appendFormat:(NSLocalizedString(@"Please do not delete the following info:<br/>[Product:%@]<br/>[Version:%@]<br/>", nil)), 
        [NSFileManager appName], 
        [NSFileManager appVersion]];
	[builder appendFormat:(NSLocalizedString(@"[Device:%@]<br/>", nil)), [UIDevice currentDevice].machineName];
	[builder appendFormat:(NSLocalizedString(@"[SystemName:%@]<br/>", nil)), [UIDevice currentDevice].systemName];
	[builder appendFormat:(NSLocalizedString(@"[SystemVersion:%@]<br/>", nil)), [UIDevice currentDevice].systemVersion];
	email.body = [builder buildString];
	
	GtReleaseWithNil(builder);
	
	[email composeEmail:(GtViewController*) [[GtApplicationDelegate instance] defaultViewController]];
	
	GtReleaseWithNil(email);

}

- (GtViewContentsDescriptor) describeViewContents
{
	return GtViewContentsDescriptorMake(DeviceIsPad() ? GtViewContentItemNavigationBar : GtViewContentItemNavigationBarAndStatusBar, GtViewContentItemNone);
}

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{
	[builder addSection];
	[builder addCell: [GtBannerTableViewCell bannerTableCell:NSLocalizedString(@"Please choose a topic below to send an email to the team. Please fill out as much detail as you can. Only what you see in the email will be sent.", nil)]];
	
	[builder addSection];
	
	for(NSString* string in m_stringArray)
	{
		[builder addSection].headerHeight = 5.0f;
	
		GtSmallButton* button = [GtSmallButton smallButton:string target:self action:@selector(onButtonClicked:)] ;
		button.frame = GtRectSetWidth(button.frame, 200);
	
		[builder addCell: [GtButtonCell buttonCell:button buttonMode:GtButtonCellButtonModeCenter]];
		[builder.cell sectionWidget].drawMode = GtTableViewCellSectionDrawModeNone;

	}
}					 
				
- (void) emailer:(GtEmailer *)controller 
	didFinishWithResult:(MFMailComposeResult)result 
				  error:(NSError *)error
{
	if(result == MFMailComposeResultFailed)
	{
		UIAlertView* view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sending email failed", nil) 
			message:NSLocalizedString(@"Please check your email configuration and try again.",nil)
			delegate: nil
			cancelButtonTitle:nil
			otherButtonTitles:NSLocalizedString(@"OK", nil), nil] ;
        GtAutorelease(view);
		[view show];
		
	}
}



@end
