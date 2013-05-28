//
//  FLInputDescriptor.m
//  Whittle
//
//  Created by Mike Fullerton on 6/27/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCodeProjectLocation.h"

@interface FLCodeProjectLocation ()
@property (readwrite, strong, nonatomic) NSURL* URL;
@property (readwrite, assign, nonatomic) FLCodeProjectLocationType locationType;
@end

@implementation FLCodeProjectLocation

@synthesize URL = _url;
@synthesize locationType = _locationType;

- (id) initWithURL:(NSURL*) url 
      resourceType:(FLCodeProjectLocationType) resourceType {
      
    self = [super init];
    if(self) {
        self.URL = url;
        self.locationType = resourceType;
    }
    
    return self;
}

+ (FLCodeProjectLocation*) resourceDescriptor:(NSURL*) url  
                                resourceType:(FLCodeProjectLocationType) resourceType {
    return FLAutorelease([[FLCodeProjectLocation alloc] initWithURL:url resourceType:resourceType]);
}
                             
#if FL_DEALLOC 
- (void) dealloc {
    [_url release];
    [super dealloc];
}
#endif

- (BOOL) hasFileExtension:(NSString*) fileExtension {
    if([self isLocationType:FLCodeProjectLocationTypeFile]) {
        return FLStringsAreEqualCaseInsensitive( [_url pathExtension], fileExtension); 
    }
    
    return NO;
}

- (BOOL) isLocationType:(FLCodeProjectLocationType) locationType {
    return FLTestBits(locationType, _locationType); 
}

- (NSData*) loadDataInResource {
    
           
//        if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
//            FLThrowErrorCodeWithComment(FLErrorDomain, FLCodeProjectNotFound, @"Project not found: %@", path);
//        }
            
    NSError* err = nil;
	NSData* data = [NSData dataWithContentsOfURL:_url options:NSDataReadingUncached error:&err];
    if(err) {
        FLThrowIfError(FLAutorelease(err));
    }
    FLAssertNotNil(data);
    
    return data;
}

@end
