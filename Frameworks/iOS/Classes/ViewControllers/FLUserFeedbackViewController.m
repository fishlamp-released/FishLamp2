//
//	FLBetaFeedbackEmail.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUserFeedbackViewController.h"
#import "FLEmailer.h"
#import "NSFileManager+FLExtras.h"
#import "FLBannerTableViewCell.h"
#import "FLOldUserNotificationView.h"
#import "FLAlert.h"

#import "FLButtonCell.h"
#import "FLGradientButton.h"
#import "FLButtons.h"

@implementation FLUserFeedbackViewController

@synthesize emailAddress = _emailAddress;
@synthesize stringArray = _stringArray;

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
	if((self = [self initWithNibName:DeviceIsPad() ? @"FLUserFeedbackViewController-iPad" : @"FLUserFeedbackViewController" bundle:nil]))
	{
	}
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		self.stringArray = [FLUserFeedbackViewController defaultStringArray];
		self.wantsFullScreenLayout = YES;
		self.title = NSLocalizedString(@"Send Feedback", nil);
	}
	return self;
}

+ (FLUserFeedbackViewController*) userFeedbackViewController:(NSString*) emailAddress buttonTitleArray:(NSArray*) buttonTitleArray
{
   FLUserFeedbackViewController* controller = FLAutorelease([[FLUserFeedbackViewController alloc] init]);
   controller.emailAddress = emailAddress;
   controller.stringArray = buttonTitleArray;
   return controller; 
}

- (void) dealloc
{
	FLReleaseWithNil(_stringArray);
	FLReleaseWithNil(_emailAddress);
	FLSuperDealloc();
}

- (void) onButtonClicked:(FLLegacyButton*) button
{
// TODO: this is hack. We're presenting this from a modal view controller, so we can't nest these.
    FLAutorelease(FLReturnRetain(self));

    [[FLViewController presentingModalViewController] dismissModalViewControllerAnimated:NO]; // this will dismiss us and our parents.


	FLEmailer* email = FLAutorelease([[FLEmailer alloc] init]_;
//	email.delegate = self;
	email.subject = button.titleLabel.text;
	email.toRecipients = [NSArray arrayWithObject:_emailAddress];
	
	FLPrettyString* builder = [FLPrettyString prettyString];
    
    // TODO: this is dumb - use FLHtmlStringBuilder????
    
//	[builder appendLineWithString:[_stringArray objectAtIndex:indexPath.row]];
//	[builder appendLineWithString:@"<br/><br/>"];
	[builder appendLine:NSLocalizedString(@"Details:<br/><br/><br/>", nil)];
	[builder appendFormat:(NSLocalizedString(@"Please do not delete the following info:<br/>[Product:%@]<br/>[Version:%@]<br/>", nil)), 
        [NSFileManager appName], 
        [NSFileManager appVersion]];
	[builder appendFormat:(NSLocalizedString(@"[Device:%@]<br/>", nil)), [UIDevice currentDevice].machineName];
	[builder appendFormat:(NSLocalizedString(@"[SystemName:%@]<br/>", nil)), [UIDevice currentDevice].systemName];
	[builder appendFormat:(NSLocalizedString(@"[SystemVersion:%@]<br/>", nil)), [UIDevice currentDevice].systemVersion];
	email.body = [builder buildString];
	
	[email composeEmail:(FLViewController*) [UIApplication visibleViewController]];
}

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder
{
	[builder addSection];
	[builder addCell: [FLBannerTableViewCell bannerTableCell:NSLocalizedString(@"Please choose a topic below to send an email to the team. Please fill out as much detail as you can. Only what you see in the email will be sent.", nil)]];
	
	[builder addSection];
	
	for(NSString* string in _stringArray)
	{
		[builder addSection].headerHeight = 5.0f;
	
		FLSmallButtonDeprecated* button = [FLSmallButtonDeprecated smallButton:string target:self action:@selector(onButtonClicked:)] ;
		button.frame = FLRectSetWidth(button.frame, 200);
	
		[builder addCell: [FLButtonCell buttonCell:button buttonMode:FLButtonCellButtonModeCenter]];
		[builder.cell sectionWidget].drawMode = FLTableViewCellSectionDrawModeNone;

	}
}					 
				
- (void) emailer:(FLEmailer *)controller 
	didFinishWithResult:(MFMailComposeResult)result 
				  error:(NSError *)error
{
	if(result == MFMailComposeResultFailed) {
		FLAlert* alert = [FLAlert alertViewController:NSLocalizedString(@"Sending email failed", nil)
                                                                          message:NSLocalizedString(@"Please check your email configuration and try again.",nil)];
        
        [alert addButton:[FLConfirmButton okButton]];
            
		[alert showViewControllerAnimated:YES];
		
	}
}



@end
