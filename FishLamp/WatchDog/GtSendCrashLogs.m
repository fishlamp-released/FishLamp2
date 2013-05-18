//
//  GtSendCrashLogs.m
//  MyZen
//
//  Created by Mike Fullerton on 12/18/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSendCrashLogs.h"
#import "GtEmailer.h"

#import "GtDefaultErrorHandler.h"
#import "GtStringBuilder.h"
#import "GtFileUtilities.h"

@implementation GtSendCrashLogs

- (id) initWithEmailAddress:(NSString*) emailAddress
{
    if(self = [super init])
    {
        m_emailAddress = [emailAddress retain];
    }
    
    return self;
}

+ (BOOL) hasCrashLogsToSend
{
    return [[GtDefaultErrorHandler instance] hasCrashLogs];
}

- (void) deleteCrashLogs
{
    [[GtDefaultErrorHandler instance] deleteAllCrashLogs];
}

- (void) getAllCrashLogsSmashedTogether:(GtStringBuilder*) builder
{
    NSArray* pathArray = [[GtDefaultErrorHandler instance] getAllCrashLogPaths];
    
    for(NSString* path in pathArray)
    {
        NSError* err = nil;
	
        NSString* contents = [GtAlloc(NSString) initWithContentsOfFile:path
            encoding:NSUTF8StringEncoding
            error: &err];
            
        [builder appendLine:contents];
        
        GtRelease(contents);
    }
}


- (void) composeEmail:(UIViewController*) viewController
{
    [self retain];

   	GtEmailer* email = [GtAlloc(GtEmailer) init];
	
	email.subject = @"Beta Crash Log"; 
	email.toRecipients = [NSArray arrayWithObject:m_emailAddress];
	
	GtStringBuilder* builder = [GtAlloc(GtStringBuilder) initWithPrettyPrint:NO];
	
	[builder appendLine:@"Please add details of crash (optional):<br/><br/><br/>"];

	[builder appendFormat:@"Please do not change or delete info below this line<br/>"];
	//[self getAllCrashLogsSmashedTogether:builder];
    
    email.body = [builder toString];
	
    GtStringBuilder* attachment = [GtAlloc(GtStringBuilder) init];
    [self getAllCrashLogsSmashedTogether:attachment];
    [email setAttachment:[[attachment toString] dataUsingEncoding:NSUTF8StringEncoding]
        fileName:@"CrashLogs"
        mimeType:GT_TEXT_PLAIN_TYPE];
        
    
    GtRelease(attachment);
	GtRelease(builder);
	
	[email composeEmail:viewController];
	
	GtRelease(email);


}


@end
