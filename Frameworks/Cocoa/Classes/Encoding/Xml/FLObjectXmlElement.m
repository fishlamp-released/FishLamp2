//
//  FLObjectXmlElement.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLObjectXmlElement.h"
#import "FLXmlDocumentBuilder.h"

@interface FLObjectXmlElement ()
@property (readwrite, strong, nonatomic) id object;
@property (readwrite, strong, nonatomic) FLPropertyDescriber* propertyDescriber;
@end

@implementation FLObjectXmlElement

@synthesize object = _object;
@synthesize propertyDescriber = _propertyDescriber;

- (id) initWithObject:(id) object 
        xmlElementTag:(NSString*) xmlElementTag 
   xmlElementCloseTag:(NSString*) xmlElementCloseTag {
   
    self = [super initWithXmlElementTag:xmlElementTag xmlElementCloseTag:xmlElementCloseTag];
    if(self) {
        self.object = object;
    }
    return self;
}

- (id) initWithObject:(id) object xmlElementTag:(NSString*) xmlElementTag {

    return [self initWithObject:object xmlElementTag:xmlElementTag xmlElementCloseTag:xmlElementTag];
}

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag {

    return FLAutorelease([[[self class] alloc] initWithObject:object xmlElementTag:xmlElementTag]);
}

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag 
     xmlElementCloseTag:(NSString*) xmlElementCloseTag {

    return FLAutorelease([[[self class] alloc] initWithObject:object xmlElementTag:xmlElementTag]);
}

- (id) initWithObject:(id) object
          xmlElementTag:(NSString*) xmlElementTag
          propertyDescriber:(FLPropertyDescriber*) propertyDescriber {
    
    self = [self initWithObject:object xmlElementTag:xmlElementTag];
    if(self) {
        self.propertyDescriber = propertyDescriber;
    }
            
    return self;
}          

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag
          propertyDescriber:(FLPropertyDescriber*) propertyDescriber {
    
    return FLAutorelease([[[self class] alloc] initWithObject:object 
                                                xmlElementTag:xmlElementTag 
                                                     propertyDescriber:propertyDescriber]);
}          


#if FL_MRC
- (void) dealloc {
    [_object release];
    [_propertyDescriber release];
    [super dealloc];
}
#endif

//- (void) appendLineWithEncodedObject:(id) object
//                   typeDesc:(FLPropertyDescriber*) typeDesc {
//
//    if(object) {
//        FLAssertNotNilWithComment(typeDesc, @"serialization requires property typeDesc");
//        
//        id<FLDataEncoding> dataEncoder = [self dataEncoder];
//        FLConfirmNotNilWithComment(dataEncoder, @"Xml String builder requires a data encoder");
//    
//		NSString* string = [dataEncoder encodeDataToString:object forType:typeDesc.typeDesc];
//        FLAssertNotNil(string);
//        FLConfirm([string isKindOfClass:[NSString class]]);
//        [self appendLine:string];
//	}
//}

- (void) didMoveToParent:(id) parent {

    [super didMoveToParent:parent];
    if(parent && _object) {
        
        if(!self.dataEncoder) {
            id walker = self.parent;
            while(walker) {
                if([walker respondsToSelector:@selector(dataEncoder)]) {
                    id dataEncoder = [walker dataEncoder];
                    if(dataEncoder) {
                        self.dataEncoder = dataEncoder;
                        break;
                    }

                }
                walker = [walker parent];
            }
        }
    
        FLAssertNotNil([self dataEncoder]);
        
        [_object addToXmlElement:self propertyDescriber:_propertyDescriber];
    }
}

@end

/*
@interface FLXmlElementStringBuilderLine : FLStringBuilderLine {
@private
    id _object;
    FLPropertyDescriber* _typeDesc;
    NSString* _encodedString;
}

+ (id) xmlElementStringBuilderLine:(id) object typeDesc:(FLPropertyDescriber*) typeDesc;

@end

@interface FLXmlElementStringBuilderLine ()
@property (readwrite, strong, nonatomic) id object;
@property (readwrite, assign, nonatomic) FLObjectDescriber* typeDesc;
@property (readwrite, strong, nonatomic) NSString* encodedString;

@end

@implementation FLXmlElementStringBuilderLine

@synthesize object = _object;
@synthesize typeDesc = _typeDesc;
@synthesize encodedString = _encodedString;

+ (id) xmlElementStringBuilderLine:(id) object typeDesc:(FLObjectDescriber*) typeDesc {

    FLAssertNotNil(object);
    FLAssertNotNilWithComment(typeDesc, @"serialization as token requires property typeDesc")

    FLXmlElementStringBuilderLine* token = FLAutorelease([[[self class] alloc] init]);
    token.object = object;
    token.typeDesc = typeDesc;
    return token;
}

#if FL_MRC
- (void) dealloc {
    [_encodedString release];
    [_object release];
    [_typeDesc release];
    [super dealloc];
}
#endif

- (void) didMoveToParent:(id)parent {
            
    if(parent && _object) {
        FLAssertNotNilWithComment(_typeDesc, @"serialization requires property typeDesc")
             
        id<FLDataEncoding> dataEncoder = [[parent document] dataEncoder];
        FLConfirmNotNilWithComment(dataEncoder, @"Xml String builder requires a data encoder");
    
        NSString* encodedString = nil;
        [dataEncoder encodeDataToString:_object forType:_typeDesc.typeDesc outEncodedString:&encodedString];
        FLAssertNotNil(encodedString);
        FLConfirm([encodedString isKindOfClass:[NSString class]]);
        
        self.string = encodedString;
    }
}

- (void) buildStringWithPrettyString:(FLPrettyString *) prettyString {
    if(FLStringIsNotEmpty(_encodedString)) {
        [prettyString appendString:_encodedString];
    }
}               

- (id) copyWithZone:(NSZone *)zone  {
    FLXmlElementStringBuilderLine* token = [[FLXmlElementStringBuilderLine alloc] init];
    token.object = self.object;
    token.typeDesc = self.typeDesc;
    token.string = self.string;
//    token.tabIndent = self.tabIndent;
    return token;
}

@end                  
*/