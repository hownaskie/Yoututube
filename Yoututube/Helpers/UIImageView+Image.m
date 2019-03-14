//
//  UIImageView+Image.m
//  Yoututube
//
//  Created by JonasC on 09/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "UIImageView+Image.h"
#import <objc/runtime.h>

NSString *const kImageCacheProperty = @"kImageCacheProperty";

@implementation UIImageView (Image)

@dynamic imageCache;

- (void)setImageCache:(NSCache *)imageCache {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(kImageCacheProperty), imageCache, OBJC_ASSOCIATION_ASSIGN);
}

- (NSCache *)imageCache {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kImageCacheProperty));
}

- (void)loadImageUsingUrlString:(NSString *)stringUrl {
    NSURL *url = [NSURL URLWithString:stringUrl];
    
    self.image = nil;
    
    UIImage *imageFromCache = (UIImage *)[self.imageCache objectForKey:stringUrl];
    if(imageFromCache) {
        self.image = imageFromCache;
        return;
    }
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *imageToCache = [UIImage imageWithData:data];
            
            [self.imageCache setObject:imageToCache forKey:stringUrl];
            
            self.image = imageToCache;
        });
    }] resume];
}

@end
