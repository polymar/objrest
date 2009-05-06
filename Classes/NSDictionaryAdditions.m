//  DictionaryAdditions.m
//  SRD
//
//  Created by Roberto Gamboni on 11/19/08.
//  Copyright 2008 Roberto Gamboni. All rights reserved.
//

#import "NSDictionaryAdditions.h"
#import "NSErrorAdditions.h"
#import "NSStringAdditions.h"

@implementation NSDictionary (SRD)

+ (NSDictionary*) dictionaryFromData: (NSData*) plistData mutabilityOption: (NSPropertyListMutabilityOptions) mutability 
							   error: (NSError**) outError
{
	NSString* errorString = nil;
	id result = [NSPropertyListSerialization propertyListFromData: plistData 
												 mutabilityOption: mutability
														   format: NULL 
												 errorDescription: &errorString];
	if (result != nil) {
		if ([result isKindOfClass: [NSDictionary class]])
			return result;
	}
	// Not parsed.
	if (outError != NULL)
		*outError = [NSError errorWithDomain: NSCocoaErrorDomain code: NSFileReadCorruptFileError localizedDescription: errorString];
	return nil;
}

/*!
 * Parses the plist data and return an NSDictionary.
 * Returns nil if it can't be parsed; if outError is non-nil, returns an error in the pointer.
!*/
+ (NSDictionary*) dictionaryFromData: (NSData*) plistData error: (NSError**) outError
{
	return [self dictionaryFromData: plistData mutabilityOption: NSPropertyListImmutable error: outError];
}

/*!
 * Returns the XML property list representation of the dictionary.
 * Returns nil on errors (which should only occur when non-plist data are in the dictionary).
 !*/
- (NSString*) plistRepresentation
{
	NSString* error = nil;
	NSData* data = [NSPropertyListSerialization dataFromPropertyList: self format: NSPropertyListXMLFormat_v1_0 errorDescription: &error];
	if (data == nil) {
		if (error != nil)
			NSLog(@"Can't convert NSDictionary to plist: %@", error);
		return nil;
	}
	NSString* xml = [NSString stringWithData: data encoding: NSUTF8StringEncoding];
	return xml;
}

@end

@implementation NSMutableDictionary (SRD)

/*!
 * Parses the plist data and return an NSMutableDictionary.  
 * Nested arrays and dictionarys are also mutable.
 * Returns nil if it can't be parsed; if outError is non-nil, returns an error in the pointer.
 !*/
+ (NSMutableDictionary*) dictionaryFromData: (NSData*) plistData error: (NSError**) outError
{
	return (NSMutableDictionary*) [self dictionaryFromData: plistData mutabilityOption: NSPropertyListMutableContainers error: outError];
}

@end
