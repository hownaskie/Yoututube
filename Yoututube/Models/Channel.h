//
//  Channels.h
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Channel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *profileImageName;

@end

NS_ASSUME_NONNULL_END
