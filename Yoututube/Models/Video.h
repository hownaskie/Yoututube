//
//  Video.h
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Channel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Video : NSObject

@property (nonatomic, strong) NSString *thumbnailImageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *numberOfViews;
@property (nonatomic, strong) NSDate *uploadDate;

@property (nonatomic, strong) Channel *channel;

@end

NS_ASSUME_NONNULL_END
