//
//	FLObjectParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import "FLPropertyInflator.h"

@interface FLPropertyInflator ()
@property (readwrite, strong, nonatomic) id inflatedPropertyObject;
@property (readwrite, strong, nonatomic) NSString* propertyName; // propertyName for data, like an xml element name
@end

@implementation FLPropertyInflator

@synthesize propertyName = _propertyName;
@synthesize containingObject = _containingObject;
@synthesize encodedString = _encodedString;
@synthesize propertyType = _propertyType;
@synthesize state = _state;
@synthesize inflatedPropertyObject = _inflatedPropertyObject;

- (id) init {
	if((self = [super init])) {
	}
	
	return self;
}

- (id) initWithContainingObject:(id) object propertyName:(id) propertyName state:(int) state {
    self = [super init];
    if(self) {
        self.containingObject = object;
        self.propertyName = propertyName;
        self.state = state;
    }
    return self;
}

+ (FLPropertyInflator*) propertyInflator:(id) object propertyName:(id) propertyName  state:(int) state {
    return FLAutorelease([[FLPropertyInflator alloc] initWithContainingObject:object propertyName:propertyName state:state]);
}

//- (FLObjectDescriber*) objectDescriber {
//    if(!_describer) {
//        self.objectDescriber = [self.object objectDescriber];
//    }
//    
//    return _describer;
//}

#if FL_MRC
- (void) dealloc {
    [_inflatedPropertyObject release];
//    [_parseInfo release];
    [_propertyName release];
    [_encodedString release];
    [_containingObject release];
    [_propertyType release];
    
    [super dealloc];
}
#endif

- (void) appendEncodedString:(NSString*) string {
    if(FLStringIsNotEmpty(string)) {
        if(!_encodedString) {
            _encodedString = [string mutableCopy];
        }
        else {
            [_encodedString appendString:string];
        }
    }
}

- (void) inflatePropertyWithDataDecoder:(id<FLDataDecoding>) decoder {
    
    if(FLStringIsNotEmpty(_encodedString)) {
		NSString* unparsedData = [_encodedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
		if(unparsedData.length > 0) {
        
            if(!self.propertyType) {
                self.propertyType = [[[self.containingObject objectDescriber] propertyDescriberForPropertyName:self.propertyName] propertyType];
            }
            
			if(self.propertyType) {
                FLAssertIsNotNil_(decoder);
                
				self.inflatedPropertyObject = [decoder decodeDataFromString:unparsedData forType:self.propertyType]; 

				if(!self.inflatedPropertyObject) {
                    self.inflatedPropertyObject = unparsedData; // trimmed string... ??
				}
			}
#if DEBUG	 
			else
			{
				FLDebugLog(@"Warning: %@ doesn't know about property %@: unparsed data: %@, state: %d", 
                    NSStringFromClass([self.containingObject class]), self.propertyName, unparsedData, self.state); 
			
			}
#endif				  
		}
    }
}

@end
#endif