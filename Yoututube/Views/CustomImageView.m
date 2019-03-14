//
//  CustomImageView.m
//  Yoututube
//
//  Created by JonasC on 12/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "CustomImageView.h"

@interface CustomImageView ()

@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, strong) NSString *imageUrlString;

@end

@implementation CustomImageView

- (NSCache *)imageCache {
    if(!_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache;
}

- (void)loadImageUsingUrlString:(NSString *)stringUrl {
    self.imageUrlString = stringUrl;
    
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
            
            if([self.imageUrlString isEqualToString:stringUrl]) {
                self.image = imageToCache;
            }
            
            [self.imageCache setObject:imageToCache forKey:stringUrl];
        });
    }] resume];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
