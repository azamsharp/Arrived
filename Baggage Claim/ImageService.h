//
//  ImageService.h
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/6/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImage+Extensions.h"

@interface ImageService : NSObject

+(NSString *) saveImageIntoDocumentsDirectory:(UIImage *) imageToSave;
+(NSString *)loadImageFromDocumentsDirectory:(NSString *)imageUrl;

@end
