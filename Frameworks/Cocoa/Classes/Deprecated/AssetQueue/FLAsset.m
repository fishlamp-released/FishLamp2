//
//  FLAsset.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAsset.h"


@implementation FLAsset

@synthesize assetUID = _assetUID;

#if FL_MRC
- (void) dealloc {
    [_assetUID release];
    [super dealloc];
}
#endif


//- (id) initWithQueuedAsset:(FLQueuedAsset *)asset {
//    FLAssertIsOverriddenWithComment(nil);
//    return self;
//}
//
//- (void) dealloc
//{
//	FLRelease(_assetUID);
//	FLSuperDealloc();
//}
//
//- (NSURL*) assetURL
//{
//	return nil;
//}
//
//- (SDKImage*) thumbnailImage
//{
//	return nil;
//}
//
//- (BOOL)isEqual:(id)object
//{
//	return [self.assetURL isEqual:[object assetURL]];
//}
//
//- (NSUInteger)hash
//{
//	return [self.assetURL hash];
//}
//
//- (NSString*) description
//{
//	return [NSMutableString stringWithFormat:@"%@: UID: %@, URL: %@", [super description], self.assetUID, self.assetURL];
//}
//
//- (FLFinisher*) startLoadingRepresentation:(FLDispatchBlockWithResult) completionBlock {
//    FLAssertIsImplementedWithComment(@"must override this");
//    return nil;
//}
//
//- (NSInputStream*) createReadStream {
//    return nil;
//}
//
//- (void) readFromStorage {
//}
//
//- (void) writeToStorage {
//}
//
//- (void) deleteFromStorage {
//}
//
//- (BOOL) canWriteToStorage {
//}
//- (BOOL) canDeleteFromStorage;
//
//- (BOOL) existsInStorage {
//}



@end

@implementation NSObject (FLAsset)
+ (NSString*) assetURLScheme {
    return nil;
}
@end