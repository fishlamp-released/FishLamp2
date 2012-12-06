//
//  FLAsset.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
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
//    FLAssertIsOverridden_v(nil);
//    return self;
//}
//
//- (void) dealloc
//{
//	release_(_assetUID);
//	super_dealloc_();
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
//- (FLFinisher*) startLoadingRepresentation:(FLResultBlock) completionBlock {
//    FLAssertIsImplemented_v(@"must override this");
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