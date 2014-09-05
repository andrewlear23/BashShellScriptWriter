//
//  ALDragDropTextView.m
//  BashShellScriptWriter
//
//  Created by Andrew Lear on 05/09/2014.
//  Copyright (c) 2014 Andrew Lear. All rights reserved.
//

#import "ALDragDropTextView.h"

@implementation ALDragDropTextView


-(id)init {
    self = [super init];
    
    if (self) {
        // [self registerForDraggedTypes:@[(NSString *)kUTTypeItem]];
        
    }
    return self;
    
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    
    NSPasteboard *pb = [sender draggingPasteboard];
    NSDragOperation dragOperation = [sender draggingSourceOperationMask];
    
    if ([[pb types] containsObject:NSFilenamesPboardType]) {
        if (dragOperation & NSDragOperationCopy) {
            return NSDragOperationCopy;
        }
    }
    if ([[pb types] containsObject:NSPasteboardTypeString]) {
        if (dragOperation & NSDragOperationCopy) {
            return NSDragOperationCopy;
        }
    }
    
    return NSDragOperationNone;
    
}


-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    
    NSPasteboard *pb = [sender draggingPasteboard];
    
    if ( [[pb types] containsObject:NSFilenamesPboardType] ) {
        NSArray *filenames = [pb propertyListForType:NSFilenamesPboardType];
        
        for (NSString *filename in filenames) {
            NSStringEncoding encoding;
            NSError * error;
            NSString * fileContents = [NSString stringWithContentsOfFile:filename usedEncoding:&encoding error:&error];
            if (error) {
                // handle error
            }
            else {
                [self setString:fileContents];
            }
        }
        
    }
    
    else if ( [[pb types] containsObject:NSPasteboardTypeString] ) {
        NSString *draggedString = [pb stringForType:NSPasteboardTypeString];
        [self setString:draggedString];
    }
    
    return YES;
    
}

@end
