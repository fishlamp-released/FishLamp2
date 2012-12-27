//
//	FLFolder.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/7/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLFolder.h"
#import "NSFileManager+FLExtras.h"
#import "FLBlocks.h"

@interface FLFolder ()
@property (readwrite, strong) NSString* folderPath;
@end

@implementation FLFolder

@synthesize folderPath = _fullPath;

- (id) init {
	if((self = [super init])) {
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        FLSetObjectWithRetain(_fullPath, [aDecoder decodeObjectForKey:@"_fullPath"]);
    }   

    return self;
}

- (void) encodeWithCoder:(NSCoder*) aCoder {
    [aCoder encodeObject:_fullPath forKey:@"_fullPath"];
}

- (id) initWithPath:(NSString*) path {
	FLAssertStringIsNotEmpty_v(path, nil);

	if((self = [super init])) {
		self.folderPath = path;
	}
	
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithPath:self.folderPath];
}
    
+ (id) folderWithPath:(NSString*) path  {
    return FLAutorelease([[[self class] alloc] initWithPath:path]);
}

#if FL_MRC
- (void) dealloc {
    [_fullPath release];
	[super dealloc];
}
#endif

- (void) deleteAllFiles:(FLFileVisitorBlock) visitor {
    [self deleteFiles:^(NSString* fileName, BOOL* shouldDeleteFile, BOOL* stop){
        *shouldDeleteFile = YES;
        if(visitor) {
            visitor(fileName, stop);
        }
    }];
}

- (NSArray*) allPathsInFolder {
    NSError* err = nil;
    NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folderPath] error:&err];
    if(err) {
        FLThrowError(FLAutorelease(err));
    }
    
    return everything;
}

- (void) visitAllFiles:(FLFileVisitorBlock) visitorBlock
{
	if([self existsOnDisk] && visitorBlock)
	{
        NSError* err = nil;
		NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folderPath] error:&err];
        if(err) {
           FLThrowError(FLAutorelease(err));
        }
		__block BOOL stop = NO;
        for(NSString* name in everything) {
            FLAutoreleasePool(
                visitorBlock(name, &stop);
            )
            
            if(stop) {
                break;
            }
        }
    }
}

- (void) deleteFiles:(FLFolderShouldDeleteFileVisitor) shouldDeleteFileBlock
{
	if([self existsOnDisk] && shouldDeleteFileBlock)
	{
        NSError* err = nil;
		NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folderPath] error:&err];
        if(err) {
           FLThrowError(FLAutorelease(err));
        }
		
        for(NSString* name in everything) {
            BOOL shouldDelete = NO;
            BOOL stop = NO;
            shouldDeleteFileBlock(name, &shouldDelete, &stop);
            if(shouldDelete) {
                [[NSFileManager defaultManager] removeItemAtPath: 
                    [[self folderPath] stringByAppendingPathComponent:name] error:&err];
                
                if(err) {
                   FLThrowError(FLAutorelease(err));
                }
            }
            
            if(stop) {
                break;
            }
        }
        
#if DEBUG
    NSArray* everything2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folderPath] error:&err];
    FLDebugLog(@"After delete, %d items left", everything2.count);    
#endif         
	}
}



- (unsigned long long) calculateFolderSize:(FLFileVisitorBlock) visitor
                              outItemCount:(NSUInteger*) outItemCount
{
	__block unsigned long long size = 0;
	
	if([self existsOnDisk]) {
        NSError* err = nil;
        NSDictionary* folderAttr = [[NSFileManager defaultManager] attributesOfItemAtPath:[self folderPath] error:&err];
        if(err) {
           FLThrowError(FLAutorelease(err));
        }
        
        size = [[folderAttr objectForKey:NSFileSize] longValue];
        
        NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folderPath] error:&err];
        if(err) {
           FLThrowError(FLAutorelease(err));
        }

        if(outItemCount) {
            *outItemCount = everything.count; 
        }
        
        __block BOOL stop = NO;
        for(NSString* path in everything) {
            
            FLAutoreleasePool(
                NSError* innerErr = nil;
                NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:
                    [[self folderPath] stringByAppendingPathComponent:path] error:&innerErr];

                if(innerErr) {
                   FLThrowError(FLAutorelease(innerErr));
                }
            
                size += [[attr objectForKey:NSFileSize] longLongValue];
                
                if(visitor) {
                    visitor(path, &stop);
                }
            )

            if(stop) {
                break;
            }
        }
        
	}
	return size;
}

- (NSDate*) dateCreatedForFile:(NSString*) fileName {
	NSError* err = nil;
	NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:[self pathForFile:fileName] error:&err];
    if(err) {
       FLThrowError(FLAutorelease(err));
    }

	return [attr objectForKey:NSFileCreationDate];
}

- (NSDate*) dateModifiedForFile:(NSString*) fileName {
	NSError* err = nil;
	NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:[self pathForFile:fileName] error:&err];
	
    if(err) {
       FLThrowError(FLAutorelease(err));
    }

	return [attr objectForKey:NSFileModificationDate];
}

- (unsigned long long) sizeForFileName:(NSString*) fileName {
	NSError* err = nil;
	NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:[self pathForFile:fileName] error:&err];
    if(err) {
       FLThrowError(FLAutorelease(err));
    }

	return [[attr objectForKey:NSFileSize] longLongValue];
}

- (void) createIfNeeded {
	NSError* err = nil;
	BOOL isDirectory;
	if(![[NSFileManager defaultManager] fileExistsAtPath: [self folderPath] isDirectory:&isDirectory]) {
		[[NSFileManager defaultManager] createDirectoryAtPath: [self folderPath] withIntermediateDirectories:YES attributes:nil error:&err];
        
        if(err) {
           FLThrowError(FLAutorelease(err));
        }
    }
}

- (NSString*) pathForFile:(NSString*) fileName {
	FLAssertStringIsNotEmpty_v(fileName, nil);
	return [self.folderPath stringByAppendingPathComponent:fileName];
}

- (BOOL) existsOnDisk {
	BOOL isDirectory = NO;
	return [[NSFileManager defaultManager] fileExistsAtPath: [self folderPath] isDirectory:&isDirectory];
}

- (void) deleteFile:(NSString*) fileName {
	FLAssertStringIsNotEmpty_v(fileName, nil);

	NSError* error = nil;
	[[NSFileManager defaultManager] removeItemAtPath:[self pathForFile:fileName] error:&error];
	if(error) {
        FLThrowError(FLAutorelease(error));
    }
}

- (void) writeObjectToFile:(NSString*) fileName object:(id) object {
	FLAssertStringIsNotEmpty_v(fileName, nil);
	FLAssertIsNotNil_v(object, nil);

	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:object];
	[self writeDataToFile:fileName data:data]; 
}

- (id) readObjectFromFile:(NSString*) fileName {
	FLAssertStringIsNotEmpty_v(fileName, nil);
    NSData* data = [self readDataFromFile:fileName];
	if(data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }

    return nil;
}

- (void) writeDataToFile:(NSString*) fileName data:(NSData*) data {
	FLAssertStringIsNotEmpty_v(fileName, nil);
	FLAssertIsNotNil_v(data, nil);
	
	NSError* error = nil;
	[data writeToFile:[self pathForFile:fileName] options:NSAtomicWrite error:&error];
	FLThrowError(FLAutorelease(error));
}

- (NSData*) readDataFromFile:(NSString*) fileName {
	FLAssertStringIsNotEmpty_v(fileName, nil);

	NSString* path = [self pathForFile:fileName];

    NSError* error = nil;
	NSData* data = [NSData dataWithContentsOfFile:path options:0 error:&error];
    FLThrowError(FLAutorelease(error));
    
    return data;
}

- (void) moveFilesToFolder:(FLFolder*) destinationFolder withCopy:(BOOL) copy {
	FLAssertIsNotNil_v(destinationFolder, nil);

	FLAutoreleasePool(

		if(![self existsOnDisk] || ![destinationFolder existsOnDisk]) {
			FLThrowError( FLAutorelease([[NSError alloc] initWithDomain:NSCocoaErrorDomain code:NSFileNoSuchFileError userInfo:nil]));
		}
		
        NSError* err = nil;
		NSFileManager* fileMgr = [NSFileManager defaultManager];
		NSArray* everything = [fileMgr contentsOfDirectoryAtPath:[self folderPath] error:&err];
        if(err) {
           FLThrowError(FLAutorelease(err));
        }

		NSString* destFolder = destinationFolder.folderPath;
		NSString* srcFolder = self.folderPath;
		
		for(NSString* file in everything) {
			NSString* src =		[srcFolder stringByAppendingPathComponent:file];
			NSString* dest =	[destFolder stringByAppendingPathComponent:file];
		
			if([fileMgr fileExistsAtPath:dest]) {
				continue;
			}
		
			if(copy) {
				[fileMgr copyItemAtPath:src toPath:dest error:&err];
			}
			else {
				[fileMgr moveItemAtPath:src toPath:dest error:&err];
			}
			
            if(err) {
               FLThrowError(FLAutorelease(err));
            }
        }
    )
}

- (BOOL) fileExistsInFolder:(NSString*) name {
	FLAssertStringIsNotEmpty_v(name, nil);

	return [[NSFileManager defaultManager] fileExistsAtPath:[self pathForFile:name]];
}

#if IOS
- (void) addSkipBackupAttributeToFile:(NSString*) name {
    [NSFileManager addSkipBackupAttributeToFile:[self pathForFile:name]];
}
#endif

- (NSUInteger) countItems:(BOOL) recursive {
    return [[NSFileManager defaultManager] countItemsInDirectory:self.folderPath recursively:recursive visibleItemsOnly:YES];
}

- (NSString*) fileUTI:(NSString*) name {

    NSString* extension = [[self pathForFile:name] pathExtension];
    FLConfirmStringIsNotEmpty_v(extension, @"failed to get file extension for %@", name);
    
    NSString* UTI = FLAutorelease(bridge_transfer_(NSString*, UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,  bridge_(CFStringRef, extension), NULL)));

    FLConfirmNotNil_v(UTI, @"failed to get UTI for extension for file %@", name);

    return UTI;
                    
}

@end

                                                   

