//
//  FLZenfolioQueuedPhoto.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioQueuedPhoto.h"
#import "FLZenfolioUploadGallery.h"
#import "ISO8601DateFormatter.h"
#import "FLHtmlStringBuilder.h"
#import "FLZenfolioErrors.h"

@implementation FLZenfolioQueuedPhoto (FishLamp)

static ISO8601DateFormatter* s_formatter = nil;

+ (void) initialize
{
	if(!s_formatter)
	{
		s_formatter = [[ISO8601DateFormatter alloc] init] ; 
		s_formatter.includeTime = YES;
		s_formatter.timeSeparator = ':';
		s_formatter.format = ISO8601DateFormatCalendar;
	}
}

- (FLZenfolioUploadGallery*) uploadGallery
{
	FLZenfolioUploadGallery* gallery = [FLZenfolioUploadGallery uploadGallery];
	gallery.photoSetId = self.uploadDestinationId;
	gallery.name = self.uploadDestinationName;
	gallery.uploadUrl = self.uploadDestinationURL;
	return gallery;
}

- (void) setUploadGallery:(FLZenfolioUploadGallery*) uploadGallery
{
	if(uploadGallery)
	{
		self.uploadDestinationId =		uploadGallery.photoSetId;
		self.uploadDestinationName =	uploadGallery.name;
		self.uploadDestinationURL =	uploadGallery.uploadUrl;
	}
    else
    {
		self.uploadDestinationId =		0;
		self.uploadDestinationName =	@"";
		self.uploadDestinationURL =     @"";
    }
}

- (BOOL) hasUploadGallery
{
	return	self.uploadDestinationId != 0 && 
			FLStringIsNotEmpty(self.uploadDestinationName) && 
			FLStringIsNotEmpty(self.uploadDestinationURL);
		
}

#define FLNonNullString(s) FLStringIsEmpty(s) ? @"" : s

- (FLZenfolioPhotoUpdater*) createUpdater
{
	FLZenfolioPhotoUpdater* updater = FLAutorelease([[FLZenfolioPhotoUpdater alloc] init]);
	updater.Title = FLNonNullString(self.assetName);
	updater.Caption = FLNonNullString([FLHtmlStringBuilder convertNewlinesToHtmlBreaks:self.assetDescription]);
	updater.Keywords = self.keywords;
	updater.Categories = self.zenfolioCategories;
	updater.Copyright = FLNonNullString(self.copyright);
	updater.FileName = FLNonNullString(self.assetFileName);
	return updater;
}

- (NSURL*) buildUploadURL:(BOOL) includeParameters
{
    if(FLStringIsEmpty(self.uploadGallery.uploadUrl)) {
        FLThrowErrorCode_v(FLZenfolioErrorDomain, FLZenfolioErrorCodeUploadPhotoSetNotFound, @"PhotoSet not found: %@", self.uploadGallery.name);
    }
    if(FLStringIsEmpty(self.assetFileName)) {
        FLThrowErrorCode_v(FLZenfolioErrorDomain, FLZenfolioErrorCodeUploadFileNameEmpty, @"FileName is empty");
    }
	
	NSString* uploadUrl = nil;
    
    if(includeParameters)
    {
        NSDate* date = self.modifiedDate;

        if(!date)
        {
            date = [NSDate date];
        }

        NSString* modDate = [s_formatter stringFromDate:date];

        uploadUrl = [NSString stringWithFormat:@"%@?filename=%@&modified=%@ HTTP/1.1", 
            self.uploadGallery.uploadUrl, 
            self.assetFileName,
            modDate];
    }
    else
    {
        uploadUrl = [NSString stringWithFormat:@"%@ HTTP/1.1", 
            self.uploadGallery.uploadUrl];    
    }
	
    NSURL* url = [NSURL URLWithString:[uploadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    FLAssertIsNotNil_(url);

	return url;
}

@end
