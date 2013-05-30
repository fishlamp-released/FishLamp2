// 
// ZFPhoto.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 2:36 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFPhoto.h"
#import "ZFAccessDescriptor.h"
#import "ZFExifTag.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
@implementation ZFPhoto
@synthesize rotation = _rotation;
@synthesize title = _title;
@synthesize urlCore = _urlCore;
@synthesize duration = _duration;
@synthesize mimeType = _mimeType;
@synthesize originalUrl = _originalUrl;
@synthesize owner = _owner;
@synthesize accessDescriptor = _accessDescriptor;
@synthesize mailboxId = _mailboxId;
@synthesize views = _views;
@synthesize keywords = _keywords;
@synthesize urlToken = _urlToken;
@synthesize pageUrl = _pageUrl;
@synthesize exifTags = _exifTags;
@synthesize size = _size;
@synthesize flags = _flags;
@synthesize takenOn = _takenOn;
@synthesize id = _id;
@synthesize caption = _caption;
@synthesize fileName = _fileName;
@synthesize pricingKey = _pricingKey;
@synthesize textCn = _textCn;
@synthesize height = _height;
@synthesize width = _width;
@synthesize urlHost = _urlHost;
@synthesize uploadedOn = _uploadedOn;
@synthesize isVideo = _isVideo;
@synthesize gallery = _gallery;
@synthesize sequence = _sequence;
@synthesize copyright = _copyright;
@synthesize categories = _categories;
@synthesize shortExif = _shortExif;
+(void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"Keyword" propertyClass:[NSString class]] forContainerProperty:@"keywords"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"ExifTags" propertyClass:[ZFExifTag class]] forContainerProperty:@"exifTags"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"Category" propertyClass:[NSNumber class]] forContainerProperty:@"categories"];
}
+(ZFPhoto*) photo {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_rotation release];
    [_title release];
    [_urlCore release];
    [_mimeType release];
    [_originalUrl release];
    [_owner release];
    [_accessDescriptor release];
    [_mailboxId release];
    [_keywords release];
    [_urlToken release];
    [_pageUrl release];
    [_exifTags release];
    [_flags release];
    [_takenOn release];
    [_caption release];
    [_fileName release];
    [_urlHost release];
    [_uploadedOn release];
    [_sequence release];
    [_copyright release];
    [_categories release];
    [_shortExif release];
    [super dealloc];
}
#endif
@end
