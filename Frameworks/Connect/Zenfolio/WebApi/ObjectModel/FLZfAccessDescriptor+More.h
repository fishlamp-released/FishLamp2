//
//  FLZfAccessDescriptor+More.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfAccessDescriptor.h"
#import "FLZfImageSize.h"

@interface FLZfAccessDescriptor (Utils)

- (FLZfAccessUpdater*) createUpdater;
- (BOOL) testAccessMask:(FLZfApiAccessMask) mask;

- (NSString*) derivedString;
- (NSString*) descriptionString;
+ (NSString*) accessTypeString:(FLZfAccessType) accessType;

// these means ALL of them??
@property (readonly, assign, nonatomic) BOOL protectAll;

// protected sizes
@property (readwrite, assign, nonatomic) BOOL protectExtraExtraLarge;
@property (readonly, assign, nonatomic) BOOL protectLarge;
@property (readonly, assign, nonatomic) BOOL protectMedium;
@property (readonly, assign, nonatomic) BOOL protectExtraLarge;
@property (readonly, assign, nonatomic) BOOL protectOriginals;

// not sure what this means
@property (readonly, assign, nonatomic) BOOL noCollections;

// searchs
@property (readonly, assign, nonatomic) BOOL noPrivateSearch;
@property (readonly, assign, nonatomic) BOOL noPublicSearch;

// photo metaData/EXIF
@property (readonly, assign, nonatomic) BOOL hideDateCreated;
@property (readonly, assign, nonatomic) BOOL hideDateModified;
@property (readonly, assign, nonatomic) BOOL protectExif;
@property (readonly, assign, nonatomic) BOOL hideMetaData;

// stats
@property (readonly, assign, nonatomic) BOOL hideVisits;
@property (readonly, assign, nonatomic) BOOL hideUserStats;

// guest book
@property (readonly, assign, nonatomic) BOOL noPublicGuestbookPosts;
@property (readonly, assign, nonatomic) BOOL noPrivateGuestBookPosts;
@property (readonly, assign, nonatomic) BOOL noAnonymouseGuestbookPosts;

// comments
@property (readonly, assign, nonatomic) BOOL noPublicComments;
@property (readonly, assign, nonatomic) BOOL noPrivateComments;
@property (readonly, assign, nonatomic) BOOL noAnonymousComments;
@property (readonly, assign, nonatomic) BOOL protectComments;

// figures out what the largest size available by access control is
@property (readonly, assign, nonatomic) FLZfImageSize* largestAllowedImageSize; 

@end
