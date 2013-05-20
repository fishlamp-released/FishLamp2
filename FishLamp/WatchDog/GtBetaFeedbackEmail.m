//
//  GtBetaFeedbackEmail.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtBetaFeedbackEmail.h"
#import "GtViewAnimator.h"
#import "GtColors.h"
#import "GtEmailer.h"
#import "GtStringBuilder.h"
#import "GtFileUtilities.h"
#import "GtDevice.h"

@implementation GtBetaFeedbackEmail

@synthesize emailAddress = m_emailAddress;

GtSynthesizeString(emailAddress, setEmailAddress);
GtSynthesize(stringArray, setStringArray, NSArray, m_stringArray);
GtSynthesizeIDWithProtocol(viewAnimator, setViewAnimator, GtViewAnimatorProtocol);
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
    if(self = [self initWithNibName:@"GtBetaFeedback" bundle:nil])
    {
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		[self retain]; // releases self when dismissed
        self.title = @"Beta feedback";
        self.stringArray = [GtBetaFeedbackEmail defaultStringArray];
        self.viewAnimator = [GtDefaultViewAnimator defaultViewAnimator];
	}
	return self;
}

- (void) dealloc
{
    GtRelease(m_stringArray);
    GtRelease(m_titleLabel);
	GtRelease(m_emailAddress);
    GtRelease(m_tableView);
    GtRelease(m_toolbar);
    GtRelease(m_viewAnimator);
	[super dealloc];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    m_tableView.backgroundColor = [UIColor whiteColor];
    
    switch([[UIApplication sharedApplication] statusBarStyle])
    {
         case UIStatusBarStyleDefault:
            m_toolbar.barStyle = UIBarStyleDefault;
            break;
         case UIStatusBarStyleBlackTranslucent:
            m_toolbar.barStyle = UIBarStyleBlack;
            break;
         case UIStatusBarStyleBlackOpaque:
            m_toolbar.barStyle = UIBarStyleBlack;
            break;
    }
}


- (void) setViewTitle:(NSString*) title
{
    m_titleLabel.text = title;
}

- (NSString*) viewTitle
{
    return m_titleLabel.text;
}

- (NSInteger)tableView:(UITableView *)table 
    numberOfRowsInSection:(NSInteger)section
{
	return m_stringArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[GtAlloc(UITableViewCell) initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.textLabel.font = [UIFont standardLabelFont];
	cell.textLabel.text = [m_stringArray objectAtIndex:indexPath.row];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (void) emailer:(GtEmailer *)controller 
	didFinishWithResult:(MFMailComposeResult)result 
	              error:(NSError *)error
{
    [controller dismiss];
	[m_viewAnimator removeFromSuperview:self.view];
	[self autorelease];
}

- (void)tableView:(UITableView *)tableView 
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	GtEmailer* email = [GtAlloc(GtEmailer) init];
	email.delegate = self;
	email.subject = [m_stringArray objectAtIndex:indexPath.row]; //self.viewTitle;
	email.toRecipients = [NSArray arrayWithObject:m_emailAddress];
	
	GtStringBuilder* builder = [GtAlloc(GtStringBuilder) initWithPrettyPrint:NO];
	
//	[builder appendLine:[m_stringArray objectAtIndex:indexPath.row]];
//	[builder appendLine:@"<br/><br/>"];
	[builder appendLine:@"Details:<br/><br/><br/>"];
	[builder appendFormat:@"Please do not delete the following info:<br/>[Product:%@]<br/>[Version:%@]<br/>", [GtFileUtilities appName], [GtFileUtilities appVersion]];
	[builder appendFormat:@"[Device:%@]<br/>", [UIDevice currentDevice].machineName];
	[builder appendFormat:@"[SystemName:%@]<br/>", [UIDevice currentDevice].systemName];
	[builder appendFormat:@"[SystemVersion:%@]<br/>", [UIDevice currentDevice].systemVersion];
	email.body = [builder toString];
	
	GtRelease(builder);
	
	[email composeEmail:self];
	
	GtRelease(email);
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (IBAction) cancelTap:(id) sender
{
	[m_viewAnimator removeFromSuperview:self.view];
	[self autorelease];
}

- (void) show:(UIView*) superview
{
    [m_viewAnimator addSubview:self.view superview:superview];
}


@end
