//  StringAdditions.h
//  SRD
//
//  Created by Roberto Gamboni.
//  Copyright 2009 YellowPages.com. All rights reserved.
//

#import <Foundation/NSString.h>

/*! Some additions to NSString. !*/
@interface NSString (Openovo)

/**
 * Return the dashed form af this camelCase string:
 *
 *   [@"camelCase" dasherize] //> @"camel-case"
 */
- (NSString *)dasherize;

/**
 * Return the underscored form af this camelCase string:
 *
 *   [@"camelCase" underscore] //> @"camel_case"
 */
- (NSString *)underscore;

/**
 * Return the camelCase form af this dashed/underscored string:
 *
 *   [@"camel-case_string" camelize] //> @"camelCaseString"
 */
- (NSString *)camelize;

/**
 * Return a copy of the string suitable for displaying in a title. Each word is downcased, with the first letter upcased.
 */
- (NSString *)titleize;

/**
 * Return a copy of the string with the first letter capitalized.
 */
- (NSString *)toClassName;

/**
 * Perform basic substitution of given key -> value pairs
 * within this string.
 *
 *   [@"test string substitution" gsub:[NSDictionary withObjectsAndKeys:@"substitution", @"sub"]];
 *     //> @"test string sub"
 */
- (NSString *)gsub:(NSDictionary *)keyValues;

/*! Returns an UTF-8 string that contains EOL(\r\n). !*/
+ (NSString *) EOL; //double check these names

/*! Returns an UTF-8 string that contains CRLF(\r\n\r\n). !*/
+ (NSString *) CRLF;

/*! Returns a string from NSData content.  !*/
+ (NSString*) stringWithData: (NSData*) data encoding: (NSStringEncoding) encoding;

/*! Returns a string from a subset of NSData content.  !*/
+ (NSString*) stringWithData: (NSData*) data range: (NSRange) range encoding: (NSStringEncoding) encoding;

+ (NSString*) stringWithBytes: (const void*) bytes length: (NSUInteger) length encoding: (NSStringEncoding) encoding;

/*! Returns a string with the structure key separator value. !*/
+ (NSString*) stringWithValue: (NSString*) value key:(NSString*) key separator:(NSString*) sep;

/*! Returns a string structured like an HTTP header, using key and value. !*/
+ (NSString*) stringToHTTPHeaderWithKey: (NSString*) name value:(NSString*) value;

/*! If the string is longer than specified, returns a truncated copy (with Unicode ellipsis).  !*/
- (NSString*) stringTruncatedAfter: (NSUInteger) length;

/*! Returns the index of the charcater starting the first appearance of the argument, or NSNotFound if not present. !*/
- (NSUInteger) indexOfString: (NSString*) stringToFind;

/*! Returns true if the characters of the argument match the start of this string. !*/
- (BOOL) startsWithString: (NSString*) stringToMatch;

/*! Returns true if the characters of the argument match the end of this string. !*/
- (BOOL) endsWithString: (NSString*) stringToMatch;

/*! Returns true of the argument is included in this string. !*/
- (BOOL) containsString: (NSString*) stringToFind;

/*! URL-escapes the string as UTF-8 bytes. Not useful for escaping query string parameters.  !*/
- (NSString*) stringByAddingPercentEscapes;

/*! Wrapper for CFURLCreateStringByAddingPercentEscapes. !*/
- (NSString*) stringByAddingPercentEscapesUsingEncoding: (NSStringEncoding) encoding
									   leavingUnescaped: (NSString*) unescaped
										   alsoEscaping: (NSString*) escaped;

/*! URL-escapes the string as UTF-8 bytes for a query string parameter. !*/
- (NSString*) stringAsURLParameter;

@end

