//  DictionaryAdditions.h
//  SRD
//
//  Created by Roberto Gamboni on 11/19/08.
//  Copyright 2008 Roberto Gamboni. All rights reserved.
//

#import <Foundation/NSDictionary.h>


@interface NSDictionary (SRD)

/*!
 * Parses the plist data and return an NSDictionary.
 * Returns nil if it can't be parsed; if outError is non-nil, returns an error in the pointer.
!*/
+ (NSDictionary*) dictionaryFromData: (NSData*) plistData error: (NSError**) outError;

/*!
 * Returns the XML property list representation of the dictionary.
 * Returns nil on errors (which should only occur when non-plist data are in the dictionary).
!*/
- (NSString*) plistRepresentation;

@end

@interface NSMutableDictionary (SRD)

/*!
 * Parses the plist data and return an NSMutableDictionary.  
 * Nested arrays and dictionarys are also mutable.
 * Returns nil if it can't be parsed; if outError is non-nil, returns an error in the pointer.
 !*/
+ (NSMutableDictionary*) dictionaryFromData: (NSData*) plistData error: (NSError**) outError;

@end
