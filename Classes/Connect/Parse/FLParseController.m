//
//  FLParseController.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 5/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLParseController.h"
#import "FLModelObject.h"
#import "FLParseClassLink.h"
#import "FLUserLogin+Additions.h"
#import "FLParseCredentials.h"
#import "FLTrace.h"

#import <ParseOSX/ParseOSX.h>

@interface FLParseController ()
- (void) deleteObject:(PFObject*) object;
@end

@implementation FLParseController

FLSynthesizeSingleton(FLParseController);

- (PFObject*) readObjectWithClassLink:(FLParseClassLink*) classLink {
    NSError* error = nil;
    
    NSString* className = classLink.objectClass;
    NSString* objectId = classLink.objectId;
    
    PFObject* object = [PFQuery getObjectOfClass:className objectId:objectId error:&error];
    
    if(error && error.code != kPFErrorObjectNotFound) {
        FLThrowIfError(error);
    }
    
    return object;
}

- (id) readObject:(FLParseClassLink*) object {

// TODO: inflate model objects

    return nil;
}

- (void) deleteObjectWithClass:(Class) aClass withObjectId:(NSString*) objectId {
    [self deleteObjectWithClassLink:[FLParseClassLink parseClassLink:aClass objectId:objectId]];
}

- (void) deleteObjectWithClassLink:(FLParseClassLink*) classLink {
    FLAssert([classLink isKindOfClass:[FLParseClassLink class]]);

    PFObject* object = [self readObjectWithClassLink:classLink];
    if(object) {
        [self deleteObject:object];
    }
    else {
        FLTrace(@"object not found to delete: %@", classLink)
    }

}

- (void) deleteObject:(PFObject*) object {

    Class objectClass = NSClassFromString(object.parseClassName);

    FLObjectDescriber* objectDescriber = [objectClass objectDescriber];
    
    for(NSString* key in object.allKeys) {
    
        id propertyValue = [object objectForKey:key];
        if([propertyValue isKindOfClass:[NSNull class]]) {
            continue;
        }
    
        FLPropertyDescriber* property = [objectDescriber propertyForName:key];

        NSString* propertyClassName = NSStringFromClass([property representedObjectClass]);
            
        if([property representsModelObject]) {
            [self deleteObjectWithClassLink:[FLParseClassLink parseClassLink:propertyValue]];
        }
        else if([propertyValue isArray]) {
            for(id value in propertyValue) {
                if([value isKindOfClass:[NSString class]]) {
                    FLParseClassLink* link = [FLParseClassLink parseClassLink:value];
                    if(link) {
                        [self deleteObjectWithClassLink:link];
                    }
                }
            }
        }
    }

    NSError* error;
    [object delete:&error];
    FLThrowIfError(error);
    
    FLTrace(@"Deleted object: %@", [FLParseClassLink parseClassLink:objectClass objectId:object.objectId]);
}

- (void) deleteAllObjectsOfClass:(Class) class {

    PFQuery *query = [PFQuery queryWithClassName:NSStringFromClass(class)];
    NSArray* objects = [query findObjects];
    FLTrace(@"Found %d objects to delete", objects.count);
    
    for(PFObject* object in objects) {
        [self deleteObject:object];
    }
}

- (FLParseClassLink*) saveObject:(id) object withParentObject:(PFObject*) parent array:(NSMutableArray*) array {

    PFObject* pfObject = [PFObject objectWithClassName:NSStringFromClass([object class])];

    [object visitEachProperty:^(NSString *propertyName, id propertyValue, BOOL *stop) {
        if(propertyValue == nil) {
            [pfObject setObject:[NSNull null] forKey:propertyName];
        }
        else if([propertyValue isModelObject]) {
            FLParseClassLink* link = [self saveObject:propertyValue withParentObject:pfObject array:array];
            [pfObject setObject:link.encodedString forKey:propertyName];
        }
        else if([propertyValue isArray]) {
            NSMutableArray* objects = [NSMutableArray array];
            for(id arrayObj in propertyValue) {
                if([arrayObj isModelObject]) {
                    FLParseClassLink* link = [self saveObject:arrayObj withParentObject:pfObject array:array];
                    [array addObject:link];
                    [objects addObject:link.encodedString];
                }
                else {
                    [objects addObject:arrayObj];
                }
            }
            [pfObject addObjectsFromArray:objects forKey:propertyName];
        }
        else {
            [pfObject setObject:propertyValue forKey:propertyName];
        }
    }];
    
    NSError* error = nil;
    [pfObject save:&error];
    FLThrowIfError(error);
    
    FLParseClassLink* classLink = [FLParseClassLink parseClassLink:[object class] objectId:pfObject.objectId];

#if TRACE
    if(parent) {
        FLTrace(@"Saved object: %@.%@", [parent parseClassName], classLink)
    }
    else {
        FLTrace(@"Saved object: %@", classLink)
    }
#endif     
    
    [array addObject:classLink];
    
    return classLink;
}

- (FLParseClassLink*) saveObject:(id) object {
    NSMutableArray* array = [NSMutableArray array];
    @try {
        FLParseClassLink* link = [self saveObject:object withParentObject:nil array:array];
        FLTrace(@"Saved finished for %@", link);
        return link;
    }
    @catch(NSException* ex) {
        // TODO delete objects in array 
        FLTrace(@"Save failed got error: %@", [ex description]);
        @throw;
    }
    
    return nil;
}

- (void) setAppCredentialials:(FLParseCredentials*) creds {
    FLAssertNotNil(creds);

    FLSetObjectWithRetain(_credentials, creds);

    [Parse setApplicationId:creds.applicationID clientKey:creds.clientKey];

    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [defaultACL setPublicWriteAccess:NO];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    FLTrace(@"set appId and default ACL");
}

- (FLPromise*) beginLoggingInUser:(FLUserLogin*) userLogin 
                       completion:(fl_completion_block_t) completion {

    FLTrace(@"logging in: %@", userLogin.userName);
    
    return [[FLDispatchQueue defaultQueue] queueFinishableBlock:^(FLFinisher *finisher) {
        NSError* error = nil;
        [PFUser logInWithUsername:userLogin.userName
                         password:userLogin.password
                         error:&error];
        FLThrowIfError(error);
        
        userLogin.isAuthenticated = YES;
        [finisher setFinishedWithResult:userLogin];
        
        FLTrace(@"logged in %@ ok", userLogin.userName);
        
    } completion:completion ];
}

//    if(![[FLParseController instance] isAuthenticated]) {
//        FLUserLogin* login = nil; 
//
//                // TODO bring up login window
//    
//        [[FLParseController instance] beginLoggingInUser:login completion:^(id result) {
//            if([result error]) {
//                FLLog(@"login failed");
//                
//                // TODO bring up login window
//            }
//        }];
//    }

- (FLPromise*) openParseController:(FLParseCredentials*) credentials
                        completion:(fl_completion_block_t) completion {
                        
    [self setAppCredentialials:credentials];
    FLUserLogin* userLogin = [FLUserLogin userLogin:credentials.username password:credentials.password];
    
    return [self beginLoggingInUser:userLogin completion:completion];
}                        



- (BOOL) isAuthenticated {
    return [PFUser currentUser] != nil;
}



@end
