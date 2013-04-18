//
//  FLImageProperties.m
//  Composer
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImageProperties.h"

@implementation FLImageProperties 

- (id) initWithImageURL:(NSURL*) url {
    self = [super init];
    if(self) {
        self.imageURL = url;
    }   
    return self;
}

- (NSURL*) imageURL {
    return [NSURL URLWithString:self.url];
}

- (void) setImageURL:(NSURL*) url {
    self.url = url.absoluteString;
}

+ (id) imageProperties {
	return FLAutorelease([[[self class] alloc] init]);
}

+ (id) imagePropertiesWithImageURL:(NSURL*) url {
    return FLAutorelease([[[self class] alloc] initWithImageURL:url]);
}

- (void) setUrl:(NSString*) inValue  { 
	[super setUrl:inValue];
	NSURL* url = [NSURL URLWithString:inValue];
	self.host = url.host;
	self.imageId = [NSString stringWithFormat:@"%@%@", url.host, url.path];
	self.photoUrl = url.path;
    self.fileName = [[url path] lastPathComponent];
}

+ (NSString*) databaseTableName {

// for compatability
	return @"FLCachedImage";
}


@end