//
//  ImageService.m
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/6/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import "ImageService.h"

@implementation ImageService

+(NSString *) getUniqueIdentifier
{
    CFUUIDRef uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    return (__bridge NSString *)(uuidStr);
}

// user generated images are stored in the documents directory
+(UIImage *) loadImageFromDocumentsDirectory:(NSString *)imageUrl
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageUrl]];
    
    UIImage *image = [UIImage imageWithContentsOfFile:savedImagePath];
    
    return image;
}

// save user's image into the documents directory
+(NSString *) saveImageIntoDocumentsDirectory:(UIImage *)imageToSave
{
    imageToSave = [imageToSave imageByScalingProportionallyToSize:CGSizeMake(320, 480)];
    NSString *uniqueImageName = [self getUniqueIdentifier];
    
    uniqueImageName = [uniqueImageName stringByAppendingPathExtension:@"png"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",uniqueImageName]];
    NSData *imageData = UIImagePNGRepresentation(imageToSave);
    
    [imageData writeToFile:savedImagePath atomically:YES];
    
    return uniqueImageName;
}

@end
