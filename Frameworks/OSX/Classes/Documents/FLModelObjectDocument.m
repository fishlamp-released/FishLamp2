//
//  FLModelObjectDocument.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 5/2/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLModelObjectDocument.h"
#import "FLXmlParser.h"
#import "FLXmlObjectBuilder.h"
#import "FLXmlDocumentBuilder.h"
#import "FLModelObject.h"
#import "FLObjectXmlElement.h"
#import "FLObjectDescriber.h"

@implementation FLModelObjectDocument

@synthesize modelObject = _modelObject;

#if FL_MRC
- (void) dealloc {
	[_modelObject release];
	[super dealloc];
}
#endif

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

-(BOOL)isDocumentEdited {
    return NO;
}

 - (void)document:(NSDocument *)document didSave:(BOOL)didSaveSuccessfully contextInfo:(void *)contextInfo {
    
    FLLog(@"%@ did save document");
 }

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    FLLog(@"%@ keyPath changed", keyPath);
    
    if(self.fileURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self saveDocumentWithDelegate:self didSaveSelector:@selector(document:didSave:contextInfo:) contextInfo:nil];
        });
    }
    
}

- (void) setModelObject:(id) object {

    if(_modelObject) {
        NSDictionary* properties = [[_modelObject objectDescriber] properties];
        for(NSString* prop in properties) {
            [object removeObserver:self forKeyPath:prop];
        }
    }
    
    FLSetObjectWithRetain(_modelObject, object);

    NSDictionary* properties = [[_modelObject objectDescriber] properties];
    for(NSString* prop in properties) {
        [object addObserver:self forKeyPath:prop options:NSKeyValueObservingOptionNew context:nil];
    }
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    FLObjectXmlElement* element = [FLObjectXmlElement objectXmlElement:self.modelObject 
                                                         xmlElementTag:NSStringFromClass([self.modelObject class])];
            
    FLXmlDocumentBuilder* xml = [FLXmlDocumentBuilder xmlStringBuilder];
	[xml addElement:element];
    
    FLPrettyString* string = [FLPrettyString prettyString];
    [string appendStringFormatter:xml];

    return [string.string dataUsingEncoding:NSUTF8StringEncoding];

    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
//    if (outError) {
//        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
//    }
//    return nil;
}



- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
//    if (outError) {
//        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
//    }
    return YES;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

@end
