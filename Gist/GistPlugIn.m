//
//  GistPlugIn.m
//  Gist
//
//  Created by Daniel Tull on 11.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "GistPlugIn.h"
#import "GistURLFormatter.h"


@implementation GistPlugIn

@synthesize gistID = _gistID;

+ (NSArray *)plugInKeys {
    return [NSArray arrayWithObject:@"gistID"];
}

- (void)awakeFromNew {
    [super awakeFromNew];
    
    // Get the address from the browser
    id <SVPasteboardItem> browserAddress = [[NSWorkspace sharedWorkspace] fetchBrowserWebLocation];
    
    if (!browserAddress) {
        return;
    }
    
    NSString *candidateURLString = [[browserAddress URL] absoluteString];
    
    GistURLFormatter *formatter = [[GistURLFormatter alloc] init];
    
    NSString *theGistId = nil;
    
    BOOL isValidGistId = [formatter getObjectValue:&theGistId forString:candidateURLString errorDescription:NULL];
    [formatter release];
    
    if (!isValidGistId) {
        return;
    }
    
    self.gistID = theGistId;
    
}

- (NSString *)placeholderString {
    // This is what will show if the plug-in's HTML cannot be displayed
    if (!self.gistID) {
        return @"Enter a Gist ID in the Inspector";
    }
    return [@"gist: " stringByAppendingString:self.gistID];
}

- (void)writeHTML:(id<SVPlugInContext>)context {
    [super writeHTML:context];

    // add dependencies
    [context addDependencyForKeyPath:@"gistID" ofObject:self];
    
    NSString *string = [NSString stringWithFormat:@"http://gist.github.com/%@.js", self.gistID];
    [context writeJavascriptWithSrc:string encoding:NSUTF8StringEncoding];
                
    // For browsers/environments without javascript, link to the gist
    [context startElement:@"noscript"];
    {
        string = [NSString stringWithFormat:@"https://gist.github.com/%@", self.gistID];
        [context startAnchorElementWithHref:string title:nil target:nil rel:nil];
        {
            [context writeCharacters:[@"gist: " stringByAppendingString:self.gistID]];
        }
        [context endElement];
        }
    [context endElement];
}

- (void)makeOriginalSize;
{
    // Generally want to fill the space available with out content
    [self setWidth:nil height:nil];
}

- (void)dealloc {
	[gistID release], gistID = nil;
	[super dealloc];
}

#pragma mark - Drag and drop

+ (NSArray *)readableTypesForPasteboard:(NSPasteboard *)pasteboard {
    // Just get the URL types
    return [self readableURLTypesForPasteboard:pasteboard];
}

+ (SVPasteboardPriority)priorityForPasteboardItem:(id<SVPasteboardItem>)item {
    // We're only interested in URLs from gist.github.com
    if (![item URL] || [[item URL] isFileURL]) {
        return [super priorityForPasteboardItem:item];
    }
    
    NSString *hostString = [[item URL] host];
    if (!hostString || !([hostString caseInsensitiveCompare:@"gist.github.com"] == NSOrderedSame)) {
        return SVPasteboardPriorityNone;
    }
    
    return SVPasteboardPrioritySpecialized;    
}

- (BOOL)awakeFromPasteboardItems:(NSArray *)items {
    if (!items && ![items count]) {
        return NO;
    }
    
    id <SVPasteboardItem> item = [items objectAtIndex:0];
    if (![item respondsToSelector:@selector(URL)]) {
        return NO;
    }
    
    NSString *theGistId = nil;
    GistURLFormatter *formatter = [[GistURLFormatter alloc] init];
    
    BOOL isValidGistId = [formatter getObjectValue:&theGistId forString:[[item URL] absoluteString] errorDescription:NULL];
    [formatter release];
    
    if (!isValidGistId) {
        return NO;
    }
    
    self.gistID = theGistId;
    return YES;

}

@end
