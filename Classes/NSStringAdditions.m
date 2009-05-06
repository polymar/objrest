//  StringAdditions.m
//  SRD
//
//	Created by Roberto Gamboni.
//  Copyright 2009 YellowPages.com. All rights reserved.
//

#import "NSStringAdditions.h"

/*! Some additions to NSString. !*/
@implementation NSString (Openovo)

- (NSCharacterSet *)capitals {
	return [NSCharacterSet uppercaseLetterCharacterSet];
}

- (NSString *)deCamelizeWith:(NSString *)delimiter {
	
	unichar *buffer = calloc([self length], sizeof(unichar));
	[self getCharacters:buffer ];
	NSMutableString *underscored = [NSMutableString string];
	
	NSString *currChar;
	for (int i = 0; i < [self length]; i++) {
		currChar = [NSString stringWithCharacters:buffer+i length:1];
		if([[self capitals] characterIsMember:buffer[i]]) {
			[underscored appendFormat:@"%@%@", delimiter, [currChar lowercaseString]];
		} else {
			[underscored appendString:currChar];
		}
	}
	
	free(buffer);
	return underscored;
}

- (NSString *)dasherize {
	return [self deCamelizeWith:@"-"];
}

- (NSString *)underscore {
	return [self deCamelizeWith:@"_"];
}

- (NSCharacterSet *)camelcaseDelimiters {
	return [NSCharacterSet characterSetWithCharactersInString:@"-_"];
}

- (NSString *)camelize {
	
	unichar *buffer = calloc([self length], sizeof(unichar));
	[self getCharacters:buffer ];
	NSMutableString *underscored = [NSMutableString string];
	
	BOOL capitalizeNext = NO;
	NSCharacterSet *delimiters = [self camelcaseDelimiters];
	for (int i = 0; i < [self length]; i++) {
		NSString *currChar = [NSString stringWithCharacters:buffer+i length:1];
		if([delimiters characterIsMember:buffer[i]]) {
			capitalizeNext = YES;
		} else {
			if(capitalizeNext) {
				[underscored appendString:[currChar uppercaseString]];
				capitalizeNext = NO;
			} else {
				[underscored appendString:currChar];
			}
		}
	}
	
	free(buffer);
	return underscored;
}

- (NSString *)titleize {
	NSArray *words = [self componentsSeparatedByString:@" "];
	NSMutableString *output = [NSMutableString string];
	for (NSString *word in words) {
		[output appendString:[[word substringToIndex:1] uppercaseString]];
		[output appendString:[[word substringFromIndex:1] lowercaseString]];
		[output appendString:@" "];
	}
	return [output substringToIndex:[self length]];
}

- (NSString *)toClassName {
	return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) 
										 withString:[[self substringWithRange:NSMakeRange(0,1)] uppercaseString]];
}

- (NSString *)gsub:(NSDictionary *)keyValues {
	
	NSMutableString *subbed = [NSMutableString stringWithString:self];
	
	for (NSString *key in keyValues) {
		NSString *value = [NSString stringWithFormat:@"%@", [keyValues objectForKey:key]];
		NSArray *splits = [subbed componentsSeparatedByString:key];
		[subbed setString:[splits componentsJoinedByString:value]];
	}
	return subbed;
}

/*! Returns an UTF-8 string that contains EOL(\r\n). !*/
+ (NSString *) EOL {
	return @"\r\n";
}

/*! Returns an UTF-8 string that contains CRLF(\r\n\r\n). !*/
+ (NSString *) CRLF {
	return @"\r\n\r\n";
}

/*! Returns a string from NSData content.  !*/
+ (NSString*) stringWithData: (NSData*) data encoding: (NSStringEncoding) encoding
{
	return [[[self alloc] initWithData: data encoding: encoding] autorelease];
}

/*! Returns a string from a subset of NSData content.  !*/
+ (NSString*) stringWithData: (NSData*) data range: (NSRange) range encoding: (NSStringEncoding) encoding
{
	// Validate the range before we allocate a buffer to extract from the data.
	NSRange overlap = NSIntersectionRange(range, NSMakeRange(0, [data length]));
	if (!NSEqualRanges(range, overlap))
		[NSException raise: NSRangeException format: @"Range (%ud, %ud) outside data size %d", range.location, range.length, [data length]];
	UInt8 buffer[overlap.length];
	[data getBytes: buffer range: range];
	return [self stringWithBytes: buffer length: overlap.length encoding: encoding];
}

+ (NSString*) stringWithBytes: (const void*) bytes length: (NSUInteger) length encoding: (NSStringEncoding) encoding
{
	return [[[self alloc] initWithBytes: bytes length: length encoding: encoding] autorelease];
}

/*! Returns a string with the structure key separator value. !*/
+ (NSString*) stringWithValue: (NSString*) value key:(NSString*) key separator:(NSString*) sep {
	return [NSString stringWithFormat:@"%@%@ %@", key, sep, value];
}

/*! Returns a string structured like an HTTP header, using key and value. !*/
+ (NSString*) stringToHTTPHeaderWithKey: (NSString*) name value:(NSString*) value {
	NSString* header = [NSString stringWithValue:value key:name separator:@":"];
	return [header stringByAppendingString:[NSString EOL]];
}

/*! If the string is longer than specified, returns a truncated copy (with Unicode ellipsis).  !*/
- (NSString*) stringTruncatedAfter: (NSUInteger) length
{
	NSUInteger n = [self length];
	if (n <= length)
		return self;
	return [NSString stringWithFormat: @"%@%C", [self substringToIndex: length], 0x2026];
}

/*! Returns the index of the charcater starting the first appearance of the argument, or NSNotFound if not present. !*/
- (NSUInteger) indexOfString: (NSString*) stringToFind
{
	NSRange range = [self rangeOfString: stringToFind];
	return range.location;
}

/*! Returns true if the characters of the argument match the start of this string. !*/
- (BOOL) startsWithString: (NSString*) stringToMatch
{
	NSRange range = [self rangeOfString: stringToMatch options: NSAnchoredSearch];
	return (range.location != NSNotFound);
}

/*! Returns true if the characters of the argument match the end of this string. !*/
- (BOOL) endsWithString: (NSString*) stringToMatch
{
	NSRange range = [self rangeOfString: stringToMatch options: NSAnchoredSearch | NSBackwardsSearch];
	return (range.location != NSNotFound);
}


/*! Returns true of the argument is included in this string. !*/
- (BOOL) containsString: (NSString*) stringToFind
{
	NSRange range = [self rangeOfString: stringToFind];
	return range.location != NSNotFound;
}

/*! URL-escapes the string as UTF-8 bytes. !*/
- (NSString*) stringByAddingPercentEscapes
{
	return [self stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

/*! Wrapper for CFURLCreateStringByAddingPercentEscapes. !*/
- (NSString*) stringByAddingPercentEscapesUsingEncoding: (NSStringEncoding) encoding
									   leavingUnescaped: (NSString*) unescaped
										   alsoEscaping: (NSString*) escaped
{
	return (NSString*) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) self, 
															   (CFStringRef) unescaped, (CFStringRef) escaped, 
															   CFStringConvertNSStringEncodingToEncoding(encoding));
}

/*! URL-escapes the string as UTF-8 bytes for a query string parameter. !*/
- (NSString*) stringAsURLParameter
{
	// The base routine doesn't encode legal URL characters like &, ?, etc. 
	// that do need to be escaped as a URL query string parameter or path element.
	NSString* escapes = @"/?:&=+";  // RFC 2396 also includes ";@$,", but I don't know of URLs that use those.
	// Do it as a two-step, so that we get + instead of %20.
	NSString* temp = [self stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding leavingUnescaped: @" " alsoEscaping: escapes];
	temp = [temp stringByReplacingOccurrencesOfString: @" " withString: @"+"];
	return temp;
}

@end
