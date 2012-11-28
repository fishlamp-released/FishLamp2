//
//	FLCachedPhotoInfo.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/30/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

//#import "FLCachedImage.h"
//#import "FLCacheBehavior.h"
//#import "FLCachedImageCacheBehavior.h"
//#import "NSObject+Copying.h"
//#import "FLImage.h"
//
//@implementation FLCachedImage
//
//@synthesize imageFile = _imageFile;
//
//FLSynthesizeCachedObjectHandlerProperty(FLCachedImage);
//
//- (id) initWithURL:(NSURL*) url {
//    return [self initWithUrlString:[url absoluteString]];
//}
//
//- (id) initWithUrlString:(NSString*) url {
//	if((self = [super init])) {
//		self.url = url;
//	}
//	
//	return self;
//}
//
//+ (FLCachedImage*) cachedImageWithUrlString:(NSString*) url {
//	return autorelease_([[[self class] alloc] initWithUrlString:url]);
//}
//
//+ (FLCachedImage*) cachedImage {
//	return autorelease_([[[self class] alloc] init]);
//}
//
//+ (FLCachedImage*) cachedImageWithURL:(NSURL*) url {
//    return autorelease_([[[self class] alloc] initWithURL:url]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_imageFile release];
//    [super dealloc];
//}
//#endif
//
//- (void) setUrl:(NSString*) inValue  { 
//	[super setUrl:inValue];
//	NSURL* url = [NSURL URLWithString:inValue];
//	self.host = url.host;
//	self.imageId = [NSString stringWithFormat:@"%@%@", url.host, url.path];
//	self.photoUrl = url.path;
//}
//
//- (void) copySelfTo:(id) object {
//	[super copySelfTo:object];
//	
//	FLImage* file = [self.imageFile copy];
//	[object setImageFile:file];
//	release_(file);
//}
//
//@end
//
