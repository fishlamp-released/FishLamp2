//
//  GtUserPreferences.m
//  MyZen
//
//  Created by Mike Fullerton on 11/4/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtUserPreferences.h"
#import "GtFileUtilities.h"
#import "GtUserSession.h"

#define kFileName @"prefs.plist"

@implementation GtUserPreferences

- (void) setDefaults
{
}

- (NSString*) filePath:(NSString*) userId
{
    return [GtFileUtilities documentsFilePath:@"prefs.plist" userName:userId];
}

- (BOOL) delete
{
    return [[GtUserSession instance].documentsFolder deleteFile:kFileName outError:nil];
}

- (BOOL) save
{
    return [[GtUserSession instance].documentsFolder writeObjectToFile:kFileName object:self.objectData outError:nil];
}

- (BOOL) load
{
    NSDictionary* prefs = nil;
    if([[GtUserSession instance].documentsFolder readObjectFromFile:kFileName outObject:&prefs outError:nil])
    {
        self.objectData = prefs;
        GtRelease(prefs);
        
        return YES;
    }
    
    [self setDefaults];
    
    return NO;
}

@end
